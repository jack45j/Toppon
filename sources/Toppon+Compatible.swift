//
//  Toppon+Compatible.swift
//  Toppon
//
//  Created by USER on 2020/2/6.
//  Copyright © 2020 YochaStudio. All rights reserved.
//

import Foundation

public protocol TopponCompatible {}
extension Toppon: TopponCompatible {}

extension TopponCompatible where Self: Toppon {
    public var builder: Builder<Self> {
        get { Builder(self) }
    }
}
