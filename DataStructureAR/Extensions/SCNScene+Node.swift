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

// SCNNode Extension
extension SCNNode {
  open class var tracker: SCNNode {
    guard let scene = SCNScene(named: "tracker.scn"),
          let node = scene.rootNode.childNode(withName: "tracker", recursively: true)
    else { return SCNNode() }
    node.scale = SCNVector3(scaleFactor, scaleFactor, scaleFactor)
    return node
  }
  
  func runFadeInAction(completion: @escaping () -> ()) {
    let fadeInAction = SCNAction.sequence([SCNAction.fadeIn(duration: animationDuration)])
    runAction(fadeInAction) {
      completion()
    }
  }
  
  func runFadeOutAction(completion: @escaping () -> ()) {
    let fadeOutAction = SCNAction.sequence([SCNAction.fadeOut(duration: animationDuration)])
    runAction(fadeOutAction) {
      completion()
    }
  }
}
