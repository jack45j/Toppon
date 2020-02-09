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
	
	private var offset: CGFloat = 100
    
	private var linkedScrollView: UIScrollView!
	
	public var presentMode: PresentMode = .always {
		didSet {
			switch presentMode {
			case .always:
				self.alpha = 1
			default:
				self.alpha = 0
			}
		}
	}
	
    public var scrollMode: ScrollMode = .top
		
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
		self.addTarget(self, action: #selector(buttonDidPressed), for: .touchUpInside)
	}

	deinit {
		self.removeObserver(self, forKeyPath: #keyPath(UIScrollView.contentOffset))
		self.removeTarget(nil, action: nil, for: .allEvents)
	}
	
	@objc private func buttonDidPressed() {
		guard let linkedScrollView = linkedScrollView else { return }
		linkedScrollView.setContentOffset(scrollMode == .top ? .zero : linkedScrollView.maxContentOffset,
										  animated: true)
		
	}
}


// MARK: - Helper

public extension Toppon {
    enum PresentMode {
        case always
		case normal(direction: PresentDirection)
        case pop
		case custom(
			showAnimator: UIViewPropertyAnimator,
			showBegin: (() -> Void)? = nil,
			dismissAnimator: UIViewPropertyAnimator,
			dismissBegin: (() -> Void)? = nil)
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
			
		case .custom(let showAnimator,
					 let showBegin,
					 let dismissAnimator, _):
			if showAnimator.isRunning {
				showAnimator.stopAnimation(true)
				showAnimator.finishAnimation(at: .start)
			} else if dismissAnimator.isRunning {
				dismissAnimator.stopAnimation(true)
				dismissAnimator.finishAnimation(at: .start)
			}
			if let actionBeforeAnimate = showBegin {
				actionBeforeAnimate()
			}
			
			showAnimator.startAnimation()
		}
    }
	
    private func dismiss(completed: (() -> Void)? = nil) {
        TopponLog("\(#function)")
		isPresented = false
		
		switch presentMode {
		case .pop:
			popDownAnimation { completed?() }
			
		case .custom(let showAnimator, _,
					 let dismissAnimator,
					 let dismissBegin):
			if showAnimator.isRunning {
				showAnimator.stopAnimation(true)
				showAnimator.finishAnimation(at: .start)
			} else if dismissAnimator.isRunning {
				dismissAnimator.stopAnimation(true)
				dismissAnimator.finishAnimation(at: .start)
			}
			if let actionBeforeAnimate = dismissBegin {
				actionBeforeAnimate()
			}
			dismissAnimator.startAnimation()
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
