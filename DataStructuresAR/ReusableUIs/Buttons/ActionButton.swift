//
//  ActionButton.swift
//  DataStructuresAR
//
//  Created by Jayvenn on 2022-06-19.
//

import UIKit

class ActionButton: UIButton {
  override init(frame: CGRect) {
    super.init(frame: frame)
    setFont()
    setColorScheme()
    setCornerRadius()
    sizeToFit()
  }
  fileprivate func setFont() {
    titleLabel?.font = Font(object: .button).instance
    titleLabel?.adjustsFontForContentSizeCategory = true
    titleLabel?.adjustsFontSizeToFitWidth = true
  }
  fileprivate func setCornerRadius() {
    layer.cornerRadius = 5
    layer.masksToBounds = true
  }
  func setColorScheme() {
    setTitleColor(.white, for: .normal)
    setTitleColor(.gray, for: .selected)
    backgroundColor = .black
  }
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
