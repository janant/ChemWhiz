//
//  SlideFromLeftPresentation.swift
//  ChemWhiz
//
//  Created by Anant Jain on 11/26/15.
//  Copyright © 2015 Anant Jain. All rights reserved.
//

import UIKit

class SlideFromLeftPresentation: UIPresentationController {
    
    let shadowView = UIView()
    
    override func presentationTransitionWillBegin() {
        guard
            let container = containerView,
            let presentedView = presentedView
        else {
            return
        }
        
        shadowView.backgroundColor = UIColor.black
        shadowView.alpha = 0.0
        shadowView.frame = presentingViewController.view.frame
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismiss))
        shadowView.addGestureRecognizer(tapRecognizer)
        
        container.addSubview(shadowView)
        container.addSubview(presentedView)
        
        let swipeRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(dismiss))
        swipeRecognizer.direction = .left
        shadowView.addGestureRecognizer(swipeRecognizer)
        
        if let transitionCoordinator = presentingViewController.transitionCoordinator {
            transitionCoordinator.animate(alongsideTransition: { (context) -> Void in
                self.shadowView.alpha = 0.4
                }, completion: nil)
        }
    }
    
    override func presentationTransitionDidEnd(_ completed: Bool) {
        if !completed {
            shadowView.removeFromSuperview()
        }
    }
    
    override func dismissalTransitionWillBegin() {
        if let transitionCoordinator = presentingViewController.transitionCoordinator {
            transitionCoordinator.animate(alongsideTransition: { (context) -> Void in
                self.shadowView.alpha = 0.0
                }, completion: nil)
        }
    }
    
    override func dismissalTransitionDidEnd(_ completed: Bool) {
        if completed {
            shadowView.removeFromSuperview()
        }
    }
    
    func dismiss() {
        presentedViewController.dismiss(animated: true, completion: nil)
    }
    
    override var frameOfPresentedViewInContainerView: CGRect {
        if presentingViewController.traitCollection.horizontalSizeClass == .regular {
            return CGRect(x: 0, y: 0, width: 320, height: presentingViewController.view.frame.size.height)
        }
        else {
            return CGRect(x: 0, y: 0, width: 280, height: presentingViewController.view.frame.size.height)
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        coordinator.animate(alongsideTransition: { (context) -> Void in
            self.presentedView?.frame = self.frameOfPresentedViewInContainerView
            self.shadowView.frame = self.presentingViewController.view.frame
            }, completion: nil)
        
    }
}
