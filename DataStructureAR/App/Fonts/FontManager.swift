//
//  FontManager.swift
//  DataStructuresAR
//
//  Created by Jayvenn on 2022-06-19.
//

import UIKit

class FontManager {
  static let shared = FontManager()
  var titleFont: UIFont = Font(object: .titleLabel).instance
  var subtitleFont: UIFont = Font(object: .subTitleLabel).instance
}
