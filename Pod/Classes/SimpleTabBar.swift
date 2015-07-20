//
//  SimpleTabBar.swift
//  XStreet
//
//  Created by Nirvana on 7/15/15.
//  Copyright (c) 2015 Fittoos Inc. All rights reserved.
//

import UIKit

public class SimpleTabBar: UITabBar , UITabBarControllerDelegate {

    //View Controller Transitioning Object
    public var transitionObject:UIViewControllerAnimatedTransitioning?

    //Keep track of tab bar items
    public var barItems:[SimpleTabBarItem] = []

    //Tab Bar Style ( with tab switching animations ) to be used
    public var tabBarStyle:SimpleTabBarStyle?

    //Handle to the parent tab bar controller
    public var tabBarCtrl:SimpleTabBarController?

    //Index to tab bar item which just got unselected
    public var deselectedIndex:Int?

    //Selected Index - Trigger animate function in the associated style object whenever changed.
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
