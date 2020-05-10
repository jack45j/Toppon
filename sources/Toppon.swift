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
	
	private var triggeredDistance: CGFloat = 50
    
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
	
	public func show(with completionHandler: (() -> Void)? = nil) {
		self.showTP(completed: completionHandler)
	}
}


// MARK: - Helper

public extension Toppon {
    enum PresentMode {
        case always
		case normal(direction: PresentDirection)
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
}

// MARK: - private helper
extension Toppon {
	
	private func showTP(completed: (() -> Void)? = nil) {
		TopponLog("\(#function)")
		isPresented = true
		
		switch presentMode {
		case .pop:
			let anm = animation.fillAnimation(1, amplitude: 0.35, reverse: false)
			let opacityAnimation = animation.opacityAnimation(false)
			self.layer.opacity = 1.0
			CATransaction.begin()
			CATransaction.setCompletionBlock {
				self.layer.removeAllAnimations()
				self.layer.transform = CATransform3DMakeScale(1.0, 1.0, 1.0)
				self.layer.opacity = 1.0
			}
			self.layer.add(anm, forKey: "transform")
			self.layer.add(opacityAnimation, forKey: "opacity")
			
			CATransaction.commit()
		default: ()
		}
		
		
    }
	
    private func dismissTP(completed: (() -> Void)? = nil) {
        TopponLog("\(#function)")
		isPresented = false
		
		switch presentMode {
		case .pop:
			let anm = animation.fillAnimation(1, amplitude: 0.18, reverse: true)
			//		let opacityAnimation = animation.opacityAnimation(true)
					CATransaction.begin()
					CATransaction.setCompletionBlock {
						self.layer.removeAllAnimations()
						self.layer.transform = CATransform3DMakeScale(0.0, 0.0, 0.0)
						self.layer.opacity = 0.0
					}
					self.layer.add(anm, forKey: "transform")
			//		self.layer.add(opacityAnimation, forKey: "opacity")
					
					CATransaction.commit()
		default: ()
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
