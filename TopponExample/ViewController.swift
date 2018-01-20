//
//  ViewController.swift
//
//  Created by Benson Lin on 2018/1/10.
//  Copyright © 2018年 YochaStudio. All rights reserved.
//

import UIKit

class ViewController: UIViewController, TopponDelegate, UITextViewDelegate, UIScrollViewDelegate {
    @IBOutlet weak var scrollview: UITextView!
    
    let toppon = Toppon(initPosition: CGPoint(x:300, y:100),
                        size: 48,
                        normalIcon: "top48")
    override func viewDidLoad() {
        super.viewDidLoad()
        toppon.linkedTo(UIScrollView: scrollview)
        toppon.setPresentMode(.pop)
        toppon.delegate = self
        view.addSubview(toppon)
        
        scrollview.delegate = self
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollview.contentOffset.y > 30.0 {
            toppon.present(toppon)
        } else {
            toppon.dismiss(toppon)
        }
    }
}

