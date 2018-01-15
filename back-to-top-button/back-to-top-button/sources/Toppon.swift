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
    /// The TopponDelegate variable, which should be set if you'd like to be notified.
    ///  public weak var delegate: TopponDelegate?
    
    public lazy var destPosition: CGPoint? = CGPoint(x:0, y:0)
    
    public lazy var presentMode: PresentMode = .always
    
    public lazy var labelType: LabelType = .none
    
    public init(initPosition: CGPoint?, 
                size: Int,
                normalIcon: String?) {
        let ViewSize = CGSize(width: size, height: size)
        super.init(frame: CGRect(origin: initPosition!, size: ViewSize))
        
        if presentMode == .always {
            self.frame.origin = destPosition!
        }
        
        if let icon = normalIcon {
            setImage(UIImage(named: icon), for: .normal)
        }
        
        TopponInitial()
    }
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    func TopponInitial() {
        self.alpha = 0.0
        //self.addTarget(self, action: #selector(TopponPressed), for: .touchUpInside)
        self.addTarget(self, action: #selector(animationPressed(sender:)), for: .touchUpInside)
    }
    
    public func setDestPosition(destPosition: CGPoint) {
        self.destPosition! = destPosition
        self.frame.origin = self.destPosition!
    }
    
    public func present(_ toppon: Toppon, duration: Double, delay: Double) {
        UIView.animate(withDuration: duration,
                       delay: delay,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 10.0,
                       animations: {
                        toppon.alpha = 1
                        if toppon.presentMode != .always {
                            toppon.frame.origin = toppon.destPosition!
                        }
            })
    }
}






public extension Toppon {
    enum PresentMode {
        /// Toppon button will move in with animation.
        case normal
        
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

public extension Toppon {
    @objc func animationPressed(sender: Toppon) {
        UIView.animate(withDuration: 0.1,
                       delay: 0,
                       options: .autoreverse,
                       animations: {
                        sender.transform = CGAffineTransform(scaleX: 0.85, y: 0.85)
                    }, completion: {(t) in
                        sender.transform = CGAffineTransform(scaleX: 1, y: 1)
                        self.animationMoveOut(sender: sender)
        })
    }
    
    @objc func animationMoveOut(sender: Toppon) {
        print("Go")
    }
}
