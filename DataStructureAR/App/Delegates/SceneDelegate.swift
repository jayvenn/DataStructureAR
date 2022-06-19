//
//  SceneDelegate.swift
//  DataStructuresAR
//
//  Created by Jayvenn on 2022-06-19.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  var window: UIWindow?
  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let _ = (scene as? UIWindowScene) else { return }
    let homeViewController = HomeViewController()
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.rootViewController = homeViewController
    window?.makeKeyAndVisible()
  }
}
