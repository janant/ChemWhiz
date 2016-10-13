//
//  ActionViewController.swift
//  Calculate Molar Mass
//
//  Created by Anant Jain on 12/16/15.
//  Copyright © 2015 Anant Jain. All rights reserved.
//

import UIKit
import MobileCoreServices

class ActionViewController: UIViewController, UIViewControllerTransitioningDelegate {

    @IBOutlet weak var inputLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var showWorkButton: UIButton!
    @IBOutlet weak var answerView: UIView!
    @IBOutlet weak var mainStackView: UIStackView!
    
    var answer = 0.0
    var resultsData: [String: Any]?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.preferredContentSize = CGSize(width: 500, height: 500)
    
        // Get the item[s] we're handling from the extension context.
        
        // For example, look for an image and place it into an image view.
        // Replace this with something appropriate for the type[s] your extension supports.
        var textFound = false
        for item: Any in self.extensionContext!.inputItems {
            let inputItem = item as! NSExtensionItem
            for provider: Any in inputItem.attachments! {
                let itemProvider = provider as! NSItemProvider
                if itemProvider.hasItemConformingToTypeIdentifier(kUTTypeText as String) {
                    // This is an image. We'll load it, then place it in our image view.
                    weak var weakInputLabel = self.inputLabel
                    itemProvider.loadItem(forTypeIdentifier: kUTTypeText as String, options: nil, completionHandler: { (text, error) in
                        OperationQueue.main.addOperation {
                            if let strongInputLabel = weakInputLabel {
                                strongInputLabel.text = text as? String
                            }
                            
                            DispatchQueue.global(qos: DispatchQoS.QoSClass.userInitiated).async {
                                let data = MolarMassCalculator.elements(fromFormula: text as! String)
                                if let error = data["Error"] as? String {
                                    DispatchQueue.main.async(execute: { () -> Void in
                                        let errorAlert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
                                        errorAlert.addAction(UIAlertAction(title: "Done", style: .default, handler: { (action) -> Void in
                                            self.done()
                                        }))
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
                    })
                    
                    textFound = true
                    break
                }
            }
            
            if textFound {
                // We only handle one formula, so stop looking for more.
                break
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func done() {
        // Return any edited content to the host app.
        // This template doesn't do anything, so we just echo the passed in items.
        self.extensionContext!.completeRequest(returningItems: self.extensionContext!.inputItems, completionHandler: nil)
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
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if let navVC = presented as? UINavigationController {
            if let _ = navVC.viewControllers[0] as? ShowWorkViewController {
                return GrowTransition(presenting: true, initialFrame: self.view.convert(answerView.frame, from: mainStackView))
            }
        }
        
        return nil
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if let navVC = dismissed as? UINavigationController {
            if let _ = navVC.viewControllers[0] as? ShowWorkViewController {
                return GrowTransition(presenting: false, initialFrame: self.view.convert(answerView.frame, from: mainStackView))
            }
        }
        
        return nil
    }
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        if let navVC = presented as? UINavigationController {
            if let _ = navVC.viewControllers[0] as? ShowWorkViewController {
                return GrowPresentation(presentedViewController: presented, presenting: presenting)
            }
        }
        
        return nil
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "Show Work" {
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
    
    @IBAction func returnFromShowWork(_ segue: UIStoryboardSegue) {
        
    }

}
