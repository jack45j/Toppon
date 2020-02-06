//
//  UIScrollView+Additions.swift
//  Toppon
//
//  Created by Yi-Cheng Lin on 2020/2/6.
//  Copyright © 2020 YochaStudio. All rights reserved.
//

import UIKit

extension UIScrollView {
  var minContentOffset: CGPoint {
    return CGPoint(
      x: -contentInset.left,
      y: -contentInset.top)
  }

  var maxContentOffset: CGPoint {
    return CGPoint(
      x: contentSize.width - bounds.width + contentInset.right,
      y: contentSize.height - bounds.height + contentInset.bottom)
  }

  func scrollToMinContentOffset(animated: Bool) {
    setContentOffset(minContentOffset, animated: animated)
  }

  func scrollToMaxContentOffset(animated: Bool) {
    setContentOffset(maxContentOffset, animated: animated)
  }
}
