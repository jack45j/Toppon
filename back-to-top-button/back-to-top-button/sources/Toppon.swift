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
    
    /// Destination position of Topon button.
    /// Will not be use if presentMode isn't Toppon.PresentMode.normal
    public lazy var destPosition: CGPoint? = CGPoint(x:0, y:0)
    
    /// Determines the type of Toppon button present mode.
    /// Default to Toppon.PresentMode.pop
    /// see the presentMode enum for more detail.
    private lazy var presentMode: PresentMode? = .always
    
    /// Determines the type of Toppon button label position.
    /// Default to LabelType.none
    /// See the LabelType enum for more detail.
    public lazy var labelType: LabelType? = .none
    
    /// Label text for Toppon button.
    /// Default to LabelType.none
    /// Set LabelType to others for displaying label text.
    public lazy var labelText: String? = "Top"
    
    /// Custom label text font style and size.
    public lazy var labelTextFont : UIFont? = UIFont.systemFont(ofSize: 17.0)
    
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
        self.addTarget(self, action: #selector(animationPressedScale(sender:)), for: .touchUpInside)
    }
    
    public func setPresentMode(_ presentMode: PresentMode) {
        self.presentMode = presentMode
        if presentMode != .always {
            alpha = 0.0
        }
    }
    
    /// Animation for presenting Toppon button.
    public func present(_ toppon: Toppon) {
        switch self.presentMode {
        case .normal? :
            TopponLog("Present mode set to normal.")
        case .pop? :
            TopponLog("Present mode set to pop.")
            animationPopUp(sender: toppon)
        case .always? :
            TopponLog("Present mode set to always.")
        default :
            fatalError("Present mode unknown.")
        }
    }
}






public extension Toppon {
    enum PresentMode {
        /// Toppon button will move in from initPosition to destPosition with animation.
        case normal
        
        /// Toppon button will popup when func present(_ toppon: Toppon) being called.
        case pop
        
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
    @objc func animationNormalMoveIn(sender: Toppon) {
        
    }
    @objc func animationNormalMoveOut(sender: Toppon) {
        
    }
    func animationPopUp(sender: Toppon) {
        sender.transform = CGAffineTransform(scaleX:0.001, y:0.001)
        sender.alpha = 1.0
        UIView.animate(withDuration: 0.3,
                       delay: 0.0,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 0.3,
                       options: .curveEaseInOut,
                       animations: {
                        sender.transform = CGAffineTransform.identity.scaledBy(x: 1.0, y: 1.0)
        }, completion: nil)
    }
    
    @objc func animationPressedScale(sender: Toppon) {
        delegate?.TopponDidPressed()
        UIView.animate(withDuration: 0.1,
                       delay: 0,
                       options: .autoreverse,
                       animations: {
                        sender.transform = CGAffineTransform(scaleX: 0.85, y: 0.85)
                    }, completion: {(t) in
                        sender.transform = CGAffineTransform(scaleX: 1, y: 1)
                        self.animationNormalMoveOut(sender: sender)
        })
    }
    
}
