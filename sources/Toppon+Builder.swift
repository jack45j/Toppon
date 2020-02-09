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
