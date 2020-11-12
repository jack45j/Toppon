//
//  ViewController.swift
//
//  Created by Benson Lin on 2018/1/10.
//  Copyright © 2018年 YochaStudio. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextViewDelegate, UIScrollViewDelegate {
	@IBOutlet weak var toppon: Toppon!
	@IBOutlet weak var scrollview: UITextView!
    @IBOutlet weak var scrollview1: UITextView!
    @IBOutlet weak var scrollview2: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
		toppon.builder
		.bind(to: scrollview1, distance: 100)
		.scrollMode(.bottom)
		.presentMode(.pop)
		.setImage(UIImage(named: "ScrollToBottom")!)
		.setActions(
			didPressed: {
			print("DidPressed")
		},
			didShow: {
			print("didShow")
		},
			didDismiss: {
			print("didDismiss")
		})
		.build()
    }
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		
	}
}

