//
//  SimpleTabBarStyle.swift
//  XStreet
//
//  Created by Nirvana on 7/16/15.
//  Copyright (c) 2015 Fittoos Inc. All rights reserved.
//

import UIKit
import Foundation

public class SimpleTabBarStyle :NSObject {
    
    //To hold CGRect Frames of all SimpleTabBarItems
    public var barFrames:[CGRect] = []
    
    //Handle to the tab bar
    public var tabBar:SimpleTabBar?
    
    //Tab bar item iconview size
    public var iconSize:CGSize = CGSize(width: 30 , height: 30 )
    
    //Tab bar item title label height
    public var titleHeight:CGFloat = 15
    
    //Tab bar item title label text attributes options
    //Can be set in AppDelegate / App Load
    internal private(set)  var titleTextAttributes:[UInt:[NSObject:AnyObject]] = [:]
    
    //Tab bar icon state color options
    //Can be set in AppDelegate / App Load
    internal private(set)  var iconColors:[UInt:UIColor] = [:]
    
    public init(tabBar:SimpleTabBar) {
        super.init()
        
        iconColors[UIControlState.Normal.rawValue] = UIColor.grayColor()
        iconColors[UIControlState.Selected.rawValue] = tabBar.tintColor
        
        titleTextAttributes[UIControlState.Normal.rawValue] = [NSForegroundColorAttributeName: UIColor.grayColor()]
        titleTextAttributes[UIControlState.Selected.rawValue] = [NSForegroundColorAttributeName: tabBar.tintColor]
        
        self.tabBar = tabBar
        self.layoutTabBarItems(tabBar, initialize: true)
        self.refreshColors()
    }
    
    private func layoutTabBarItems(tabBar: SimpleTabBar , initialize:Bool=false) {
        
        barFrames = []
        var barItems:[SimpleTabBarItem] = []
        
        for view in tabBar.subviews as! [UIView] {
            if view.userInteractionEnabled && view.isKindOfClass(UIControl) {
                barFrames.append(view.frame)
            }
        }
        barFrames.sort { (this, that) -> Bool in
            return this.origin.x < that.origin.x
        }
        var i = 0
        if let items = tabBar.items {
            for item in items {
                var barItem:SimpleTabBarItem = item as! SimpleTabBarItem
                if initialize {
                    barItem.initialize(barFrames[i] , tabBar: tabBar , iconSize: iconSize  , titleHeight: self.titleHeight, index: i )
                } else {
                    barItem.frame = barFrames[i]
                    barItem.layoutBarItem()
                }
                
                barItems.append(barItem)
                i++
            }
            tabBar.barItems = barItems
        }
    }
    
    public func refresh() {
        layoutTabBarItems(self.tabBar!)
        refreshColors()
    }
    
    public func refreshColors() {
    
        tabBar!.barItems.map { barItem -> SimpleTabBarItem in
            var state:UInt = barItem.index == self.tabBar!.selectedIndex ? UIControlState.Selected.rawValue : UIControlState.Normal.rawValue
            if let attributes = self.titleTextAttributes[state] {
                var attributedTitle:NSAttributedString = NSAttributedString(string: barItem.tabTitle!, attributes:attributes)
                barItem.titleLabel.attributedText = attributedTitle
            }
            
            if let iconColor = self.iconColors[state] {
                barItem.iconView.tintColor = iconColor
            }
            
            return barItem
        }

    }
    
    
    public func tabBarCtrlLoaded(tabBarCtrl:SimpleTabBarController , tabBar:SimpleTabBar, selectedIndex:Int) {
        
    }
    
    public func setIconColor(color:UIColor , forState state:UIControlState) {
        iconColors[state.rawValue] = color
    }
    
    public func setTitleTextAttributes(attributes:[NSObject:AnyObject] , forState state:UIControlState) {
        titleTextAttributes[state.rawValue] = attributes
    }
    
    public func animateTabTransition(tabBar: SimpleTabBar, toIndex: Int,fromIndex: Int) {
        refresh()
    }
}