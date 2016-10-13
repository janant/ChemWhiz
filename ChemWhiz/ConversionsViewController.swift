//
//  ConversionsViewController.swift
//  ChemWhiz
//
//  Created by Anant Jain on 5/30/16.
//  Copyright © 2016 Anant Jain. All rights reserved.
//

import UIKit

class ConversionsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate, UIViewControllerTransitioningDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var conversionsTableView: UITableView!
    var inputQtyTextField: UITextField!
    var inputUnitsLabel: UILabel!
    var inputChemicalTextField: UITextField!
    
    var inputUnitsPicker: UIPickerView!
    var outputUnitsPicker: UIPickerView!
    
    var molarMass = 0.0
    var formula = String()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func pressedConvertButton(_ sender: AnyObject) {
        self.view.endEditing(true)
        if Double(inputQtyTextField.text!) != nil {
            guard let formula = inputChemicalTextField.text else {
                let errorAlert = UIAlertController(title: "Error", message: "Please enter a valid formula.", preferredStyle: .alert)
                errorAlert.addAction(UIAlertAction(title: "Done", style: .default, handler: nil))
                self.present(errorAlert, animated: true, completion: nil)
                return
            }
            
            DispatchQueue.global(qos: DispatchQoS.QoSClass.userInitiated).async {
                let data = MolarMassCalculator.elements(fromFormula: formula)
                if let error = data["Error"] as? String {
                    DispatchQueue.main.async(execute: { () -> Void in
                        let errorAlert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
                        errorAlert.addAction(UIAlertAction(title: "Done", style: .default, handler: nil))
                        self.present(errorAlert, animated: true, completion: nil)
                    })
                }
                else {
                    DispatchQueue.main.async(execute: { () -> Void in
                        self.molarMass = MolarMassCalculator.molarMass(fromElements: data)
                        if let formula = data["Formula"] as? String {
                            self.formula = formula
                        }
                        
                        self.performSegue(withIdentifier: "Convert Segue", sender: sender)
                    })
                }
            }
        }
        else {
            let errorAlert = UIAlertController(title: "Error", message: "Please enter a valid quantity to convert.", preferredStyle: .alert)
            errorAlert.addAction(UIAlertAction(title: "Done", style: .default, handler: nil))
            self.present(errorAlert, animated: true, completion: nil)
        }
    }
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 3
        case 1:
            return 2
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell!
        
        if (indexPath as NSIndexPath).section == 0 {
            switch (indexPath as NSIndexPath).row {
            case 0:
                cell = tableView.dequeueReusableCell(withIdentifier: "Input Cell", for: indexPath)
                
                inputQtyTextField = cell.viewWithTag(1) as! UITextField
                inputUnitsLabel = cell.viewWithTag(2) as! UILabel
                
                // Creates, configures, and adds an accessory toolbar to dismiss the keyboard
                let inputQtyAccessoryToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 10, height: 44))
                inputQtyAccessoryToolbar.barStyle = .black
                let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: inputQtyTextField, action: #selector(resignFirstResponder))
                doneButton.tintColor = UIColor(red: 114/255.0, green: 202/255.0, blue: 200/255.0, alpha: 1.0)
                inputQtyAccessoryToolbar.items = [UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil), doneButton]
                inputQtyTextField.inputAccessoryView = inputQtyAccessoryToolbar
                
                // Sets placeholder text to appropriate color
                inputQtyTextField.attributedPlaceholder = NSAttributedString(string: "Enter quantity...", attributes: [NSForegroundColorAttributeName: UIColor.gray])
                
            case 1:
                cell = tableView.dequeueReusableCell(withIdentifier: "Units Cell", for: indexPath)
                
                inputUnitsPicker = cell.viewWithTag(1) as? UIPickerView
                
            case 2:
                cell = tableView.dequeueReusableCell(withIdentifier: "Chemical Cell", for: indexPath)
                
                inputChemicalTextField = cell.viewWithTag(1) as! UITextField
                
                // Creates, configures, and adds an accessory toolbar to dismiss the keyboard
                let inputQtyAccessoryToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 10, height: 44))
                inputQtyAccessoryToolbar.barStyle = .black
                let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: inputChemicalTextField, action: #selector(resignFirstResponder))
                doneButton.tintColor = UIColor(red: 114/255.0, green: 202/255.0, blue: 200/255.0, alpha: 1.0)
                inputQtyAccessoryToolbar.items = [UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil), doneButton]
                inputChemicalTextField.inputAccessoryView = inputQtyAccessoryToolbar
                
                // Sets placeholder text to appropriate color
                inputChemicalTextField.attributedPlaceholder = NSAttributedString(string: "Enter chemical formula...", attributes: [NSForegroundColorAttributeName: UIColor.gray])
                
            default:
                return UITableViewCell()
            }
        }
        else if (indexPath as NSIndexPath).section == 1 {
            switch (indexPath as NSIndexPath).row {
            case 0:
                cell = tableView.dequeueReusableCell(withIdentifier: "Units Cell", for: indexPath)
                
                outputUnitsPicker = cell.viewWithTag(1) as? UIPickerView
                outputUnitsPicker.selectRow(1, inComponent: 0, animated: false)
                
            case 1:
                cell = tableView.dequeueReusableCell(withIdentifier: "Convert Button Cell", for: indexPath)
            default:
                return UITableViewCell()
            }
        }
        else {
            return UITableViewCell()
        }
        
        cell.backgroundColor = cell.contentView.backgroundColor
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Input"
        case 1:
            return "Convert To"
        default:
            return nil
        }
    }
    
    // MARK: - Table view delegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch (indexPath as NSIndexPath).section {
        case 0:
            switch (indexPath as NSIndexPath).row {
            case 0:
                return 44
            case 1:
                return 109
            case 2:
                return 44
            default:
                return 0
            }
        case 1:
            switch (indexPath as NSIndexPath).row {
            case 0:
                return 109
            case 1:
                return 80
            default:
                return 0
            }
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let header = view as? UITableViewHeaderFooterView {
            header.textLabel?.textColor = UIColor.white
        }
    }
    
    // MARK: - Picker view data source
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 4
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let attributes = [NSForegroundColorAttributeName: UIColor.white]
        
        switch row {
        case 0:
            return NSAttributedString(string: "grams", attributes: attributes)
        case 1:
            return NSAttributedString(string: "moles", attributes: attributes)
        case 2:
            return NSAttributedString(string: "particles", attributes: attributes)
        case 3:
            return NSAttributedString(string: "liters", attributes: attributes)
        default:
            return NSAttributedString(string: "", attributes: attributes)
        }
    }
    
    // MARK: - Picker view delegate
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == inputUnitsPicker {
            let rowTitle = self.pickerView(pickerView, attributedTitleForRow: pickerView.selectedRow(inComponent: 0), forComponent: 0)?.string
            inputUnitsLabel.text = rowTitle
        }
    }
    
    // MARK: - Transitioning delegate protocol methods
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if presented is ConversionResultTableViewController {
            return SlideUpTransition(presenting: true)
        }
        return nil
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if dismissed is ConversionResultTableViewController {
            return SlideUpTransition(presenting: false)
        }
        return nil
    }
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        if presented is ConversionResultTableViewController {
            return SlideUpPresentation(presentedViewController: presented, presenting: presenting)
        }
        return nil
    }
    
    // MARK: - Text field delegate methods
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
        
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "Convert Segue" {
            if let conversionResultTVC = segue.destination as? ConversionResultTableViewController {
                conversionResultTVC.qty = self.inputQtyTextField.text!
                conversionResultTVC.formula = self.formula
                conversionResultTVC.molarMass = self.molarMass
                conversionResultTVC.inputUnits = ConversionUnit(rawValue: inputUnitsPicker.selectedRow(inComponent: 0))
                conversionResultTVC.outputUnits = ConversionUnit(rawValue: outputUnitsPicker.selectedRow(inComponent: 0))
                
                conversionResultTVC.modalPresentationStyle = .custom
                conversionResultTVC.transitioningDelegate = self
            }
        }
    }
}
