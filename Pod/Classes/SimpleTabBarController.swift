//
//  SimpleTabBarController.swift
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

public class SimpleTabBarController: UITabBarController {

    var _tabBar:SimpleTabBar?

    ///Tab Bar Component
    override public var tabBar:SimpleTabBar {
        get {
            return super.tabBar as! SimpleTabBar
        }
        set {

        }
    }

    ///View Transitioning Object
    public var viewTransition:UIViewControllerAnimatedTransitioning?

    ///Tab Bar Style ( with animation control for tab switching )
    public var tabBarStyle:SimpleTabBarStyle? {
        didSet {
            self.tabBarStyle?.refresh()
        }
    }

    override public func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        //Initial setup
        tabBar.selectedIndex = self.selectedIndex
        tabBar.transitionObject = self.viewTransition! ?? CrossFadeViewTransition()
        tabBar.tabBarStyle = self.tabBarStyle! ?? ElegantTabBarStyle(tabBar: tabBar)
        tabBar.tabBarCtrl = self
        self.delegate = tabBar

        //Let the style object know when things are loaded
        self.tabBarStyle?.tabBarCtrlLoaded(self, tabBar: tabBar, selectedIndex: tabBar.selectedIndex)

    }

    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
