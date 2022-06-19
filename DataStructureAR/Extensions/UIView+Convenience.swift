//
//  UIView+Convenience.swift
//  DataStructureAR
//
//  Created by Jayvenn on 2022-06-19.
//

import UIKit

extension UIView {
  func addSubviews(views: [UIView]) {
    views.forEach { addSubview($0) }
  }
  
  // UIView Extension - Animation
  func fadeAndAway() {
    self.alpha = 0
    UIView.animate(withDuration: 1, animations: {
      self.alpha = 1
    }) { (complete) in
      UIView.animate(withDuration: 0.3, delay: 2, options: .curveEaseOut, animations: {
        self.alpha = 0
      }, completion: nil)
    }
  }
  
  func fadeIn() {
    self.alpha = 0
    UIView.animate(withDuration: 1, animations: {
      self.alpha = 1
    }, completion: nil)
  }
  
  func fadeOut() {
    self.alpha = 1
    UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseOut], animations: {
      self.alpha = 0
    }, completion: nil)
  }
  
  func fadeOutAndRemove(view: UIView) {
    UIView.animate(withDuration: 1, animations: {
      view.alpha = 0
    }) { (_) in
      view.removeFromSuperview()
    }
  }
  
  func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
    let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
    let mask = CAShapeLayer()
    mask.path = path.cgPath
    self.layer.mask = mask
  }
  func fadeTransition(_ duration:CFTimeInterval) {
    let animation = CATransition()
    animation.timingFunction = CAMediaTimingFunction(
      name: CAMediaTimingFunctionName.easeInEaseOut)
    animation.type = CATransitionType.fade
    animation.duration = duration
    layer.add(animation, forKey: convertFromCATransitionType(CATransitionType.fade))
  }
}

fileprivate func convertFromCATransitionType(_ input: CATransitionType) -> String {
  return input.rawValue
}
