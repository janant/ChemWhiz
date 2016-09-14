//
//  ActionViewController.swift
//  Calculate Molar Mass
//
//  Created by Anant Jain on 10/25/15.
//  Copyright © 2015 Anant Jain. All rights reserved.
//

import UIKit
import MobileCoreServices

class ActionViewController: UIViewController, UIViewControllerTransitioningDelegate {

    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Get the item[s] we're handling from the extension context.
        
        // For example, look for an image and place it into an image view.
        // Replace this with something appropriate for the type[s] your extension supports.
        var imageFound = false
        for item: AnyObject in self.extensionContext!.inputItems {
            let inputItem = item as! NSExtensionItem
            for provider: AnyObject in inputItem.attachments! {
                let itemProvider = provider as! NSItemProvider
                if itemProvider.hasItemConformingToTypeIdentifier(kUTTypeText as String) {
                    // This is an string. We'll load it, then place it in our image view.
                    itemProvider.loadItemForTypeIdentifier(kUTTypeText as String, options: nil, completionHandler: { (text, error) -> Void in
                        self.label.text = text as? String
                    })
                    
                    imageFound = true
                    break
                }
            }
            
            if (imageFound) {
                // We only handle one image, so stop looking for more.
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
        self.extensionContext!.completeRequestReturningItems(self.extensionContext!.inputItems, completionHandler: nil)
    }

}
