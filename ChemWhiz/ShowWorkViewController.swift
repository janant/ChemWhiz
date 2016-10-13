//
//  ShowWorkViewController.swift
//  ChemWhiz
//
//  Created by Anant Jain on 11/28/15.
//  Copyright © 2015 Anant Jain. All rights reserved.
//

import UIKit

class ShowWorkViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var showWorkTable: UITableView!
    
    var resultsData: [String: Any]!
    var answer: Double?
    
    var elements: [String]!
    
    let chemicalSymbolData: [String: [String: AnyObject]] = {
        guard
            let filePath = Bundle.main.path(forResource: "Chemical Symbols", ofType: "plist"),
            let rawDictData = NSDictionary(contentsOfFile: filePath),
        let data = rawDictData as? [String: [String: AnyObject]]
        else {
            return [String: [String: AnyObject]]()
        }
        
        return data
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        elements = [String](resultsData.keys)
        
        elements.remove(at: elements.index(of: "Formula")!)
        
        elements.sort { (first, second) -> Bool in
            guard
                let firstData = chemicalSymbolData[first],
                let secondData = chemicalSymbolData[second],
                let firstNumber = firstData["Number"] as? Int,
                let secondNumber = secondData["Number"] as? Int
            else {
                return true
            }
            
            return firstNumber < secondNumber
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return resultsData.count - 1
        case 1:
            return 1
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Atoms and Total Masses"
        case 1:
            return "Total Mass"
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell!
        if (indexPath as NSIndexPath).section == 0 {
            cell = tableView.dequeueReusableCell(withIdentifier: "Work Cell", for: indexPath)
            
            let nameLabel = cell.viewWithTag(1) as? UILabel
            let qtyLabel = cell.viewWithTag(2) as? UILabel
            let molarMassLabel = cell.viewWithTag(3) as? UILabel
            let totalMassLabel = cell.viewWithTag(4) as? UILabel
            let symbolLabel = cell.viewWithTag(6) as? UILabel
            
            let element = elements[(indexPath as NSIndexPath).row]
            guard
                let data = chemicalSymbolData[element],
                let mass = data["Mass"] as? Double,
                let qty = resultsData[element] as? Int
            else {
                    return cell
            }
            
            symbolLabel?.text = element
            nameLabel?.text = data["Name"] as? String
            qtyLabel?.text = "Quantity: \(qty)"
            molarMassLabel?.text = String(format: "Mass: %.2f g/mol", mass)
            totalMassLabel?.text = String(format: "%.2f", mass * Double(qty))
            
            symbolLabel?.layer.borderWidth = 1;
            symbolLabel?.layer.cornerRadius = 4;
            symbolLabel?.layer.borderColor = UIColor.white.cgColor
            symbolLabel?.layer.masksToBounds = true;
        }
        else {
            cell = tableView.dequeueReusableCell(withIdentifier: "Answer Cell", for: indexPath)
            let inputLabel = cell.viewWithTag(1) as? UILabel
            let answerLabel = cell.viewWithTag(2) as? UILabel
            
            inputLabel?.text = resultsData["Formula"] as? String
            answerLabel?.text = String(format: "%.2f", answer!)
        }
                
        cell.isUserInteractionEnabled = false
        cell.backgroundColor = nil
        return cell
    }
    
    // MARK: - Table view delegate methods
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let header = view as? UITableViewHeaderFooterView {
            header.textLabel?.textColor = UIColor.white
        }
    }

}
