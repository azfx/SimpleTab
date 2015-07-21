# SimpleTab

[![CI Status](http://img.shields.io/travis/azfx/SimpleTab.svg?style=flat)](https://travis-ci.org/azfx/SimpleTab)
[![Version](https://img.shields.io/cocoapods/v/SimpleTab.svg?style=flat)](http://cocoapods.org/pods/SimpleTab)
[![License](https://img.shields.io/cocoapods/l/SimpleTab.svg?style=flat)](http://cocoapods.org/pods/SimpleTab)
[![Platform](https://img.shields.io/cocoapods/p/SimpleTab.svg?style=flat)](http://cocoapods.org/pods/SimpleTab)

## About
.                          |.
:-------------------------:|:-------------------------:
![image](./Screenshots/simpletab1.gif) | ![image](./Screenshots/simpletab2.gif)

SimpleTab provides an easy alternative to the default UITabBarController with following support :

* Custom UI for Tab Bar Item
* Custom Tab Bar Item Animations on Tab Switching
* Custom View Transitions on Tab Switching

SimpleTab is developed with following principles :

* Simple - Ease to use and revert 
* Keep the wheel - Utilize core features of UITabBarController
* Flexible - Provide hooks to customize UI and Animations


## Demo

The included example project demonstrates the usage of SimpleTab

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

* iOS 8.0+
* ARC

## Installation

SimpleTab is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "SimpleTab""
```

## Getting Started

##### 1.0 Import SimpleTab Framework to your Project   

```swift
#import SimpleTab
```

##### 2.0 If using Interface Builder, ensure : 

* Tab Bar Controller is set as `SimpleTabBarController`
* Tab Bar is set as `SimpleTabBar`
* Tab Bar Item is set as `SimpleTabBarITem`

Get Handle to Tab Bar Controller, preferably in AppDelegate

```swift
simpleTBC = self.window!.rootViewController as? SimpleTabBarController
```

##### 3.0 Set View Transition  
>Included Animations  
>
*  PopViewTransition  
*  CrossFadeTransition  

```swift
simpleTBC?.viewTransition = PopViewTransition()
```        

##### 4.0 Set Tab Bar Style

>Included Styles
>
* PopTabBarStyle
* ElegantTabBarStyle


```swift
var style:SimpleTabBarStyle = PopTabBarStyle(tabBar: simpleTBC!.tabBar)
```

##### 4.1 Optional - Set Tab Title attributes for selected and unselected (normal) states.  
Or use Tint Color in the Interface Builder to set the states

```swift
style.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.lightGrayColor()], forState: .Normal)
style.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.blueColor()], forState: .Selected)
```

##### 5.0 Set Tab Icon colors for selected and unselected (normal) states.  
Or use the App tint color to set the states

```swift
style.setIconColor(UIColor.lightGrayColor(), forState: UIControlState.Normal)
style.setIconColor(UIColor.blueColor(), forState: UIControlState.Selected)
```

##### 6.0 And finally, let Tab Bar Controller know of the style in use

```swift
simpleTBC?.tabBarStyle = style
```

## Customizations

### Available Properties & Methods
#### SimpleTabBarController
* `viewTransition:UIViewControllerAnimatedTransitioning` - Set View Transition
* `tabBarStyle:SimpleTabBarStyle` - Set Tab Bar Style
* `setTitleTextAttributes(attributes:[NSObject:AnyObject] , forState: UIControlState)` - Set Tab Bar Item Tiile (UILable) text attributes
  * Uses UILabel `attributedText` property behind the scenes 
  * For Selected, use `UIControl.Selected` state
  * For UnSelected, use `UIControl.Normal` state
* `setIconColor(UIColor , forState:UIControlState)` - Set Tab Bar Item Icon Color
  * For Selected, use `UIControl.Selected` state
  * For UnSelected, use `UIControl.Normal` state

#### SimpleTabBar
* `barItems:[SimpleTabBarItem]` - Get Array of all Tab Bar Items
* `tabBarStyle:SimpleTabBarStyle` - Get current Tab Bar Style applied
* `tabBarCtrol:SimpleTabBarController` - Get parent Tab Bar Controller

#### SimpleTabBarItem
* `index:Int` - Get index of Tab Bar Item
* `barItemView:UIView` - Get main UIView container. Icon & Title are its subviews
* `iconView:UIView` - Get icon view container. Tab Bar Icon image is added as its subview
* `titleLabel:UILabel` - Get Tab Bar Title UILabel

#### SimpleTabBarStyle
* `iconSize:CGSize` - Get or Set Tab Bar Item icon size
* `titleHeight` - Get or Set Tab Bar Item Title UILabel's frame height
* `barFrames:[CGRect]` - Get Tab Bar Item default frame values. Useful for animation


### View Transitions
* Implement any custom view transitions conforming to `UIViewControllerAnimatedTransitioning`
* Set custom view transition by `simpleTBC?.viewTransition = NewViewTransition()`

For examples, checkout [PopViewTransition](Pod/Classes/ViewTransitions/PopViewTransition.swift) and [CrossFadeViewTransition](Pod/Classes/ViewTransitions/CrossFadeViewTransition.swift)

### Tab Bar Item Transitions

* Subclass `SimpleTabBarStyle` 
* Override `tabBarCtrlLoaded()` to setup SimpleTabBar and SimpleTabBarItem

```swift
override public func tabBarCtrlLoaded(tabBarCtrl: SimpleTabBarController, tabBar: SimpleTabBar, selectedIndex: Int) {
    //Setup UI elements to tab bar or tab bar item
    
    //For example lets, setup a selection indicator view
    var selectedItemFrame:CGRect = tabBar.barItems[selectedIndex].frame
    var insets:UIEdgeInsets = UIEdgeInsetsMake(selectedItemFrame.height - selectorHeight, selectorSideInsets, 0, selectorSideInsets)
    selectorView.frame = UIEdgeInsetsInsetRect(selectedItemFrame, insets)
    self.selectorColor = self.iconColors[UIControlState.Selected.rawValue]
    self.selectorView.backgroundColor = self.selectorColor
    
    tabBar.addSubview(selectorView)
}

```

* override `refresh()` to ensure UI elements retains states and layout during view refresh ( orientation change etc )

```swift
override public func refresh() {
    super.refresh()
    //Keep layout intact during orientation change etc
    
    //For example, lets ensure selected bar/tab item state remains during refresh
    
    //Keep layout intact during orientation change etc
    var selectedItemFrame:CGRect = tabBar!.barItems[tabBar!.selectedIndex].frame
    var insets:UIEdgeInsets = UIEdgeInsetsMake(selectedItemFrame.height - selectorHeight, selectorSideInsets, 0, selectorSideInsets)
    selectorView.frame = UIEdgeInsetsInsetRect(selectedItemFrame, insets)
    
    ....
}
```

* override `animateTabTransition()` to manage tab bar item transitions

```swift
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
```


## Author

azfx, abdul.zalil@gmail.com

## License

SimpleTab is available under the MIT license. See the LICENSE file for more info.
