//
//  ViewController.swift
//  back-to-top-button
//
//  Created by 林翌埕 on 2018/1/10.
//  Copyright © 2018年 YochaStudio. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let toppon = Toppon(initPosition: CGPoint(x:148, y:48),
                        size: 48,
                        normalIcon: "top48")
    override func viewDidLoad() {
        super.viewDidLoad()
        toppon.setDestPosition(destPosition: CGPoint(x:150, y:300))
        view.addSubview(toppon)
    }
    override func viewDidAppear(_ animated: Bool) {
        toppon.present(toppon, duration: 1.5, delay: 0)
    }
}

