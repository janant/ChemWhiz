//
//  ElementDetailViewController.swift
//  ChemWhiz
//
//  Created by Anant Jain on 5/31/16.
//  Copyright © 2016 Anant Jain. All rights reserved.
//

import UIKit

class ElementDetailViewController: UIViewController {
    
    var elementData: [String: AnyObject]?

    @IBOutlet weak var selectElementLabel: UILabel!
    @IBOutlet weak var mainStackView: UIStackView!
    
    @IBOutlet weak var elementSymbolLabel: UILabel!
    @IBOutlet weak var elementNameLabel: UILabel!
    @IBOutlet weak var elementNumberLabel: UILabel!
    @IBOutlet weak var elementMassLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Hides and shows views if data is available.
        if elementData == nil {
            mainStackView.isHidden = true
        }
        else {
            selectElementLabel.isHidden = true
            
            let shareButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareElement))
            self.navigationItem.rightBarButtonItem = shareButton
        }
        
        // Gets data and displays it in the labels.
        guard
            let data = elementData,
        
            let elementSymbol = data["Symbol"] as? String,
            let elementName = data["Name"] as? String,
            let elementNumber = data["Number"] as? Int,
            let elementMass = data["Mass"] as? Double
        else {
            return
        }
        elementSymbolLabel.text = elementSymbol
        elementNameLabel.text = elementName
        elementNumberLabel.text = "\(elementNumber)"
        elementMassLabel.text = String(format: "%.2f g/mol", elementMass)
        
        // Adds a white rounded rectangle border around the element symbol.
        elementSymbolLabel.layer.cornerRadius = 8
        elementSymbolLabel.layer.borderColor = UIColor.white.cgColor
        elementSymbolLabel.layer.borderWidth = 2.5
        
        // Sets navigation bar title to the element name
        // Currently commented out due to a graphical glitch in UISplitViewController
        // that has yet to be fixed by Apple.
        // self.navigationItem.title = elementName
    }
    
    func shareElement() {
        guard
            let data = elementData,
            let elementSymbol = data["Symbol"] as? String,
            let elementName = data["Name"] as? String,
            let elementNumber = data["Number"] as? Int,
            let elementMass = data["Mass"] as? Double
        else {
                return
        }
        
        let shareData = String(format: "Check out \(elementName) (\(elementSymbol))! It has an atomic number of %d and an atomic mass of %.2f g/ml", elementNumber, elementMass)
        
        let activityVC = UIActivityViewController(activityItems: [shareData], applicationActivities: nil)
        activityVC.modalPresentationStyle = .popover
        activityVC.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem
        present(activityVC, animated: true, completion: nil)
    }

}
