//
//  SCNScene+Node.swift
//  DataStructureAR
//
//  Created by Jayvenn on 2022-06-19.
//

import UIKit
import SceneKit

extension SCNScene {
  func childNodesNode() -> SCNNode {
    let node = SCNNode()
    let sceneChildNodes = self.rootNode.childNodes
    for childNode in sceneChildNodes {
      node.addChildNode(childNode)
    }
    return node
  }
}
