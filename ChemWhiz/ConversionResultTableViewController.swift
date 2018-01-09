//
//  ConversionResultTableViewController.swift
//  ChemWhiz
//
//  Created by Anant Jain on 5/31/16.
//  Copyright © 2016 Anant Jain. All rights reserved.
//

import UIKit

enum ConversionUnit: Int {
    case grams
    case moles
    case particles
    case liters
}

class ConversionResultTableViewController: UITableViewController {
    
    var qty: String?
    var formula: String?
    var molarMass: Double?
    
    var inputUnits: ConversionUnit!
    var outputUnits: ConversionUnit!
    
    @IBOutlet weak var inputQtyUnitsLabel: UILabel!
    @IBOutlet weak var formulaLabel: UILabel!
    @IBOutlet weak var outputQtyLabel: UILabel!
    @IBOutlet weak var outputUnitsLabel: UILabel!
    
    @IBOutlet weak var conversionResultsCell: UITableViewCell!
    @IBOutlet weak var doneButtonCell: UITableViewCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        // Sets background selected color of the done button
        let doneButtonCellSelectedBackgroundView = UIView()
        doneButtonCellSelectedBackgroundView.backgroundColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 0.25)
        doneButtonCell.selectedBackgroundView = doneButtonCellSelectedBackgroundView
        
        // Removes cell background views
        conversionResultsCell.backgroundView = nil
        doneButtonCell.backgroundView = nil
        
        guard
            let qty = self.qty,
            let formula = self.formula,
            let molarMass = self.molarMass
        else {
            return
        }
        
        inputQtyUnitsLabel.text = "\(qty) \(unitNameForConversionUnit(inputUnits))"
        formulaLabel.text = "\(formula) (\(molarMass) g/mol)"
        outputUnitsLabel.text = unitNameForConversionUnit(outputUnits)
        
        if outputUnits == .particles {
            outputQtyLabel.text = String(format: "%.4g", calculate())
        }
        else {
            outputQtyLabel.text = String(format: "%.3f", calculate())
        }
        
        doneButtonCell.backgroundColor = doneButtonCell.contentView.backgroundColor
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath as NSIndexPath).section == 0 && (indexPath as NSIndexPath).row == 1 {
            dismiss(animated: true, completion: nil)
            self.tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    func unitNameForConversionUnit(_ unit: ConversionUnit) -> String {
        switch unit {
        case .grams:
            return "gram(s)"
        case .moles:
            return "mole(s)"
        case .particles:
            return "particle(s)"
        case .liters:
            return "liter(s)"
        }
    }
    
    func calculate() -> Double {
        guard
            let qty = self.qty,
            let molarMass = self.molarMass
        else {
            return 0.0
        }
        
        var answer: Double = Double(qty)!
        switch inputUnits! {
        case .grams:
            answer /= molarMass
        case .moles:
            break
        case .particles:
            answer /= 6.02e23
        case .liters:
            answer /= 22.4
        }
        
        switch outputUnits! {
        case .grams:
            answer *= molarMass
        case .moles:
            break
        case .particles:
            answer *= 6.02e23
        case .liters:
            answer *= 22.4
        }
        
        return answer
    }

}
