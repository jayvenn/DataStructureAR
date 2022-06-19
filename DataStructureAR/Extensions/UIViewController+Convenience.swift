//
//  UIViewController+Convenience.swift
//  DataStructureAR
//
//  Created by Jayvenn on 2022-06-19.
//

import UIKit

extension UIViewController {
    func vector(from translation: float3) -> SCNVector3 {
        let x = translation.x
        let y = translation.y
        let z = translation.z
        return SCNVector3(x, y, z)
    }
    
    func add(nodes: [SCNNode], toSceneView sceneView: ARSCNView) {
        let rootNode = sceneView.scene.rootNode
        for node in nodes {
            rootNode.addChildNode(node)
        }
    }
    
    func cameraVectors(sceneView: ARSCNView) -> (SCNVector3, SCNVector3)? { // (direction, position)
        guard let frame = sceneView.session.currentFrame else { return nil }
        let transform = SCNMatrix4(frame.camera.transform)
        let directionFactor: Float = -5
        let direction = SCNVector3(directionFactor * transform.m31, directionFactor * transform.m32, directionFactor * transform.m33)
        let position = SCNVector3(transform.m41, transform.m42, transform.m43)
        return (direction, position)
    }
    
    func cameraDirection(sceneView: ARSCNView) -> SCNVector4 { // (direction, position)
        guard let frame = sceneView.session.currentFrame else { return SCNVector4(0,0,0,0) }
        let transform = SCNMatrix4(frame.camera.transform)
        let directionFactor: Float = -5
        let direction = SCNVector4(directionFactor * transform.m31, directionFactor * transform.m32, directionFactor * transform.m33, transform.m34)
        return direction
    }
    
    func floatBetween(_ first: Float,  and second: Float) -> Float { // random float between upper and lower bound (inclusive)
        return (Float(arc4random()) / Float(UInt32.max)) * (first - second) + second
    }
}
