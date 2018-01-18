//
//  Toppon.swift
//
//  Created by Benson Lin on 2018/1/10.
//  Copyright © 2018年 YochaStudio. All rights reserved.
//

import Foundation
import UIKit

public class Toppon: UIButton {
    /// The TopponDelegate variable, which should be set if you'd like to be notified.
    /// See TopponDelegate.swift for more detail.
    public weak var delegate: TopponDelegate?
    
    /// Destination position of Topon button.
    /// Will not be use if presentMode isn't Toppon.PresentMode.normal
    private lazy var destPosition: CGPoint? = CGPoint(x:0, y:0)
    private lazy var initPosition: CGPoint? = CGPoint(x:0, y:0)
    
    /// Link a UIScrollView or its subclass to Toppon.
    /// The UIScrollView will scroll to top/bottom after Toppon pressed.
    private var linkedUIScrollView: UIScrollView?
    
    /// Determines the type of Toppon button present mode.
    /// DEFAULT to Toppon.PresentMode.always
    /// See the presentMode enumerated for more detail.
    private lazy var presentMode: PresentMode = .always
    
    /// Determines the type of Toppon button scroll mode.
    /// DEFAULT to Toppon.ScrollMode.top
    /// See the ScrollMode enumerated for more detail.
    private lazy var scollMode: ScrollMode = .top
    
    /// Determines the type of Toppon button label position.
    /// DEFAULT to LabelType.none
    /// See the LabelType enumerated for more detail.
    private lazy var labelType: LabelType = .none
    
    /// Label text for Toppon button.
    /// DEFAULT to LabelType.none
    /// Set LabelType to others for displaying label text.
    private lazy var labelText: String? = "Top"
    
    /// Custom label text font style and size.
    private lazy var labelTextFont: UIFont? = UIFont.systemFont(ofSize: 17.0)
    
    /// Determines Toppon is presented or not.
    private var isPresented: Bool = false
    
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
        self.initPosition = initPosition
        TopponInitial()
    }
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    fileprivate func TopponInitial() {
        self.addTarget(self, action: #selector(animationPressedScale(sender:)), for: .touchUpInside)
        self.addTarget(self, action: #selector(scroll), for: .touchUpInside)
        delegate?.ToppondInitiated()
    }
}

/// MARK - Helpers (Config)

extension Toppon {
    public func setDestPosition(_ destPosition: CGPoint?) {
        self.destPosition = destPosition!
    }
    
    public func setPresentMode(_ presentMode: PresentMode) {
        self.presentMode = presentMode
        if presentMode != .always {
            alpha = 0.0
        }
    }
    
    public func setLabelType(_ labelType: LabelType) {
        self.labelType = labelType
    }
    
    public func setLabelText(_ labelText: String?) {
        self.labelText = labelText!
    }
    
    public func setLabelTextFont(_ labelTextFont: UIFont?) {
        self.labelTextFont = labelTextFont!
    }
    
    public func setScrollMode(_ scrollMode: ScrollMode) {
        self.scollMode = scrollMode
    }
    
    public func linkedTo(UIScrollView: UIScrollView) {
        self.linkedUIScrollView = UIScrollView
    }
}

/// MARK - Helpers (Behavior)

extension Toppon {
    public func present(_ toppon: Toppon) {
        if !isPresented {
            delegate?.TopponWillPresent()
            switch self.presentMode {
            case .normal :
                animationNormalMoveIn(sender: toppon)
            case .pop :
                animationPopUp(sender: toppon)
            case .always :
                break
            }
            isPresented = true
        }
    }
    
    public func dismiss(_ toppon: Toppon) {
        if isPresented {
            delegate?.TopponWillDismiss()
            switch self.presentMode {
            case .normal :
                animationNormalMoveOut(sender: toppon)
            case .pop :
                animationPopDown(sender: toppon)
            case .always :
                break
            }
            isPresented = false
        }
    }
    
    @objc private func scroll() {
        switch  self.scollMode {
        case .top:
            self.linkedUIScrollView!.setContentOffset(.zero, animated: true)
        case .bottom:
            let bottomOffset = linkedUIScrollView!.contentSize.height - linkedUIScrollView!.bounds.size.height
            self.linkedUIScrollView!.setContentOffset(CGPoint(x: 0, y: bottomOffset), animated: true)
        }
    }
}

/// Mark - Enumerated Types (Public)

public extension Toppon {
    enum PresentMode {
        /// (DEFAULT) Toppon button will always show after ViewController launched.
        case always
        
        /// Toppon button will move in from initPosition to destPosition with animation.
        /// Call func present(_ toppon: Toppon) to present Toppon button.
        case normal
        
        /// Toppon button will popup when func present(_ toppon: Toppon) being called.
        case pop
    }
    
    enum LabelType {
        case top
        case center
        case bottom
        case none
    }
    
    enum ScrollMode {
        /// (DEFAULT) The linked UIScrollView will scroll to top after Toppon pressed.
        case top
        
        /// The linked UIScrollView will scroll to bottom after Toppon pressed.
        case bottom
    }
}

/// MARK - Animations

public extension Toppon {
    func animationNormalMoveIn(sender: Toppon) {
        UIView.animate(withDuration: 1.0,
                       delay: 0.0,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 0.3,
                       options: .curveEaseOut,
                       animations: {
                        sender.frame.origin = self.destPosition!
                        sender.alpha = 1.0
        }, completion: nil)
    }
    func animationNormalMoveOut(sender: Toppon) {
        UIView.animate(withDuration: 1.0,
                       delay: 0.0,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 0.3,
                       options: .curveEaseIn,
                       animations: {
                        sender.frame.origin = self.initPosition!
                        sender.alpha = 0.0
        }, completion: nil)
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
    func animationPopDown(sender: Toppon) {
        UIView.animate(withDuration: 0.3,
                       delay: 0.0,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 0.3,
                       options: .curveEaseIn,
                       animations: {
                        sender.transform = CGAffineTransform.identity.scaledBy(x: 0.001, y: 0.001)
                        sender.alpha = 0.0
        }, completion: nil)
    }
    
    @objc func animationPressedScale(sender: Toppon) {
        delegate?.TopponDidPressed()
        UIView.animate(withDuration: 0.1,
                       delay: 0.0,
                       options: .autoreverse,
                       animations: {
                        sender.transform = CGAffineTransform(scaleX: 0.85, y: 0.85)
                    }, completion: {(t) in
                        sender.transform = CGAffineTransform(scaleX: 1, y: 1)
        })
    }
    
}
