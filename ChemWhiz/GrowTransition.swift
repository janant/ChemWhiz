//
//  GrowTransition.swift
//  ChemWhiz
//
//  Created by Anant Jain on 11/28/15.
//  Copyright © 2015 Anant Jain. All rights reserved.
//

import UIKit

class GrowTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    let presenting: Bool
    let initialFrame: CGRect
    
    init(presenting: Bool, initialFrame: CGRect) {
        self.presenting = presenting
        self.initialFrame = initialFrame
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return presenting ? 0.5 : 0.6
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
        
        let scaleTransformation = CGAffineTransform(scaleX: initialFrame.size.width / finalFrame.size.width, y: initialFrame.size.height / finalFrame.size.height)
        let translationTransformation = CGAffineTransform(translationX: initialFrame.midX - finalFrame.midX, y: initialFrame.midY - finalFrame.midY)
        
        toView.transform = scaleTransformation.concatenating(translationTransformation)
        toView.alpha = 0.0
        
        container.addSubview(toView)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 10, options: .curveEaseOut, animations: { () -> Void in
            toView.transform = CGAffineTransform.identity
            toView.alpha = 1.0
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
        
        let finalFrame = transitionContext.finalFrame(for: fromVC)
        
        let scaleTransformation = CGAffineTransform(scaleX: initialFrame.size.width / finalFrame.size.width, y: initialFrame.size.height / finalFrame.size.height)
        let translationTransformation = CGAffineTransform(translationX: initialFrame.midX - finalFrame.midX, y: initialFrame.midY - finalFrame.midY)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0, options: .curveEaseOut, animations: { () -> Void in
            fromView.transform = scaleTransformation.concatenating(translationTransformation)
            fromView.alpha = 0.0
            }) { (completed) -> Void in
                transitionContext.completeTransition(true)
        }
    }

}
