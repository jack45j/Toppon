//
//  Toppon.swift
//  back-to-top-button
//
//  Created by Benson Lin on 2018/1/10.
//  Copyright © 2018年 YochaStudio. All rights reserved.
//

import Foundation
import UIKit

public class Toppon: UIButton {
    
    public var delegate:TopponDelegate?
    
    public init(frame: CGRect,
                normalIcon: String?,
                direction: Direction = .always,
                LabelType: LabelType = .none) {
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
}

public extension Toppon {
    enum Direction {
        /// Toppon button will move in from the top of screen.
        case top
        
        /// Toppon button will move in from the bottom of screen.
        case bottom
        
        /// Toppon button will move in from the left of screen.
        case left
        
        /// Toppon button will move in from the right of screen.
        case right
        
        /// (DEFAULT) Toppon button will always show.
        case always
    }
    
    enum LabelType {
        case top
        case center
        case bottom
        case none
    }
}
