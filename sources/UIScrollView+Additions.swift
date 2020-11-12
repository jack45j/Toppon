//
//  UIScrollView+Additions.swift
//  Toppon
//
//  Created by Yi-Cheng Lin on 2020/2/6.
//  Copyright © 2020 YochaStudio. All rights reserved.
//

import UIKit

extension UIScrollView {
  var tpMinContentOffset: CGPoint {
    return CGPoint(
      x: -contentInset.left,
      y: -contentInset.top)
  }

  var tpMaxContentOffset: CGPoint {
    return CGPoint(
      x: contentSize.width - bounds.width + contentInset.right,
      y: contentSize.height - bounds.height + contentInset.bottom)
  }

  func tpScrollToMinContentOffset(animated: Bool) {
    setContentOffset(tpMinContentOffset, animated: animated)
  }

  func tpScrollToMaxContentOffset(animated: Bool) {
    setContentOffset(tpMaxContentOffset, animated: animated)
  }
}
