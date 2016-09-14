//
//  GrowAnimatedTransition.m
//  ChemWhiz
//
//  Created by Anant Jain on 4/18/14.
//  Copyright (c) 2014 Anant Jain. All rights reserved.
//

#import "GrowAnimatedTransition.h"

@implementation GrowAnimatedTransition

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    if (self.presenting) return 0.6;
    else return 0.4;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *container = [transitionContext containerView];
    
    if (self.presenting)
    {
        CGRect screenSize = [[UIApplication sharedApplication].delegate window].frame;
        
        fromViewController.view.userInteractionEnabled = NO;
        
        toViewController.view.frame = CGRectMake(20, 20, screenSize.size.width - 40, screenSize.size.height - 40);
        toViewController.view.transform = CGAffineTransformConcat(CGAffineTransformMakeScale(CGRectGetWidth(_backgroundRectFrame) / CGRectGetWidth(toViewController.view.frame), CGRectGetHeight(_backgroundRectFrame) / CGRectGetHeight(toViewController.view.frame)), CGAffineTransformMakeTranslation(CGRectGetMidX(_backgroundRectFrame) - CGRectGetMidX(toViewController.view.frame), CGRectGetMidY(_backgroundRectFrame) - CGRectGetMidY(toViewController.view.frame)));
        toViewController.view.alpha = 0.0;
        
        toViewController.view.layer.cornerRadius = 15;
        toViewController.view.layer.masksToBounds = YES;
        
        [container addSubview:toViewController.view];
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0.05 usingSpringWithDamping:40.0 initialSpringVelocity:20.0 options:UIViewAnimationOptionTransitionNone animations:^{
            toViewController.view.transform = CGAffineTransformIdentity;
            toViewController.view.alpha = 1.0;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
        }];
    }
    else
    {
        toViewController.view.userInteractionEnabled = YES;
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            fromViewController.view.transform = CGAffineTransformConcat(CGAffineTransformMakeScale(CGRectGetWidth(_backgroundRectFrame) / CGRectGetWidth(toViewController.view.frame), CGRectGetHeight(_backgroundRectFrame) / CGRectGetHeight(toViewController.view.frame)), CGAffineTransformMakeTranslation(CGRectGetMidX(_backgroundRectFrame) - CGRectGetMidX(toViewController.view.frame), CGRectGetMidY(_backgroundRectFrame) - CGRectGetMidY(toViewController.view.frame)));
            fromViewController.view.alpha = 0.0;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
        }];
    }
}

@end
