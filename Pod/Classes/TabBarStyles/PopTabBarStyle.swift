//
//  PopTabBarStyle.swift
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

open class PopTabBarStyle: SimpleTabBarStyle {
    
    open var selectorView:UIView = UIView()
    open var selectorHeight:CGFloat = 5
    open var selectorSideInsets:CGFloat = 10
    open var selectorColor:UIColor?
    
    open var step:NSInteger = 0
    
    override open func tabBarCtrlLoaded(tabBarCtrl: SimpleTabBarController, tabBar: SimpleTabBar, selectedIndex: Int) {
        
        //Setup a selection indicator view
        let selectedItemFrame:CGRect = tabBar.barItems[selectedIndex].frame
        let insets:UIEdgeInsets = UIEdgeInsetsMake(selectedItemFrame.height - selectorHeight, selectorSideInsets, 0, selectorSideInsets)
        selectorView.frame = UIEdgeInsetsInsetRect(selectedItemFrame, insets)
        self.selectorColor = self.iconColors[UIControlState.selected.rawValue]
        self.selectorView.backgroundColor = self.selectorColor
        
        tabBar.addSubview(selectorView)
        
    }
    
    
    
    override open func refresh() {
        super.refresh()
        
        //Ensure selected bar/tab item state remains during refresh
        
        let selectedItemFrame:CGRect = tabBar!.barItems[tabBar!.selectedIndex].frame
        let insets:UIEdgeInsets = UIEdgeInsetsMake(selectedItemFrame.height - selectorHeight, selectorSideInsets, 0, selectorSideInsets)
        selectorView.frame = UIEdgeInsetsInsetRect(selectedItemFrame, insets)
        
        let tabBarItem:SimpleTabBarItem = tabBar!.barItems[tabBar!.selectedIndex]
        tabBarItem.iconView.frame = tabBarItem.iconView.frame.offsetBy(dx: 0, dy: 10)
        tabBarItem.titleLabel.alpha = 0
        
    }
    
    override open func animateTabTransition(tabBar: SimpleTabBar, toIndex: Int,fromIndex: Int) {
        
        let toBarItem:SimpleTabBarItem = tabBar.barItems[toIndex]
        let fromBarItem:SimpleTabBarItem = tabBar.barItems[fromIndex]
        
        self.selectorView.frame.origin.x = toBarItem.frame.origin.x + self.selectorSideInsets
        self.selectorView.frame = self.selectorView.frame.offsetBy(dx: 0, dy: 10)
        
        
        UIView.animate(withDuration: 0.3, delay: 0.0, options: UIViewAnimationOptions(), animations: { () -> Void in
            
            //Refresh colors as per tab item state
            self.refreshColors()
            
            toBarItem.iconView.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            
            //Animate selected item to new state
            toBarItem.iconView.frame = toBarItem.iconView.frame.offsetBy(dx: 0, dy: 10)
            toBarItem.titleLabel.alpha = 0
            
            //Animate unselected item to its original state
            fromBarItem.titleLabel.alpha = 1
            fromBarItem.layoutBarItem()
            
            //Animate selector view under the selected tab item
            let selectedItemFrame:CGRect = toBarItem.frame
            let insets:UIEdgeInsets = UIEdgeInsetsMake(selectedItemFrame.height - self.selectorHeight, self.selectorSideInsets, 0, self.selectorSideInsets)
            self.selectorView.frame = UIEdgeInsetsInsetRect(selectedItemFrame, insets)

        }) { (finish) -> Void in
            //
            UIView.animate(withDuration: 0.2, animations: { () -> Void in
                toBarItem.iconView.transform = CGAffineTransform.identity
            })
        }
        
    }
    
}
