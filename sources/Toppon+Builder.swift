//
//  Toppon+Builder.swift
//  Toppon
//
//  Created by USER on 2020/2/6.
//  Copyright © 2020 YochaStudio. All rights reserved.
//

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


extension Builder where T: Toppon {
    public func setBackground(color: UIColor) -> Builder<T> {
        return Builder {
            let obj = self.build()
            obj.backgroundColor = color
            return obj
        }
    }
    
    public func setBackground(image: UIImage?, for state: UIControlState = .normal) -> Builder<T> {
        return Builder {
            let obj = self.build()
			guard let image = image else { return obj }
			obj.clipsToBounds = true
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
	
	public func scrollMode(_ mode: T.ScrollMode) -> Builder<T> {
		return Builder {
			let obj = self.build()
			obj.scrollMode = mode
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
			return obj
		}
	}
}
