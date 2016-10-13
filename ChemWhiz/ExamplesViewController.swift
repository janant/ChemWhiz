//
//  ExamplesViewController.swift
//  ChemWhiz
//
//  Created by Anant Jain on 11/26/15.
//  Copyright © 2015 Anant Jain. All rights reserved.
//

import UIKit

class ExamplesViewController: UIViewController {
    
    @IBOutlet weak var examplesTextView: UITextView!

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        examplesTextView.scrollRectToVisible(CGRect(x: 0, y: 0, width: 1, height: 1), animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dismiss() {
        self.dismiss(animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
