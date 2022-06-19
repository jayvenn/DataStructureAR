//
//  AlternateActionButton.swift
//  DataStructuresAR
//
//  Created by Jayvenn on 2022-06-19.
//

import UIKit

final class AlternateActionButton: ActionButton {
  override init(frame: CGRect) {
    super.init(frame: frame)
    setBorder()
  }
  internal override func setColorScheme() {
    super.setColorScheme()
    backgroundColor = UIColor.white
    setTitleColor(.black, for: .normal)
  }
  fileprivate func setBorder() {
    layer.borderColor = UIColor.black.cgColor
    layer.borderWidth = 1
  }
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
