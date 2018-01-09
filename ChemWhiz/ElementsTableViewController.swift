//
//  ElementsTableViewController.swift
//  ChemWhiz
//
//  Created by Anant Jain on 5/31/16.
//  Copyright © 2016 Anant Jain. All rights reserved.
//

import UIKit

class ElementsTableViewController: UITableViewController, UISearchResultsUpdating {
    
    var elementsData = [[String: AnyObject]]()
    var filteredElementsData = [[String: AnyObject]]()
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Deselect selected row when the view appears
        if let selectedIndex = self.tableView.indexPathForSelectedRow {
            self.tableView.deselectRow(at: selectedIndex, animated: true)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Loads element data from plist
        if let stringPath = Bundle.main.path(forResource: "Chemical Symbols", ofType: "plist") {
            if let data = NSDictionary(contentsOfFile: stringPath) as? [String: [String: AnyObject]] {
                let valuesData = [[String: AnyObject]](data.values)
                elementsData = valuesData.sorted(by: { (first, second) -> Bool in
                    guard
                        let firstAtomicNumber = first["Number"] as? Int,
                        let secondAtomicNumber = second["Number"] as? Int
                    else {
                        return false
                    }
                    
                    return firstAtomicNumber < secondAtomicNumber
                })
            }
        }
        
        // Configures search controller
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchResultsUpdater = self
        
        // Adds the search bar to the UI
        if #available(iOS 11.0, *) {
            self.navigationItem.searchController = searchController
        } else {
            self.tableView.tableHeaderView = searchController.searchBar
        }
        
        // Configures search bar
        searchController.searchBar.keyboardAppearance = .dark
        searchController.searchBar.searchBarStyle = .minimal
        searchController.searchBar.barStyle = .black
        
        // Sets background view of table view so out of bounds scrolling is appropriately colored
        let backgroundView = UIView()
        backgroundView.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        backgroundView.backgroundColor = #colorLiteral(red: 0.1963741987, green: 0.1963741987, blue: 0.1963741987, alpha: 1)
        self.tableView.backgroundView = backgroundView
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let searchText = searchController.searchBar.text else {
            return elementsData.count
        }
        
        if searchText.count == 0 {
            return elementsData.count
        }
        else {
            return filteredElementsData.count
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Gets appropriate element data
        let elementInfo: [String: AnyObject]!
        
        if let searchText = searchController.searchBar.text {
            if searchText.count == 0 {
                elementInfo = elementsData[(indexPath as NSIndexPath).row]
            }
            else {
                elementInfo = filteredElementsData[(indexPath as NSIndexPath).row]
            }
        }
        else {
            elementInfo = elementsData[(indexPath as NSIndexPath).row]
        }
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "Element Cell", for: indexPath)
        
        guard
            let elementSymbolLabel = cell.viewWithTag(1) as? UILabel,
            let elementNameLabel = cell.viewWithTag(2) as? UILabel,
            let elementNumberLabel = cell.viewWithTag(3) as? UILabel,
            let elementMassLabel = cell.viewWithTag(4) as? UILabel,
        
            let elementSymbol = elementInfo["Symbol"] as? String,
            let elementName = elementInfo["Name"] as? String,
            let elementNumber = elementInfo["Number"] as? Int,
            let elementMass = elementInfo["Mass"] as? Double
        else {
            return cell
        }
        
        // Sets text of labels
        elementSymbolLabel.text = elementSymbol
        elementNameLabel.text = elementName
        elementNumberLabel.text = "\(elementNumber)"
        elementMassLabel.text = String(format: "%.2f", elementMass)
        
        // Draws a rounded white rectangle around element symbol label
        elementSymbolLabel.layer.borderColor = UIColor.white.cgColor
        elementSymbolLabel.layer.borderWidth = 1.2
        elementSymbolLabel.layer.cornerRadius = 4

        // Sets background selected color of the cells
        let selectedBackgroundView = UIView()
        selectedBackgroundView.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.35)
        cell.selectedBackgroundView = selectedBackgroundView
        cell.backgroundColor = cell.contentView.backgroundColor

        return cell
    }
    
    // MARK: - Search controller updating delegate methods
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else {
            return
        }
        
        filteredElementsData = [[String: AnyObject]]()
        
        if searchText.count == 0 {
            self.tableView.reloadData()
            return
        }
        
        for element in elementsData {
            if let elementName = element["Name"] as? String {
                if elementName.lowercased().contains(searchText.lowercased()) {
                    filteredElementsData.append(element)
                }
            }
        }
        
        self.tableView.reloadData()
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "Show Element Detail" {
            guard
                let cell = sender as? UITableViewCell,
                let indexPath = self.tableView.indexPath(for: cell)
            else {
                return
            }
            
            if let navVC = segue.destination as? UINavigationController {
                if let elementDetailVC = navVC.topViewController as? ElementDetailViewController {
                    if let searchText = searchController.searchBar.text {
                        if searchText.count == 0 {
                            elementDetailVC.elementData = elementsData[(indexPath as NSIndexPath).row]
                        }
                        else {
                            elementDetailVC.elementData = filteredElementsData[(indexPath as NSIndexPath).row]
                        }
                    }
                    else {
                        elementDetailVC.elementData = elementsData[(indexPath as NSIndexPath).row]
                    }
                    
                    elementDetailVC.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                    elementDetailVC.navigationItem.leftItemsSupplementBackButton = true
                }
            }
            
            self.searchController.isActive = false
        }
    }
    

}
