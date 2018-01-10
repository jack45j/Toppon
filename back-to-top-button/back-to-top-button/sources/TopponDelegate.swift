//
//  TopponDelegate.swift
//  back-to-top-button
//
//  Created by Benson Lin on 2018/1/10.
//  Copyright © 2018年 YochaStudio. All rights reserved.
//

import Foundation

public protocol TopponDelegate {
    func TopponDidLoad(direction: Toppon.Direction)
    func TopponWillShow()
    func TopponDidShow()
    func TopponWillDismiss()
    func TopponDidDismiss()
    func TopponDidPress()
}

public extension TopponDelegate {
    func TopponDidLoad(direction: Toppon.Direction) {
        TopponLog()
    }
    func TopponWillShow() {
        TopponLog()
    }
    func TopponDidShow() {
        TopponLog()
    }
    func TopponWillDismiss() {
        TopponLog()
    }
    func TopponDidDismiss() {
        TopponLog()
    }
    func TopponDidPress() {
        TopponLog()
    }
    
    private func TopponLog(_ function:String = #function) {
        print("[Toppon] The default implementation of \(function) is being called. You can ignore this message if you do not care to implement this method in your `SirenDelegate` conforming structure.")
    }
}
