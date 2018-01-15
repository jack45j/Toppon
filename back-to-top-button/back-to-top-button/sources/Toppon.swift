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
    public weak var delegate: TopponDelegate?
    
    /// destination position of Topon button.
    /// Will not be use if presentMode isn't Toppon.PresentMode.normal
    public lazy var destPosition: CGPoint? = CGPoint(x:0, y:0)
    
    /// Determines the type of Toppon button present mode.
    /// Default to Toppon.PresentMode.pop
    /// see the presentMode enum for more detail.
    public lazy var presentMode: PresentMode? = .pop
    
    /// Determines the type of Toppon button label position.
    /// Default to LabelType.none
    /// See the LabelType enum for more detail.
    public lazy var labelType: LabelType? = .none
    
    public lazy var labelText: String? = "Top"
    
    public lazy var labelTextFont : UIFont? = UIFont.systemFont(ofSize: 17.0)
    
    ///.public lazy var 
    
    /// Initial and return a Toppon object
    /// parameter initPosition: The initial position of Toppon button.
    /// parameter size:         The width and height for the frame size of Toppon.
    /// parameter normalIcon:   The image to use for the specified normal state.
    public init(initPosition: CGPoint?, 
                size: Int,
                normalIcon: String?) {
        let ViewSize = CGSize(width: size, height: size)
        super.init(frame: CGRect(origin: initPosition!, size: ViewSize))
        
        if let icon = normalIcon {
            setImage(UIImage(named: icon), for: .normal)
        }
        TopponInitial()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func TopponInitial() {
        self.alpha = 0.0
        self.addTarget(self, action: #selector(animationPressed(sender:)), for: .touchUpInside)
    }
    
    /// Set Toppon button destination position.
    /// Will not be used if presentMode set as Toppon.PresentMode.always
    public func setDestPosition(destPosition: CGPoint) {
        self.destPosition! = destPosition
        self.frame.origin = self.destPosition!
    }
    public func setPresentMode(presentMode: PresentMode) {
        self.presentMode! = presentMode
    }
    public func setLabelType(labelType: LabelType) {
        self.labelType! = labelType
    }
    
    /// Animation for presenting Toppon button.
    public func present(_ toppon: Toppon, duration: Double, delay: Double) {
        UIView.animate(withDuration: duration,
                       delay: delay,
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
        
        ///Toppon button will popup when app did launch.
        case pop
        
        /// (DEFAULT) Toppon button will always show.
        /// if
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
