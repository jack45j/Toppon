//
//  TopponDelegate.swift
//  back-to-top-button
//
//  Created by Benson Lin on 2018/1/10.
//  Copyright © 2018年 YochaStudio. All rights reserved.
//

import Foundation

//@objc public protocol TopponDelegate: NSObjectProtocol {
//    @objc optional func Toppon(WillShow toppon:Toppon)
//    func TopponDidShow()
//    func TopponWillDismiss()
//    func TopponDidDismiss()
//    func TopponDidPress()
//}
//
//public extension TopponDelegate {
//    func Toppon(WillShow toppon:Toppon) {
//        printMessage()
//    }
//    func TopponDidShow() {
//        printMessage()
//    }
//    func TopponWillDismiss() {
//        printMessage()
//    }
//    func TopponDidDismiss() {
//        printMessage()
//    }
//    func TopponDidPress() {
//        printMessage()
//    }

    private func printMessage(_ function:String = #function) {
        TopponLog("The default implementation of \(function) is being called. You can ignore this message if you do not care to implement this method in your `SirenDelegate` conforming structure.")
    }
//}

