//
//  MolarMassViewController.swift
//  ChemWhiz
//
//  Created by Anant Jain on 11/26/15.
//  Copyright © 2015 Anant Jain. All rights reserved.
//

import UIKit

class MolarMassViewController: UIViewController, UIViewControllerTransitioningDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var showWorkButton: UIButton!
    
    @IBOutlet weak var answerView: UIView!
    @IBOutlet weak var mainStackView: UIStackView!
    @IBOutlet weak var inputStackView: UIStackView!
    
    @IBOutlet weak var calculateButton: UIButton!
    
    var resultsData: [String: Any]?
    var answer = 0.0

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func calculateMolarMass(_ sender: AnyObject) {
        
        self.view.endEditing(true)
        
        guard let formula = inputTextField.text else {
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
                self.resultsData = data
                
                DispatchQueue.main.async(execute: { () -> Void in
                    self.answer = MolarMassCalculator.molarMass(fromElements: data)
                    self.answerLabel.text = String(format: "%.2f", self.answer)
                    
                    UIView.transition(with: self.showWorkButton, duration: 0.25, options: .transitionCrossDissolve, animations: { () -> Void in
                        self.showWorkButton.isHidden = false
                        }, completion: nil)
                    
                    UIView.animate(withDuration: 0.25, animations: { () -> Void in
                        self.answerView.alpha = 1.0
                        }, completion: { (completed) -> Void in
                            self.answerView.isUserInteractionEnabled = true
                    })
                })
            }
        }
    }
    
    @IBAction func copyAnswer(_ sender: AnyObject) {
        UIPasteboard.general.string = String(format: "%.2f", answer)
    }
    
    @IBAction func shareResult(_ sender: AnyObject) {
        
        guard
            resultsData != nil,
            let formula = resultsData!["Formula"] as? String,
            let button = sender as? UIButton
        else {
            return
        }
        
        let shareData = String(format: "The molar mass of \(formula) is %.2f", answer)
        let activityVC = UIActivityViewController(activityItems: [shareData], applicationActivities: nil)
        activityVC.modalPresentationStyle = .popover
        if let popoverPresentation = activityVC.popoverPresentationController {
            popoverPresentation.sourceView = button
        }
        
        present(activityVC, animated: true, completion: nil)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate(alongsideTransition: nil) { (context) -> Void in
            if self.traitCollection.verticalSizeClass == .compact && self.inputTextField.isFirstResponder {
                let frame = self.view.convert(self.mainStackView.convert(self.inputTextField.frame, from: self.inputStackView), from: self.mainStackView)
                UIView.animate(withDuration: 0.3) { () -> Void in
                    self.inputTextField.transform = CGAffineTransform(translationX: self.view.frame.midX - frame.midX, y: 80 - frame.midY)
                }
            }
            else {
                UIView.animate(withDuration: 0.3) { () -> Void in
                    self.inputTextField.transform = CGAffineTransform.identity
                }
            }
        }
    }
    
    // MARK: - Text field delegate methods
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.3) { () -> Void in
            textField.transform = CGAffineTransform.identity
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if traitCollection.verticalSizeClass == .compact {
            let frame = self.view.convert(self.mainStackView.convert(inputTextField.frame, from: inputStackView), from: mainStackView)
            print(frame)
            UIView.animate(withDuration: 0.3) { () -> Void in
                self.inputTextField.transform = CGAffineTransform(translationX: self.view.frame.midX - frame.midX, y: 80 - frame.midY)
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    // MARK: - Transitioning delegate methods
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if let navVC = presented as? UINavigationController {
            if let _ = navVC.viewControllers[0] as? ExamplesViewController {
                return SlideFromLeftTransition(presenting: true)
            }
            else if let _ = navVC.viewControllers[0] as? ShowWorkViewController {
                return GrowTransition(presenting: true, initialFrame: self.view.convert(answerView.frame, from: mainStackView))
            }
        }
        
        return nil
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if let navVC = dismissed as? UINavigationController {
            if let _ = navVC.viewControllers[0] as? ExamplesViewController {
                return SlideFromLeftTransition(presenting: false)
            }
            else if let _ = navVC.viewControllers[0] as? ShowWorkViewController {
                return GrowTransition(presenting: false, initialFrame: self.view.convert(answerView.frame, from: mainStackView))
            }
        }
        
        return nil
    }
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        if let navVC = presented as? UINavigationController {
            if let _ = navVC.viewControllers[0] as? ExamplesViewController {
                return SlideFromLeftPresentation(presentedViewController: presented, presenting: presenting)
            }
            else if let _ = navVC.viewControllers[0] as? ShowWorkViewController {
                return GrowPresentation(presentedViewController: presented, presenting: presenting)
            }
        }
        
        return nil
    }
    
    @IBAction func swipedFromLeftEdge(_ sender: AnyObject) {
        performSegue(withIdentifier: "Examples", sender: nil)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "Examples" {
            let navVC = segue.destination as! UINavigationController
            navVC.transitioningDelegate = self
            navVC.modalPresentationStyle = .custom
        }
        else if segue.identifier == "Show Work" {
            guard
                let navVC = segue.destination as? UINavigationController,
                let showWorkVC = navVC.topViewController as? ShowWorkViewController
            else {
                return
            }
            navVC.transitioningDelegate = self
            navVC.modalPresentationStyle = .custom
            
            showWorkVC.resultsData = resultsData
            showWorkVC.answer = answer
        }
    }
    
    @IBAction func closeExamples(_ segue: UIStoryboardSegue) {
        
    }
    
    @IBAction func closeShowWork(_ segue: UIStoryboardSegue) {
        
    }

}
