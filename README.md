# Toppon

A lightweight **Scroll-To** button for iOS UIScrollView, UITabelView, UITextView. **Toppon** is a subclass of UIButton. Its not only a **Scroll-To** button but a fully customizable UIButton.


 
## Features
* Lightweight
* Present with popup or ease-in animations.
* Different display modes.
* Set whatever positions you want.
* Different Type for subtitle position.
* Customizable button icon.
* Multiple delegate methods.



#### Installation
---

##### CocoaPods 
For `Swift 4.0`
```
pod 'Toppon'
```


##### Manual 
Simply copy files in sources folder into your project.



#### How to use
---

Initial a Toppon button in a viewcontroller class scope

```swift
init(initPosition: CGPoint?, size: Int, normalIcon: String?)
```
Use properties to configure Toppoon

```swift
func setPresentMode(_ presentMode: PresentMode)
func setDestPosition(_ destPosition: CGPoint?)
func setScrollMode(_ scrollMode: ScrollMode)
func linkedTo(UIScrollView: UIScrollView)
```

##### Delegate methods

```swift
optional func TopponInitiated()
optional func TopponDidPressed()
optional func TopponWillPresent()
optional func TopponWillDismiss()
```



##### Present and Dismiss
call present and dismiss methods when yu need it.
```swift
public func present(_ toppon: Toppon)
public func dismiss(_ toppon: Toppon)
```
###### For Example
You can present and dismiss Toppon button in your ScrollViewDelegate.

```swift
if scrollview.contentOffset.y >= 30 {
    toppon.present(toppon)
} else {
    toppon.dismiss(toppon)
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
