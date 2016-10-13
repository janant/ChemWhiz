//
//  TodayViewController.swift
//  Molar Mass Calculator
//
//  Created by Anant Jain on 12/15/15.
//  Copyright © 2015 Anant Jain. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
    
    @IBOutlet weak var calculateButton: UIButton!
    @IBOutlet weak var answerStackView: UIStackView!
    
    @IBOutlet weak var inputLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if calculateButton.isHidden && !answerStackView.isHidden {
            calculateButton.isHidden = false
            answerStackView.isHidden = true
            
            calculateButton.alpha = 1.0
            answerStackView.alpha = 0.0
        }
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view from its nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func widgetPerformUpdate(completionHandler: @escaping (NCUpdateResult) -> Void) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        completionHandler(.newData)
    }
    
    func widgetMarginInsets(forProposedMarginInsets defaultMarginInsets: UIEdgeInsets) -> UIEdgeInsets {
        return defaultMarginInsets
    }
    
    @IBAction func calculateMolarMass(_ sender: AnyObject) {
        
        if let pasteboardText = UIPasteboard.general.string {
            inputLabel.text = pasteboardText
        }
        
        guard let input = self.inputLabel.text else {
            inputLabel.text = "N/A"
            answerLabel.text = "0.00"
            
            self.showAnswer()
            
            return
        }
        
        let data = MolarMassCalculator.elements(fromFormula: input)
        if let _ = data["Error"] as? String {
            answerLabel.text = "N/A"
            self.showAnswer()
        }
        else {
            DispatchQueue.main.async(execute: { () -> Void in
                self.answerLabel.text = "\(MolarMassCalculator.molarMass(fromElements: data))"
                
                self.showAnswer()
            })
        }
    }
    
    func showAnswer() {
        UIView.animate(withDuration: 0.25, animations: { 
            self.calculateButton.alpha = 0.0
            self.answerStackView.alpha = 1.0
            }) { (completed) in
                self.calculateButton.isHidden = true
                self.answerStackView.isHidden = false
        }
    }
}
