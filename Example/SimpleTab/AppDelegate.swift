//
//  AppDelegate.swift
//  SimpleTab
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
// THE SOFTWARE.

import UIKit
import SimpleTab

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var simpleTBC:SimpleTabBarController?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //# Setup Simple Tab Bar Controller
        setupSimpleTab()
        
        return true
    }
    
    func setupSimpleTab() {
        
        //# Get Handle of Tab Bar Control
        /* In storyboard, ensure :
        - Tab Bar Controller is set as SimpleTabBarController
        - Tab Bar is set as SimpleTabBar
        - Tab Bar Item is set as SimpleTabBarItem
        */
        
        simpleTBC = self.window!.rootViewController as? SimpleTabBarController
        
        //# Set the View Transition
        simpleTBC?.viewTransition = PopViewTransition()
        //simpleTBC?.viewTransition = CrossFadeViewTransition()
        
        //# Set Tab Bar Style ( tab bar , tab item animation style etc )
        let style:SimpleTabBarStyle = PopTabBarStyle(tabBar: simpleTBC!.tabBar)
        //var style:SimpleTabBarStyle = ElegantTabBarStyle(tabBar: simpleTBC!.tabBar)
        
        //# Optional - Set Tab Title attributes for selected and unselected (normal) states.
        // Or use the App tint color to set the states
        style.setTitleTextAttributes(attributes: [NSFontAttributeName as NSObject : UIFont.systemFont(ofSize: 14),  NSForegroundColorAttributeName as NSObject: UIColor.lightGray], forState: .normal)
        style.setTitleTextAttributes(attributes: [NSFontAttributeName as NSObject : UIFont.systemFont(ofSize: 14),NSForegroundColorAttributeName as NSObject: colorWithHexString("4CB6BE")], forState: .selected)
        
        //# Optional - Set Tab Icon colors for selected and unselected (normal) states.
        // Or use the App tint color to set the states
        style.setIconColor(color: UIColor.lightGray, forState: UIControlState.normal)
        style.setIconColor(color: colorWithHexString("4CB6BE"), forState: UIControlState.selected)
        
        //# Let the tab bar control know of the style
        // Note: All style settings must be done prior to this.
        simpleTBC?.tabBarStyle = style
    }
    
    //# Handy function to return UIColors from Hex Strings
    func colorWithHexString (_ hexStr:String) -> UIColor {
    
        let hex = hexStr.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.characters.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            return .clear
        }
        return UIColor(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
        
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

