//
//  SubtitleTextView.swift
//  DataStructureAR
//
//  Created by Jayvenn on 2022-06-19.
//

import UIKit
import SnapKit

final class SubtitleTextView: UITextView {
  let titleColor = UIColor.black
  let subtitleColor = UIColor.black
  let bodyColor = UIColor.darkGray
  var lesson: Lesson
  let initialSpacerText = "\n\n"
  init(lesson: Lesson) {
    self.lesson = lesson
    super.init(frame: .zero, textContainer: nil)
    setInitialProperties()
    setOffsets()
    accessibilityLabel = "description"
  }
  func setInitialProperties() {
    isEditable = false
    textContainerInset = UIEdgeInsets.zero
    textContainer.lineFragmentPadding = 0
  }
  func setOffsets() {
    let side: CGFloat = 16
    scrollIndicatorInsets = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: -side)
  }
  override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
    super.canPerformAction(action, withSender: sender)
    return false
  }
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
