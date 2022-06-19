//
//  AlternateARButton.swift
//  DataStructureAR
//
//  Created by Jayvenn on 2022-06-19.
//

import UIKit

class AlternateARButton: ARButton {
  override func setColorScheme() {
    super.setColorScheme()
    backgroundColor = .resetButtonBackground
  }
  override func setCornerRadius() {
    super.setCornerRadius()
    layer.cornerRadius = 25
  }
}
