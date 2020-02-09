//
//  Toppon.swift
//
//  Created by Benson Lin on 2018/1/10.
//  Copyright © 2018年 YochaStudio. All rights reserved.
//

import Foundation
import UIKit

public class Toppon: UIButton {
    /// Determines Toppon is presented or not.
	private var isPresented: Bool = false
	
	typealias completionHandler = (() -> Void)?
	
	private var offset: CGFloat = 100
    
	private var linkedScrollView: UIScrollView!
	
	public var presentMode: PresentMode = .always {
		didSet {
			switch presentMode {
			case .normal:
				return
			default:
				self.presentDirection = .none
			}
		}
	}
	
    public var scrollMode: ScrollMode = .top
	
	public var presentDirection: PresentDirection = .none
		
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupUI()
	}
    
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		setupUI()
	}
	
	override public func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
		
		guard let newValue = change?[NSKeyValueChangeKey.newKey] as? CGPoint,
			  let scrollView = object as? UIScrollView else { return }
		linkedScrollView = scrollView
		scrollViewOffsetDidChange(to: newValue)
	}
	
	private func setupUI() {
		
	}

	deinit {
	  self.removeObserver(self, forKeyPath: #keyPath(UIScrollView.contentOffset))
	}
}

extension Builder where T: Toppon {
    public func setBackground(color: UIColor) -> Builder<T> {
        return Builder {
            let obj = self.build()
            obj.backgroundColor = color
            return obj
        }
    }
    
    public func setBackground(image: UIImage, for state: UIControlState = .normal) -> Builder<T> {
        return Builder {
            let obj = self.build()
            obj.setBackgroundImage(image, for: state)
            return obj
        }
    }
    
    public func setTitle(_ title: String?, color: UIColor? = nil, for state: UIControlState = .normal) -> Builder<T> {
        return Builder {
            let obj = self.build()
            obj.setTitle(title, for: state)
            guard let color = color else { return obj }
            obj.setTitleColor(color, for: state)
            return obj
        }
    }
	
	public func style(_ style: T.ScrollMode) -> Builder<T> {
		return Builder {
			let obj = self.build()
			obj.scrollMode = style
			return obj
		}
	}
    
    public func bind(to scrollView: UIScrollView) -> Builder<T> {
        return Builder {
            let obj = self.build()
            scrollView.addObserver(obj, forKeyPath: #keyPath(UIScrollView.contentOffset), options: [.new], context: nil)
            return obj
        }
    }
	
	public func presentMode(_ mode: Toppon.PresentMode) -> Builder<T> {
		return Builder {
			let obj = self.build()
			obj.presentMode = mode
//			switch mode {
//			case .pop:
//				return obj
//			case .custom(let animator, let before, let animation):
//				obj.presentMode = .custom(animator: animator, onBegin: before, onNext: animation)
//			default:
//				return obj
//			}
			return obj
		}
	}
}


// MARK: - Helper

public extension Toppon {
    enum PresentMode {
        /// (DEFAULT) Toppon button will always show after ViewController launched.
        case always

        /// Toppon button will move in from initPosition to destPosition with animation.
        /// Call func present(_ toppon: Toppon) to present Toppon button.
        case normal

        /// Toppon button will popup when func present(_ toppon: Toppon) being called.
        case pop
        
		case custom(animator: UIViewPropertyAnimator, onBegin: (() -> Void)? = nil, onNext: (() -> Void)? = nil)
    }
	
	enum PresentDirection {
		case top
		case right
		case bottom
		case left
		case none
	}
    
    enum ScrollMode {
        case top
        case bottom
    }
}

// MARK: - private helper
extension Toppon {
	
	private func show(completed: (() -> Void)? = nil) {
		TopponLog("\(#function)")
		isPresented = true
		switch presentMode {
		case .always:
			completed?()
		case .normal:
			completed?()
		case .pop:
			self.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
			self.alpha = 1.0
			let animator = UIViewPropertyAnimator(duration: 0.5, dampingRatio: 0.5)
			animator.addAnimations {
				self.transform = CGAffineTransform.identity.scaledBy(x: 1.0, y: 1.0)
			}
			animator.addCompletion { _ in completed?() }
			animator.startAnimation()
		case .custom(let animator, let before, let animation):
			if let actionBeforeAnimate = before,
				let animation = animation {
				actionBeforeAnimate()
				animator.addAnimations(animation)
			}
			animator.startAnimation()
		}
    }
	
    private func dismiss(completed: (() -> Void)? = nil) {
        TopponLog("\(#function)")
		isPresented = false
		
		switch presentMode {
		case .pop:
			popDownAnimation { completed?() }
		default:
			return
		}
    }
	
	private func scrollViewOffsetDidChange(to newOffset: CGPoint) {
		guard let scrollView = linkedScrollView else { return }
		switch scrollMode {
		case .top:
			if newOffset.y >= offset {
				guard !isPresented else { return }
				show()
			} else {
				guard isPresented else { return }
				dismiss()
			}
		case .bottom:
			if newOffset.y + offset <= scrollView.maxContentOffset.y {
				guard !isPresented else { return }
				show()
			} else {
				guard isPresented else { return }
				dismiss()
			}
		}
	}
}

extension Toppon {
	
	private func popUpAnimation(completed: (() -> Void)? = nil) {
		self.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
        self.alpha = 1.0
        UIView.animate(withDuration: 0.3,
                       delay: 0.0,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 0.3,
                       options: .curveEaseInOut,
                       animations: {
                        self.transform = CGAffineTransform.identity.scaledBy(x: 1.0, y: 1.0)
        }, completion: { _ in completed?() })
	}
	
	private func popDownAnimation(completed: (() -> Void)? = nil) {
		self.transform = CGAffineTransform(scaleX: 1, y: 1)
		UIView.animate(withDuration: 0.3,
					   delay: 0.1,
					   usingSpringWithDamping: 0.4,
					   initialSpringVelocity: 0.3,
					   options: .curveEaseIn,
					   animations: {
						self.transform = CGAffineTransform(scaleX:0, y:0)
						self.alpha = 0.0
		}, completion: { _ in completed?() })
	}
}
