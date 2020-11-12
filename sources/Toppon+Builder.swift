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
	
	public func setActions(didPressed: @escaping (() -> Void),
						   didShow: @escaping (() -> Void),
						   didDismiss: @escaping (() -> Void)) -> Builder<T> {
		return Builder {
			let obj = self.build()
			obj.didPressedAction = didPressed
			obj.didShowAction = didShow
			obj.didDismissAction = didDismiss
			return obj
		}
	}
	
	public func debug(_ enable: Bool = true) -> Builder<T> {
		return Builder {
			let obj = self.build()
			obj.debug = enable
			return obj
		}
	}
	
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
    
	public func bind(to scrollView: UIScrollView, distance: CGFloat = 50) -> Builder<T> {
        return Builder {
            let obj = self.build()
			obj.triggeredDistance = distance
			obj.linkedScrollView = scrollView
			guard obj.linkedScrollView == scrollView else {
				obj.TopponLog("Misleading linked ScrollView.")
				return obj
			}
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
	
	public func setImage(_ image: UIImage?, for state: UIControlState = .normal) -> Builder<T> {
		return Builder {
			let obj = self.build()
			obj.setImage(image, for: state)
			return obj
		}
	}
}
