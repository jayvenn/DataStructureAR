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
}
