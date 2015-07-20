//
//  SimpleTabBarCrossDissolve.swift
//  XStreet
//
//  Created by Nirvana on 7/15/15.
//  Copyright (c) 2015 Fittoos Inc. All rights reserved.
//

import UIKit

public class CrossFadeViewTransition: NSObject, UIViewControllerAnimatedTransitioning {

    var duration:NSTimeInterval = 0.33

    public func animateTransition(transitionContext: UIViewControllerContextTransitioning) {

        let fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)
        let toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!

        transitionContext.containerView().addSubview(toViewController.view)
        toViewController.view.alpha = 0.0

        UIView.animateWithDuration(0.35, animations: {
            toViewController.view.alpha = 1.0
            }, completion: { (finished) in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
        })
    }

    public func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {

        return self.duration
    }
}
