//
//  SlideUpTransition.swift
//  ChemWhiz
//
//  Created by Anant Jain on 5/31/16.
//  Copyright © 2016 Anant Jain. All rights reserved.
//

import UIKit

class SlideUpTransition: NSObject, UIViewControllerAnimatedTransitioning {
    var presenting: Bool
    
    init(presenting: Bool) {
        self.presenting = presenting
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.4
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if presenting {
            presentAnimation(transitionContext)
        }
        else {
            dismissAnimation(transitionContext)
        }
    }
    
    func presentAnimation(_ transitionContext: UIViewControllerContextTransitioning) {
        guard
            let toView = transitionContext.view(forKey: UITransitionContextViewKey.to),
            let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
            else {
                transitionContext.completeTransition(false)
                return
        }
        
        let container = transitionContext.containerView
        let finalFrame = transitionContext.finalFrame(for: toVC)
        toView.frame = finalFrame
        
        toView.transform = CGAffineTransform(translationX: 0, y: container.frame.midY + (finalFrame.height / 2.0))
        
        container.addSubview(toView)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0, usingSpringWithDamping: 0.85, initialSpringVelocity: 20, options: .curveEaseOut, animations: { () -> Void in
            toView.transform = CGAffineTransform.identity
        }) { (completed) -> Void in
            transitionContext.completeTransition(true)
        }
    }
    
    func dismissAnimation(_ transitionContext: UIViewControllerContextTransitioning) {
        guard
            let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from),
            let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)
            else {
                transitionContext.completeTransition(false)
                return
        }
        
        let container = transitionContext.containerView
        
        let finalFrame = transitionContext.finalFrame(for: fromVC)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0, options: .curveEaseOut, animations: { () -> Void in
            fromView.transform = CGAffineTransform(translationX: 0, y: container.frame.midY + (finalFrame.height / 2.0))
        }) { (completed) -> Void in
            transitionContext.completeTransition(true)
        }
    }

}
