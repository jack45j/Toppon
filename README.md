# Toppon

A lightweight **Scroll-To** button for iOS UIScrollView, UITabelView, UITextView. **Toppon** is a subclass of UIButton. Its not only a **Scroll-To** button but a fully customizable UIButton.

![Preview](https://github.com/jack45j/Toppon/blob/master/Assets/demo.gif)

## Features
* Lightweight
* Present with different animations.
* Multiple display modes.
* Set whatever positions you want.
* Customizable button icon.
* Multiple delegate methods.



## Installation
---

##### CocoaPods
For `Swift 4.2`
```ruby
pod 'Toppon'
```


##### Manual
Simply copy files in sources folder into your project.



#### How to use
---

Initial a Toppon button.

```swift
init(initPosition: CGPoint?, size: Int, normalIcon: String?)
```
Use properties to configure Toppoon

```swift
var destPosition: CGPoint? = CGPoint(x:0, y:0)
var presentMode: PresentMode = .always
var scollMode: ScrollMode = .top
```

Link Toppon to a UIScrollView or its subclass like UITableView and UITextView.
```swift
public func linkedTo(UIScrollView: UIScrollView)
```

##### Delegate methods

```swift
optional func TopponInitiated()
optional func TopponDidPressed()
optional func TopponWillPresent()
optional func TopponWillDismiss()
```



##### Present and Dismiss
Call present and dismiss methods when you need it.
```swift
public func present()
public func dismiss()
```
###### For Example
You can present and dismiss Toppon button in your ScrollViewDelegate.

```swift
if scrollview.contentOffset.y >= 30 {
  toppon.present()
} else {
  toppon.dismiss()
}
```

## License
Toppon is released under the MIT license.
See [LICENSE](./LICENSE) for details.



## Author
This project is still work in progress.
Feel free to contact me.
[Benson Lin](https://www.facebook.com/profile.php?id=100000238070025)



## What features are going to release.
1) Support storyboard
2) Optimize methods and animations
3) Add a Label above/under Toppon button

