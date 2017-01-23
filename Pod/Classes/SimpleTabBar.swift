//
//  SimpleTabBar.swift
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


import UIKit

open class SimpleTabBar: UITabBar , UITabBarControllerDelegate {

    ///View Controller Transitioning Object
    open var transitionObject:UIViewControllerAnimatedTransitioning?

    ///Keep track of tab bar items
    open var barItems:[SimpleTabBarItem] = []

    ///Tab Bar Style ( with tab switching animations ) to be used
    open var tabBarStyle:SimpleTabBarStyle?

    ///Handle to the parent tab bar controller
    open var tabBarCtrl:SimpleTabBarController?

    ///Index to tab bar item which just got unselected
    open var deselectedIndex:Int?

    ///Selected Index - Trigger animate function in the associated style object whenever changed.
    open var selectedIndex:Int = 0 {
        didSet {
            self.deselectedIndex = oldValue
            if let style = self.tabBarStyle {
                if oldValue != self.selectedIndex {
                    style.animateTabTransition(tabBar: self, toIndex: self.selectedIndex, fromIndex: self.deselectedIndex!)
                }
            }
        }
    }

    override open func layoutSubviews() {
        super.layoutSubviews()
        self.tabBarStyle!.refresh()
    }

    //MARK: - UITabBarControllerDelegate Implementation

    open func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        self.selectedIndex = tabBarController.selectedIndex
    }


    open func tabBarController(_ tabBarController: UITabBarController, animationControllerForTransitionFrom fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self.transitionObject
    }

}
