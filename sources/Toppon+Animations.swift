//
//  Toppon+Animations.swift
//  Toppon
//
//  Created by Yi-Cheng Lin on 2020/5/10.
//  Copyright © 2020 YochaStudio. All rights reserved.
//

import UIKit

public class TopponAnimationGenerator {
	
    // MARK: - Properties
    //
    
	public init() {}
	
    var animationDuration: TimeInterval = 0.25
    
    fileprivate var frameRate: CGFloat = 60.0
	
	final func animation(_ key: String, reverse: Bool) -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: key)
        // Set the start and end.
        if !reverse {
            animation.fromValue = 0.0
            animation.toValue = 1.0
        } else {
            animation.fromValue = 1.0
            animation.toValue = 0.0
        }
        // Set animation properties.
        animation.duration = animationDuration
        animation.isRemovedOnCompletion = false
        animation.fillMode = kCAFillModeForwards
		animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        
        return animation
    }
	
	/**
     Creates an animation that animates the opacity property.
     - parameter reverse: The direction of the animation.
     - returns: A `CABasicAnimation` that animates the opacity property.
     */
    final func opacityAnimation(_ reverse: Bool) -> CABasicAnimation {
        return animation("opacity", reverse: reverse)
    }
	
	/**
     Creates an animation that animates between a filled an unfilled box.
     - parameter numberOfBounces: The number of bounces in the animation.
     - parameter amplitude: The distance of the bounce.
     - parameter reverse: The direction of the animation.
     - returns: A `CAKeyframeAnimation` that animates a change in fill.
     */
    final func fillAnimation(_ numberOfBounces: Int, amplitude: CGFloat, reverse: Bool) -> CAKeyframeAnimation {
        var values = [CATransform3D]()
        var keyTimes = [Float]()
        
        // Add the start scale
        if !reverse {
            values.append(CATransform3DMakeScale(0.0, 0.0, 0.0))
        } else {
            values.append(CATransform3DMakeScale(1.0, 1.0, 1.0))
        }
        keyTimes.append(0.0)
        
        // Add the bounces.
        if numberOfBounces > 0 {
            for i in 1...numberOfBounces {
                let scale = i % 2 == 1 ? (1.0 + (amplitude / CGFloat(i))) : (1.0 - (amplitude / CGFloat(i)))
                let time = (Float(i) * 1.0) / Float(numberOfBounces + 1)
                
                values.append(CATransform3DMakeScale(scale, scale, scale))
                keyTimes.append(time)
            }
        }
        
        // Add the end scale.
        if !reverse {
            values.append(CATransform3DMakeScale(1.0, 1.0, 1.0))
        } else {
            values.append(CATransform3DMakeScale(0.0001, 0.0001, 0.0001))
        }
        keyTimes.append(1.0)
		
		
        
        // Create the animation.
        let animation = CAKeyframeAnimation(keyPath: "transform")
		animation.values = values.map({ NSValue(caTransform3D: $0) })
        animation.keyTimes = keyTimes.map({ NSNumber(value: $0 as Float) })
        animation.isRemovedOnCompletion = false
        animation.fillMode = kCAFillModeForwards
        animation.duration = animationDuration
		animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
		return animation
    }
}
