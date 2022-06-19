//
//  HomeViewController.swift
//  DataStructuresAR
//
//  Created by Jayvenn on 2022-06-19.
//

import UIKit
import MessageUI

class BaseMenuViewController: UIViewController {
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        configureView()
        NotificationCenter.default.addObserver(forName: UIContentSizeCategory.didChangeNotification, object: nil, queue: .main) { [weak self] (notification) in
            guard let `self` = self else { return }
            self.didChangePreferredContentSize()
        }
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func didChangePreferredContentSize() {
        configureView()
    }
    func configureView() {
        let titleFont = UIFont.preferredFont(forTextStyle: .headline)
        FontManager.shared.titleFont = titleFont
        let subtitleFont = UIFont.preferredFont(forTextStyle: .subheadline)
        FontManager.shared.subtitleFont = subtitleFont
    }
}
