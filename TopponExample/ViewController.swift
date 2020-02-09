//
//  ViewController.swift
//
//  Created by Benson Lin on 2018/1/10.
//  Copyright © 2018年 YochaStudio. All rights reserved.
//

import UIKit

class ViewController: UIViewController, TopponDelegate, UITextViewDelegate, UIScrollViewDelegate {
	@IBOutlet weak var toppon: Toppon!
	@IBOutlet weak var scrollview: UITextView!
    @IBOutlet weak var scrollview1: UITextView!
    @IBOutlet weak var scrollview2: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
		
		toppon.bs
			.scrollMode(.top)
			.bind(to: scrollview1)
			.presentMode(.custom(
				showAnimator: UIViewPropertyAnimator(
					duration: 5,
					dampingRatio: 0.5,
					animations: { [weak toppon] in
						toppon?.transform = CGAffineTransform(scaleX: 1, y: 1)
						toppon?.alpha = 1
				}),
				showBegin: { [weak toppon] in
					toppon?.transform = CGAffineTransform(scaleX: 0, y: 0)
			},
				dismissAnimator: UIViewPropertyAnimator(duration: 5,
														dampingRatio: 0.5,
														animations: { [weak toppon] in
					toppon?.transform = CGAffineTransform(scaleX: 0, y: 0)
					toppon?.alpha = 0
				}),
				dismissBegin: { [weak toppon] in
					toppon?.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
			}))
			.build()
		
		
        scrollview.delegate = self
        scrollview1.delegate = self
        scrollview2.delegate = self
    }
}

