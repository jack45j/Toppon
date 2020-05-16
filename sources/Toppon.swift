//
//  Toppon.swift
//
//  Created by Benson Lin on 2018/1/10.
//  Copyright © 2018年 YochaStudio. All rights reserved.
//

import Foundation
import UIKit

public typealias ActionHandler = (() -> Void)?
public class Toppon: UIButton {
	
	public var debug: Bool = false
	
	public var didShowAction: ActionHandler = nil
	public var didDismissAction: ActionHandler = nil
	public var didPressedAction: ActionHandler = nil
	
    /// Determines Toppon is presented or not.
	private var isPresented: Bool = false
	
	/// The scroll offset to show or hide button.
	public var triggeredDistance: CGFloat = 50
    
	public var linkedScrollView: UIScrollView!
	
	private var currentOffset: CGPoint = .zero
	
	public var presentMode: PresentMode? {
		didSet {
			switch presentMode {
			case .always: 	alpha = 1
			default:		alpha = 0
			}
		}
	}
	
    public var scrollMode: ScrollMode = .top
	
	private var animation: TopponAnimationGenerator = TopponAnimationGenerator()
	
	public var isObserving = false
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupUI()
	}
    
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		setupUI()
	}
	
	private func setupUI() {
		self.addTarget(self, action: #selector(buttonDidPressed), for: .touchUpInside)
	}
	
	@objc private func buttonDidPressed() {
		didPressedAction?()
		guard let linkedScrollView = linkedScrollView else { return }
		linkedScrollView.setContentOffset(scrollMode == .top ? .zero : linkedScrollView.maxContentOffset,
										  animated: true)
	}
	
	public override func willMove(toWindow newWindow: UIWindow?) {
		super.willMove(toWindow: newWindow)
		self.scrollViewOffsetDidChange(to: .zero)
	}

	deinit {
		self.removeObserver(self, forKeyPath: #keyPath(UIScrollView.contentOffset))
		self.removeTarget(nil, action: nil, for: .allEvents)
	}
	
	override public func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
		guard
			keyPath == #keyPath(UIScrollView.contentOffset),
			let newValue = change?[NSKeyValueChangeKey.newKey] as? CGPoint,
			let scrollView = object as? UIScrollView,
			newValue != currentOffset
		else { return }
		currentOffset = newValue
		linkedScrollView = scrollView
		scrollViewOffsetDidChange(to: newValue)
	}
	
	public func show(with completionHandler: (() -> Void)? = nil) {
		self.showTP(completed: completionHandler)
	}
}


// MARK: - Helper

public extension Toppon {
	enum PresentMode {
        case always
		case normal(direction: PresentDirection = .auto)
        case pop
    }
	
	enum PresentDirection {
		case top
		case right
		case bottom
		case left
		case auto
		case none
	}
    
    enum ScrollMode {
        case top
        case bottom
    }
	
	enum Animations {
		case transform(TopponAnimationGenerator, isReverse: Bool)
		case opacity(TopponAnimationGenerator, isReverse: Bool)
		
		var keyPath:String {
			switch self {
			case .transform(_): return "transform"
			case .opacity(_):	return "opacity"
			}
		}
		
		func animate() -> CAAnimation {
			switch self {
			case .transform(let animation, let isReverse):
				return animation.fillAnimation(1, amplitude: 0.5, reverse: isReverse)
			case .opacity(let animation, let isReverse):
				return animation.opacityAnimation(isReverse)
			}
		}
	}
}

// MARK: - private helper
extension Toppon {
	
	private func showTP(completed: (() -> Void)? = nil) {
		TopponLog("\(#function)")
		didShowAction?()
		isPresented = true
		
		switch presentMode {
		case .pop:
			self.layer.opacity = 1.0
			excuteAnimations(animations:
								.transform(animation, isReverse: false),
								.opacity(animation, isReverse: false)
			) { self.resetStatus(isReverse: false) }
		default: ()
		}
    }
	
    private func dismissTP(completed: (() -> Void)? = nil) {
        TopponLog("\(#function)")
		didDismissAction?()
		isPresented = false
		
		switch presentMode {
		case .pop:
			excuteAnimations(animations:
								.transform(animation, isReverse: true),
								.opacity(animation, isReverse: true)
			) { self.resetStatus(isReverse: true) }
		default: ()
		}
    }
	
	func excuteAnimations(animations: Animations..., completion: (() -> Void)?) {
		CATransaction.begin()
		CATransaction.setCompletionBlock(completion)
		for animation in animations {
			self.layer.add(animation.animate(), forKey: animation.keyPath)
		}
		CATransaction.commit()
	}
	
	func resetStatus(isReverse: Bool) {
		self.layer.removeAllAnimations()
		if isReverse {
			self.layer.transform = CATransform3DMakeScale(0.0, 0.0, 0.0)
			self.layer.opacity = 0.0
		} else {
			self.layer.transform = CATransform3DMakeScale(1.0, 1.0, 1.0)
			self.layer.opacity = 1.0
		}
	}
	
	private func scrollViewOffsetDidChange(to newOffset: CGPoint) {
		TopponLog("\(#function)。\(newOffset)")
		guard let scrollView = linkedScrollView else { return }
		switch presentMode {
		case .always: return
		default:
			switch scrollMode {
			case .top:
				if newOffset.y >= triggeredDistance {
					guard !isPresented else { return }
					showTP()
				} else {
					guard isPresented else { return }
					dismissTP()
				}
			case .bottom:
				if newOffset.y + triggeredDistance <= scrollView.maxContentOffset.y {
					guard !isPresented else { return }
					showTP()
				} else {
					guard isPresented else { return }
					dismissTP()
				}
			}
		}
	}
}
