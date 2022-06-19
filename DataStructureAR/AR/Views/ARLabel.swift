//
//  ARLabel.swift
//  DataStructureAR
//
//  Created by Jayvenn on 2022-06-19.
//

import UIKit

class ARLabel: UILabel {
  override var text: String? {
    didSet {
      guard let text = text,
            text != text.uppercased() else { return }
      self.text = text.uppercased()
    }
  }
  override init(frame: CGRect) {
    super.init(frame: frame)
    setFont()
  }
  fileprivate func setFont() {
    font = Font(object: .aRLabel).instance
    textColor = .white
    textAlignment = .center
  }
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
