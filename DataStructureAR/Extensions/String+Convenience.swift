//
//  String+Convenience.swift
//  DataStructureAR
//
//  Created by Jayvenn on 2022-06-19.
//

import UIKit

extension String  {
  func replaceWhiteSpaces() -> String {
    return components(separatedBy: .whitespaces).joined()
  }
  func replacePunctuationCharacters() -> String {
    return components(separatedBy: .punctuationCharacters).joined()
  }
  public static var tab: String {
    let numberOfSpaces = 4
    var index = 0
    var string = ""
    while index < numberOfSpaces {
      string += " "
      index += 1
    }
    return string
  }
  func capitalizingFirstLetter() -> String {
    return prefix(1).uppercased() + dropFirst()
  }
  mutating func capitalizeFirstLetter() {
    self = self.capitalizingFirstLetter()
  }
}
