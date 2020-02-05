//
//  Toppon.swift
//
//  Created by Benson Lin on 2018/1/10.
//  Copyright © 2018年 YochaStudio. All rights reserved.
//

import Foundation
import UIKit

public struct Builder<T: Toppon> {
	private let _build: () -> T

	@discardableResult
	public func build() -> T {
        _build()
    }

	public init(_ build: @escaping () -> T) {
        self._build = build
    }

    public init(_ base: T) {
        self._build = { base }
    }
}

extension Builder {
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
}

public protocol Compatible {}
extension Compatible where Self: Toppon {
    public var bs: Builder<Self> {
		get { Builder(self) }
    }
}


#if canImport(Foundation)
import Foundation
extension Toppon: Compatible {}
#endif


public class Toppon: UIButton {
    /// Determines Toppon is presented or not.
	private var isPresented: Bool = false
	
	private var CompletionHandler: (() -> Void)? = nil
	
	private var linkedScrollViews: [UIScrollView]!
		
	private var image: UIImage? = nil
    
    /// Determines the type of Toppon button present mode.
    /// DEFAULT to Toppon.PresentMode.always
    /// See the presentMode enumerated for more detail.
    public var presentMode: PresentMode = .always
		
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupUI()
	}
    
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		setupUI()
	}
	
	private func setupUI() {
		
	}
}

/// MARK - Helpers (Config)



public extension Toppon {
    enum PresentMode {
        /// (DEFAULT) Toppon button will always show after ViewController launched.
        case always

        /// Toppon button will move in from initPosition to destPosition with animation.
        /// Call func present(_ toppon: Toppon) to present Toppon button.
        case normal

        /// Toppon button will popup when func present(_ toppon: Toppon) being called.
        case pop
    }
}
