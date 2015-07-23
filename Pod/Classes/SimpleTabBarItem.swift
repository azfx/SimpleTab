//
//  SimpleTabBarItem.swift
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

public class SimpleTabBarItem: UITabBarItem  {

    ///Tab bar item frame - update child items when updated
    //TODO : Switch to AutoLayout
    public var frame:CGRect = CGRectZero {
        didSet {
            self.barItemView!.frame = self.frame
            self.titleLabel.frame.size.width = self.frame.size.width
        }
    }

    ///Parent Tab Bar
    public var tabBar:SimpleTabBar?

    ///Index of the current tab bar item
    public var index:Int?

    ///Main view to hold rest of UI objects
    public var barItemView:UIView?

    ///Tab Title
    public var tabTitle:String?

    ///Tab Title Label ( below icon ) height
    private var titleHeight:CGFloat?

    ///Tab icon view size
    private var iconSize:CGSize?
    
    ///Tab icon top offset
    private var iconTopOffset:CGFloat?
    
    ///Tab title label bottom offset
    private var titleBottoOffset:CGFloat?
    
    ///Tab Bar Item Title
    override public var title:String? {
        get {
            return ""
        }
        set {
            tabTitle = newValue
        }
    }

    ///UILabel to hold tab item title
    public var titleLabel:UILabel = UILabel()

    ///UIView to hold tab item icon and anything additional
    public var iconView:UIView = UIView()
    
    /*
        Initialize SimpleTabBarItem
        :param: style   The SimpleTabBarStyle associated with this Tab Bar Item
        :param: index   Index of this Tab Bar Item
    
    */
    public func initialize(style:SimpleTabBarStyle, index:Int) {

        //This function is called by the SimpleTabBarStyle object during init()
        self.index = index
        self.barItemView = UIView(frame: style.barFrames[index])
        self.barItemView?.userInteractionEnabled = false
        self.frame = style.barFrames[index]
        self.tabBar = style.tabBar

        self.titleHeight = style.titleHeight
        self.iconSize = style.iconSize
        
        self.iconTopOffset = style.iconTopOffset
        self.titleBottoOffset = style.titleBottomOffset

        titleLabel = UILabel()
        iconView = UIView()
        self.tabTitle = super.title
        self.layoutBarItem()

        barItemView!.addSubview(titleLabel)
        barItemView!.addSubview(iconView)

        tabBar!.addSubview(barItemView!)

    }
    
    /*
        Lay out Tab Bar Item.
    */
    public func layoutBarItem() {
        //To set the tab bar item layout.
        //Called during initialize as well as any future layout changes

        //Set tab title label
        titleLabel.frame = CGRect(x: 0 , y: frame.size.height - titleHeight! - titleBottoOffset! , width: frame.size.width , height:titleHeight!  )
        titleLabel.textAlignment = NSTextAlignment.Center

        //Set tab icon
        iconView.frame = CGRect(x: 0 , y: iconTopOffset! , width: iconSize!.width  , height:iconSize!.height  )
        iconView.center = CGPointMake(CGRectGetMidX(barItemView!.bounds), iconView.center.y)

        //Add default UITabBarItem image to this object
        if let image = self.image {
            var newImage:UIImage = image.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
            var imageView:UIImageView = UIImageView(image: newImage)
            imageView.frame.size = iconSize!
            self.image = nil
            iconView.addSubview(imageView)
        }

    }

}
