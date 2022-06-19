//
//  MenuNavigationController.swift
//  DataStructuresAR
//
//  Created by Jayvenn on 2022-06-19.
//

import UIKit

class MenuNavigationController: UINavigationController {
  override init(rootViewController: UIViewController) {
    super.init(rootViewController: rootViewController)
  }
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
  }
  convenience init() {
    self.init(rootViewController: CoursesViewController())
    navigationBar.barTintColor = .white
  }
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
