# Toppon

A lightweight **Scroll-To** button for iOS UIScrollView, UITabelView, UITextView. **Toppon** is a subclass of UIButton. Its not only a **Scroll-To** button but a fully customizable UIButton.

![Preview](https://github.com/jack45j/Toppon/blob/master/Assets/demo.gif)

## Features
* Lightweight
* Present with different animations.
* Multiple display modes.
* Set whatever positions you want.
* Customizable button icon.



## Installation
---

##### CocoaPods
For `Swift 4.2` or greater
```ruby
pod 'Toppon'
```


##### Manual
Simply copy files in sources folder into your project.



#### How to use
---

Toppon used a builder to initialize itself and using flat style API to configure
You can create a Toppon button like this.

```Swift
let toppon = Toppon() // or @IBOutlet weak var toppon: Toppon! 
toppon.builder
	.bind(to: scrollview, distance: 100) // Always need to bind Toppon with a UIScrollView.
	.scrollMode(.top)
	.presentMode(.pop)
	.setImage(UIImage(named: "ScrollToBottom")!)
	.build() // Must call this method to apply configuration to Toppon.
```

#### Configuration methods
```Swift
func bind(to scrollView: UIScrollView, distance: CGFloat = 50)
func debug(_ enable: Bool = true)
func scrollMode(_ mode: T.ScrollMode)
func presentMode(_ mode: Toppon.PresentMode)
func setBackground(image: UIImage?, for state: UIControl.State = .normal)
func setImage(_ image: UIImage?, for state: UIControl.State = .normal)
func setActions(didPressed: @escaping (() -> Void), didShow: @escaping (() -> Void), didDismiss: @escaping (() -> Void))
```
---

## License
Toppon is released under the MIT license.
See [LICENSE](./LICENSE) for details.



## Author
This project is still work in progress.
Feel free to contact me.
[Benson Lin](https://www.facebook.com/profile.php?id=100000238070025)



## What features are going to release.
1) More animation styles.
2) Optimize methods and animations
3) Add a Label above/under Toppon button

