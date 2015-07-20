//
//  JumpingSimpleTabBarStyle.swift
//  XStreet
//
//  Created by Nirvana on 7/16/15.
//  Copyright (c) 2015 Fittoos Inc. All rights reserved.
//

import UIKit

public class ElegantTabBarStyle: SimpleTabBarStyle {
    
    public var selectorView:UIView = UIView()
    public var selectorHeight:CGFloat = 5
    public var selectorSideInsets:CGFloat = 10
    public var selectorColor:UIColor?
    
    override public func tabBarCtrlLoaded(tabBarCtrl: SimpleTabBarController, tabBar: SimpleTabBar, selectedIndex: Int) {
        
        //Setup a selection indicator view
        var selectedItemFrame:CGRect = tabBar.barItems[selectedIndex].frame
        var insets:UIEdgeInsets = UIEdgeInsetsMake(selectedItemFrame.height - selectorHeight, selectorSideInsets, 0, selectorSideInsets)
        selectorView.frame = UIEdgeInsetsInsetRect(selectedItemFrame, insets)
        self.selectorColor = self.iconColors[UIControlState.Selected.rawValue]
        self.selectorView.backgroundColor = self.selectorColor
        
        tabBar.addSubview(selectorView)
        
    }
    
    
    
    override public func refresh() {
        super.refresh()
        
        //Keep layout intact during orientation change etc
        var selectedItemFrame:CGRect = tabBar!.barItems[tabBar!.selectedIndex].frame
        var insets:UIEdgeInsets = UIEdgeInsetsMake(selectedItemFrame.height - selectorHeight, selectorSideInsets, 0, selectorSideInsets)
        selectorView.frame = UIEdgeInsetsInsetRect(selectedItemFrame, insets)
        
        
        //Ensure selected bar/tab item state remains during refresh
        
        var tabBarItem:SimpleTabBarItem = tabBar!.barItems[tabBar!.selectedIndex]
        tabBarItem.iconView.frame.offset(dx: 0, dy: 10)
        tabBarItem.titleLabel.alpha = 0
        
    }
    
    override public func animateTabTransition(tabBar: SimpleTabBar, toIndex: Int,fromIndex: Int) {
        
        var toBarItem:SimpleTabBarItem = tabBar.barItems[toIndex]
        var fromBarItem:SimpleTabBarItem = tabBar.barItems[fromIndex]

        UIView.animateWithDuration(0.5, animations: { () -> Void in
   
            //Refresh colors as per tab item state
            self.refreshColors()
            
            //Animate selected item to new state
            toBarItem.iconView.frame.offset(dx: 0, dy: 10)
            toBarItem.titleLabel.alpha = 0
            
            //Animate unselected item to its original state
            fromBarItem.titleLabel.alpha = 1
            fromBarItem.layoutBarItem()
            
            //Animate selector view under the selected tab item
            self.selectorView.frame.origin.x = toBarItem.frame.origin.x + self.selectorSideInsets
            
        })
    }
    
}
