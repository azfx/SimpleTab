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

public class SimpleTabBar: UITabBar , UITabBarControllerDelegate {

    ///View Controller Transitioning Object
    public var transitionObject:UIViewControllerAnimatedTransitioning?

    ///Keep track of tab bar items
    public var barItems:[SimpleTabBarItem] = []

    ///Tab Bar Style ( with tab switching animations ) to be used
    public var tabBarStyle:SimpleTabBarStyle?

    ///Handle to the parent tab bar controller
    public var tabBarCtrl:SimpleTabBarController?

    ///Index to tab bar item which just got unselected
    public var deselectedIndex:Int?

    ///Selected Index - Trigger animate function in the associated style object whenever changed.
    public var selectedIndex:Int = 0 {
        didSet {
            self.deselectedIndex = oldValue
            if let style = self.tabBarStyle {
                if oldValue != self.selectedIndex {
                    style.animateTabTransition(self, toIndex: self.selectedIndex, fromIndex: self.deselectedIndex!)
                }
            }
        }
    }

    override public func layoutSubviews() {
        super.layoutSubviews()
        self.tabBarStyle!.refresh()
    }

    //MARK: - UITabBarControllerDelegate Implementation

    public func tabBarController(tabBarController: UITabBarController, didSelectViewController viewController: UIViewController) {
        self.selectedIndex = tabBarController.selectedIndex
    }


    public func tabBarController(tabBarController: UITabBarController, animationControllerForTransitionFromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self.transitionObject
    }

}
