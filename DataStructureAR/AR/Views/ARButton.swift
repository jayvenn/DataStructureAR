//
//  ARButton.swift
//  DataStructureAR
//
//  Created by Jayvenn on 2022-06-19.
//

import UIKit

class ARButton: UIButton {
  // MARK: - Properties
  override var buttonType: UIButton.ButtonType {
    return .system
  }
  // MARK: - Initializers
  init(image: UIImage, frame: CGRect = .zero) {
    super.init(frame: frame)
    setColorScheme()
    setCornerRadius()
    set(image: image)
  }
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  // MARK: - Helpers
  fileprivate func setFont() {
    titleLabel?.font = Font(object: .button).instance
  }
  func setCornerRadius() {
    layer.cornerRadius = 30
    layer.masksToBounds = true
  }
  func setColorScheme() {
    setTitleColor(.white, for: .normal)
    setTitleColor(.gray, for: .selected)
    backgroundColor = .plantButtonBackground
  }
  func set(image: UIImage) {
    guard let imageView = self.imageView else { return }
    let image = image.withRenderingMode(.alwaysTemplate)
    setImage(image, for: .normal)
    imageView.tintColor = .white
    print("Set image tint color success")
  }
}
