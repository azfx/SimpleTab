# Customizations
### Available Properties & Methods
#### SimpleTabBarController

Set View Transition
* `viewTransition:UIViewControllerAnimatedTransitioning` - Set View Transition
* `tabBarStyle:SimpleTabBarStyle` - Set Tab Bar Style
* `setTitleTextAttributes(attributes:[NSObject:AnyObject] , forState: UIControlState)` - Set Tab Bar Item Title (UILabel) text attributes
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
