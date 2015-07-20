//
//  PopTabBarStyle.swift
//  XStreet
//
//  Created by Nirvana on 7/19/15.
//  Copyright (c) 2015 Fittoos Inc. All rights reserved.
//

import UIKit

public class PopTabBarStyle: SimpleTabBarStyle {
    
    public var selectorView:UIView = UIView()
    public var selectorHeight:CGFloat = 5
    public var selectorSideInsets:CGFloat = 10
    public var selectorColor:UIColor?
    
    public var step:NSInteger = 0
    
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
        
        //Ensure selected bar/tab item state remains during refresh
        
        var selectedItemFrame:CGRect = tabBar!.barItems[tabBar!.selectedIndex].frame
        var insets:UIEdgeInsets = UIEdgeInsetsMake(selectedItemFrame.height - selectorHeight, selectorSideInsets, 0, selectorSideInsets)
        selectorView.frame = UIEdgeInsetsInsetRect(selectedItemFrame, insets)
        
        var tabBarItem:SimpleTabBarItem = tabBar!.barItems[tabBar!.selectedIndex]
        tabBarItem.iconView.frame.offset(dx: 0, dy: 10)
        tabBarItem.titleLabel.alpha = 0
        
    }
    
    override public func animateTabTransition(tabBar: SimpleTabBar, toIndex: Int,fromIndex: Int) {
        
        var toBarItem:SimpleTabBarItem = tabBar.barItems[toIndex]
        var fromBarItem:SimpleTabBarItem = tabBar.barItems[fromIndex]
        
        self.selectorView.frame.origin.x = toBarItem.frame.origin.x + self.selectorSideInsets
        self.selectorView.frame.offset(dx: 0, dy: 10)
        
        
        UIView.animateWithDuration(0.3, delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            
            //Refresh colors as per tab item state
            self.refreshColors()
            
            toBarItem.iconView.transform = CGAffineTransformMakeScale(1.5, 1.5)
            
            //Animate selected item to new state
            toBarItem.iconView.frame.offset(dx: 0, dy: 10)
            toBarItem.titleLabel.alpha = 0
            
            //Animate unselected item to its original state
            fromBarItem.titleLabel.alpha = 1
            fromBarItem.layoutBarItem()
            
            //Animate selector view under the selected tab item
            var selectedItemFrame:CGRect = toBarItem.frame
            var insets:UIEdgeInsets = UIEdgeInsetsMake(selectedItemFrame.height - self.selectorHeight, self.selectorSideInsets, 0, self.selectorSideInsets)
            self.selectorView.frame = UIEdgeInsetsInsetRect(selectedItemFrame, insets)

        }) { (finish) -> Void in
            //
            UIView.animateWithDuration(0.2, animations: { () -> Void in
                toBarItem.iconView.transform = CGAffineTransformIdentity
            })
        }
        
    }
    
}
