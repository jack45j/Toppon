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
			if presentMode != .normal {
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
//		TopponLog("\(newValue)")
		linkedScrollView = scrollView
		scrollViewOffsetDidChange(to: newValue)
	}
	
	private func setupUI() {
		
	}

	deinit {
	  self.removeObserver(self, forKeyPath: #keyPath(UIScrollView.contentOffset))
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
        
        case custom
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
		case .pop:
			popUpAnimation { completed?() }
		default:
			return
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
	
	private func shouldShowButton(newOffset: CGPoint) -> Bool {
		guard let scrollView = linkedScrollView else { return false }
        switch self.scrollMode {
        case .top:
			return newOffset.y >= self.offset
        case .bottom:
			return newOffset.y + offset <= scrollView.maxContentOffset.y
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
