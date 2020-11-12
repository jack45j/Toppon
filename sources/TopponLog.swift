//
//  TopponLog.swift
//
//  Created by Benson Lin on 2018/1/10.
//  Copyright © 2018年 YochaStudio. All rights reserved.
//

import Foundation

extension Toppon {
	func TopponLog(_ message: String) {
		if debug { print("[Toppon] \(message)") }
	}
}
