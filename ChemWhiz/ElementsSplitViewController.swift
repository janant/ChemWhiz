//
//  ElementsSplitViewController.swift
//  ChemWhiz
//
//  Created by Anant Jain on 5/31/16.
//  Copyright © 2016 Anant Jain. All rights reserved.
//

import UIKit

class ElementsSplitViewController: UISplitViewController, UISplitViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.delegate = self
        self.preferredDisplayMode = .allVisible
        self.view.backgroundColor = UIColor.gray
    }
    
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        if let navVC = secondaryViewController as? UINavigationController {
            if let elementDetailVC = navVC.topViewController as? ElementDetailViewController {
                if elementDetailVC.elementData == nil {
                    return true
                }
            }
        }
        return false
    }

}
