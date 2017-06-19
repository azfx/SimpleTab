//
//  SimpleTabBarStyle.swift
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
import Foundation

open class SimpleTabBarStyle :NSObject {
    
    ///To hold CGRect Frames of all SimpleTabBarItems
    public var barFrames:[CGRect] = []
    
    ///Handle to the tab bar
    public var tabBar:SimpleTabBar?
    
    ///Tab bar item iconview size
    public var iconSize:CGSize = CGSize(width: 25 , height: 25 )
    
    ///Tab bar item icon top offset
    public var iconTopOffset:CGFloat = 3.0
    
    ///Tab bar item title bottom offset
    public var titleBottomOffset:CGFloat = 5.0
    
    ///Tab bar item title label height
    public var titleHeight:CGFloat = 15
    
    //Tab bar item title label text attributes options
    //Can be set in AppDelegate / App Load
    internal private(set)  var titleTextAttributes:[UInt:[NSObject:AnyObject]] = [:]
    
    //Tab bar icon state color options
    //Can be set in AppDelegate / App Load
    internal private(set)  var iconColors:[UInt:UIColor] = [:]
    
    /*
        Init SimpleTabBarStyle with associated Tab Bar
        :param: tabBar  SimpleTabBar where this style is being applied
    */
    public init(tabBar:SimpleTabBar) {
        super.init()
        
        iconColors[UIControlState.normal.rawValue] = UIColor.gray
        iconColors[UIControlState.selected.rawValue] = tabBar.tintColor
        
        titleTextAttributes[UIControlState.normal.rawValue] = [NSForegroundColorAttributeName as NSObject: UIColor.gray]
        titleTextAttributes[UIControlState.selected.rawValue] = [NSForegroundColorAttributeName as NSObject: tabBar.tintColor]
        
        self.tabBar = tabBar
        self.layoutTabBarItems(tabBar: tabBar, initialize: true)
        self.refreshColors()
    }
    
    private func layoutTabBarItems(tabBar: SimpleTabBar , initialize:Bool=false) {
        
        barFrames = []
        var barItems:[SimpleTabBarItem] = []
        
        for view in tabBar.subviews {
            if view.isUserInteractionEnabled && view.isKind(of:UIControl.self) {
                self.barFrames.append(view.frame)
            }
        }
        barFrames.sort { (this, that) -> Bool in
            return this.origin.x < that.origin.x
        }
        var i = 0
        if let items = tabBar.items {
            for item in items {
                let barItem:SimpleTabBarItem = item as! SimpleTabBarItem
                if initialize {
                    barItem.initialize(self, index: i )
                } else {
                    barItem.frame = barFrames[i]
                    barItem.layoutBarItem()
                }
                
                barItems.append(barItem)
                i += 1
            }
            tabBar.barItems = barItems
        }
    }
    
    public func refresh() {
        layoutTabBarItems(tabBar: self.tabBar!)
        refreshColors()
    }
    
    public func refreshColors() {
    
        for barItem in tabBar!.barItems {
            let state:UInt = barItem.index == self.tabBar!.selectedIndex ? UIControlState.selected.rawValue : UIControlState.normal.rawValue
            if let attributes = self.titleTextAttributes[state] as! [String: AnyObject]? {
            let attributedTitle:NSAttributedString = NSAttributedString(string: barItem.tabTitle!, attributes:attributes)
            barItem.titleLabel.attributedText = attributedTitle
            }
            
            if let iconColor = self.iconColors[state] {
                barItem.iconView.tintColor = iconColor
            }
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
