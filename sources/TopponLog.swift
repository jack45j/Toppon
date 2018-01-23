//
//  TopponLog.swift
//
//  Created by Benson Lin on 2018/1/10.
//  Copyright © 2018年 YochaStudio. All rights reserved.
//

import Foundation

struct TopponLog {
    @discardableResult
    init(_ message: String) {
        print("[Toppon] \(message)")
    }
}
