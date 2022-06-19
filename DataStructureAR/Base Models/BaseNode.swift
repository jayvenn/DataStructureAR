//
//  BaseNode.swift
//  DataStructureAR
//
//  Created by Jayvenn on 2022-06-19.
//

import UIKit
import ARKit

protocol FullAccessibleProtocol {
  var accessibilityLabel: String { get set }
}

class BaseNode: SCNNode {
  let lesson: Lesson
  let cubeLength: CGFloat
  let cubeSpacing: CGFloat
  let trackerNodeLength: CGFloat
  init(cubeLength: CGFloat, cubeSpacing: CGFloat, trackerNodeLength: CGFloat, lesson: Lesson) {
    self.cubeLength = cubeLength
    self.cubeSpacing = cubeSpacing
    self.trackerNodeLength = trackerNodeLength
    self.lesson = lesson
    super.init()
  }
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
