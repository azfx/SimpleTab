//
//  PopViewTransitionManager.swift
//  XStreet
//
//  Created by azfx on 07/20/2015.
//  Copyright (c) 2015 azfx. All rights reserved.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE..

import Foundation
import UIKit

open class PopViewTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    var duration:TimeInterval = 0.33
    
    open func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
        
        transitionContext.containerView.addSubview(toViewController.view)
        toViewController.view.alpha = 0.0
        

        UIView.animate(withDuration: 0.35, animations: { () -> Void in
            toViewController.view.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
            toViewController.view.alpha = 1.0
        }, completion: { (finished) -> Void in
        
            UIView.animate(withDuration: 0.2, animations: { () -> Void in
                toViewController.view.transform = CGAffineTransform.identity
            }, completion: { (finished) -> Void in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            })
        }) 
    }
    
    open func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        
        return self.duration
    }
}
