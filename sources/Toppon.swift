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
	
	private var CompletionHandler: (() -> Void)? = nil
	
	private var offset: CGFloat = 0
    
    /// Determines the type of Toppon button present mode.
    /// DEFAULT to Toppon.PresentMode.always
    /// See the presentMode enumerated for more detail.
    public var presentMode: PresentMode = .always
    
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
		guard let newValue = change?[NSKeyValueChangeKey.newKey] as? CGPoint else { return }
        
		if newValue.y >= self.offset {
			show()
		} else {
			print("should dismiss")
		}
	}
    
    private func shouldShowButton(newValue: CGPoint) -> Bool {
        switch self.scrollMode {
        case .top:
            return newValue >= self.offset
        case .bottom:
            return
        }
    }

	deinit {
	  self.removeObserver(self, forKeyPath: #keyPath(UIScrollView.contentOffset))
	}
	
	private func setupUI() {
		
	}
    
    private func show() {
        
    }
    
    private func dismiss() {
        
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
    
    enum ScrollMode {
        case top
        case bottom
    }
}

// MARK: - private helper
extension Toppon {
    
}


extension UIScrollView {
  var minContentOffset: CGPoint {
    return CGPoint(
      x: -contentInset.left,
      y: -contentInset.top)
  }

  var maxContentOffset: CGPoint {
    return CGPoint(
      x: contentSize.width - bounds.width + contentInset.right,
      y: contentSize.height - bounds.height + contentInset.bottom)
  }

  func scrollToMinContentOffset(animated: Bool) {
    setContentOffset(minContentOffset, animated: animated)
  }

  func scrollToMaxContentOffset(animated: Bool) {
    setContentOffset(maxContentOffset, animated: animated)
  }
}
