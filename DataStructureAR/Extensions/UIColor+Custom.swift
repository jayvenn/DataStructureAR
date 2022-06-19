//
//  UIColor+Custom.swift
//  DataStructureAR
//
//  Created by Jayvenn on 2022-06-19.
//

import Foundation
import ARKit

// UIColor Extension
extension UIColor {
  static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat = 1) -> UIColor {
    return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: alpha)
  }
  open class var darkBlue: UIColor {
    return UIColor.rgb(red: 29, green: 36, blue: 46)
  }
  open class var seperatorGray: UIColor {
    return UIColor.lightGray
  }
  struct TabBarItem {
    static let selected = UIColor.black
    static let unselected = UIColor.rgb(red: 106, green: 113, blue: 123)
  }
}
// UIColor Extension
extension UIColor {
  open class var transparentWhite: UIColor {
    return UIColor.white.withAlphaComponent(0.20)
  }
  open class var transparentTextBackgroundWhite: UIColor {
    return UIColor.white.withAlphaComponent(0.80)
  }
  open class var transparentTextBackgroundBlack: UIColor {
    return UIColor.black.withAlphaComponent(0.80)
  }
  open class var plantButtonBackground: UIColor {
    return UIColor.rgb(red: 46, green: 204, blue: 112)
  }
  open class var resetButtonBackground: UIColor {
    return UIColor.rgb(red: 250, green: 190, blue: 88)
  }
}
