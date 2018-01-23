//
//  ViewController.swift
//
//  Created by Benson Lin on 2018/1/10.
//  Copyright © 2018年 YochaStudio. All rights reserved.
//

import UIKit

class ViewController: UIViewController, TopponDelegate, UITextViewDelegate, UIScrollViewDelegate {
    @IBOutlet weak var scrollview: UITextView!
    @IBOutlet weak var scrollview1: UITextView!
    @IBOutlet weak var scrollview2: UITextView!
    
    let toppon = Toppon(initPosition: CGPoint(x:320, y:182),
                        size: 48,
                        normalIcon: "ScrollToTop.png")
    let toppon1 = Toppon(initPosition: CGPoint(x:320, y:398),
                        size: 48,
                        normalIcon: "ScrollToTopYellow.png")
    let toppon2 = Toppon(initPosition: CGPoint(x:368, y:612),
                        size: 48,
                        normalIcon: "ScrollToBottom.png")
    override func viewDidLoad() {
        super.viewDidLoad()
        
        toppon.linkedTo(UIScrollView: scrollview)
        toppon.presentMode = .always
        view.addSubview(toppon)
        
        toppon1.linkedTo(UIScrollView: scrollview1)
        toppon1.presentMode = .pop
        view.addSubview(toppon1)
        
        toppon2.linkedTo(UIScrollView: scrollview2)
        toppon2.presentMode = .normal
        toppon2.scollMode = .bottom
        toppon2.destPosition = CGPoint(x:320, y:612)
        view.addSubview(toppon2)
        
        scrollview.delegate = self
        scrollview1.delegate = self
        scrollview2.delegate = self
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollview1.contentOffset.y > 30.0 {
            toppon1.present()
        } else {
            toppon1.dismiss()
        }
        
        if scrollview2.contentOffset.y < scrollview2.contentSize.height - scrollview2.bounds.size.height - 30.0 {
            toppon2.present()
        } else {
            toppon2.dismiss()
        }
    }
}

