//
//  TopponDelegate.swift
//  back-to-top-button
//
//  Created by Benson Lin on 2018/1/10.
//  Copyright © 2018年 YochaStudio. All rights reserved.
//

import Foundation

public protocol TopponDelegate: NSObjectProtocol {
    func TopponInitiated()
    func TopponDidPressed()
    func TopponWillPresent()
    func TopponWillDismiss()
}

extension TopponDelegate {
    func ToppondInitiated() {
        printMessage()
    }
    func TopponDidPressed() {
        printMessage()
    }
    func TopponWillPresent() {
        printMessage()
    }
    func TopponWillDismiss() {
        printMessage()
    }
}

public extension TopponDelegate {
    private func printMessage(_ function:String = #function) {
        TopponLog("The default implementation of \(function) is being called.")
    }
}
