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
               
		toppon.presentMode = .pop
		toppon.bs
			.style(.top)
			.setBackground(color: .yellow)
			.setTitle("333", color: .black, for: .normal)
			.bind(to: scrollview1)
            .build()
		
        scrollview.delegate = self
        scrollview1.delegate = self
        scrollview2.delegate = self
    }
}

