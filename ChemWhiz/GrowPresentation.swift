//
//  GrowPresentation.swift
//  ChemWhiz
//
//  Created by Anant Jain on 11/28/15.
//  Copyright © 2015 Anant Jain. All rights reserved.
//

import UIKit

class GrowPresentation: UIPresentationController {
    
    let shadowView = UIView()
    
    let maxWidth: CGFloat = 600.0
    let maxHeight: CGFloat = 600.0
    
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
        
        presentedView.layer.cornerRadius = 10.0
        presentedView.layer.masksToBounds = true
        
        container.addSubview(shadowView)
        container.addSubview(presentedView)
        
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
        let fromVCFrame = presentingViewController.view.frame.insetBy(dx: 20.0, dy: 20.0)
        let width: CGFloat = min(fromVCFrame.width, maxWidth)
        let height: CGFloat = min(fromVCFrame.height, maxHeight)
        
        return CGRect(x: fromVCFrame.midX - (width / 2.0), y: fromVCFrame.midY - (height / 2.0), width: width, height: height)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        coordinator.animate(alongsideTransition: { (context) -> Void in
            self.presentedView?.frame = self.frameOfPresentedViewInContainerView
            self.shadowView.frame = self.presentingViewController.view.frame
            }, completion: nil)
        
    }

}
