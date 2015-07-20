//
//  SimpleTabBarController.swift
//  XStreet
//
//  Created by Nirvana on 7/15/15.
//  Copyright (c) 2015 Fittoos Inc. All rights reserved.
//

import UIKit

public class SimpleTabBarController: UITabBarController {

    var _tabBar:SimpleTabBar?

    //Neat trick to override default property with custom class
    override public var tabBar:SimpleTabBar {
        get {
            return super.tabBar as! SimpleTabBar
        }
        set {

        }
    }

    //View Transitioning Object
    public var viewTransition:UIViewControllerAnimatedTransitioning?

    //Tab Bar Style ( with animation control for tab switching )
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
