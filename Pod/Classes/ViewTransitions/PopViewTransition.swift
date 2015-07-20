//
//  PopViewTransitionManager.swift
//  XStreet
//
//  Created by Nirvana on 7/19/15.
//  Copyright (c) 2015 Fittoos Inc. All rights reserved.
//

import Foundation
import UIKit

public class PopViewTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    var duration:NSTimeInterval = 0.33
    
    public func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        let fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)
        let toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        
        transitionContext.containerView().addSubview(toViewController.view)
        toViewController.view.alpha = 0.0
        

        UIView.animateWithDuration(0.35, animations: { () -> Void in
            toViewController.view.transform = CGAffineTransformMakeScale(1.1, 1.1)
            toViewController.view.alpha = 1.0
        }) { (finished) -> Void in
        
            UIView.animateWithDuration(0.2, animations: { () -> Void in
                toViewController.view.transform = CGAffineTransformIdentity
            }, completion: { (finished) -> Void in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
            })
        }
    }
    
    public func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        
        return self.duration
    }
}
