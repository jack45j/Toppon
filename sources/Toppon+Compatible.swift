//
//  Toppon+Compatible.swift
//  Toppon
//
//  Created by USER on 2020/2/6.
//  Copyright © 2020 YochaStudio. All rights reserved.
//

import Foundation

extension Toppon: TopponCompatible {}
public protocol TopponCompatible {}

extension TopponCompatible where Self: Toppon {
    public var bs: Builder<Self> {
        get { Builder(self) }
    }
}
