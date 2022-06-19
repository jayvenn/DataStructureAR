//
//  HomeViewController.swift
//  DataStructuresAR
//
//  Created by Jayvenn on 2022-06-19.
//

import UIKit
import MessageUI

class BaseMenuViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        configureView()
        // Do any additional setup after loading the view.
    }
    
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
    
    func sendContributionMessage() {
        func showSendMailErrorAlert() {
            let title = "Send an email to:"
            let message = "LearnCSinAR@gmail.com"
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let action = UIAlertAction(title: "DONE", style: .default, handler: nil)
            alertController.addAction(action)
            present(alertController, animated: true, completion: nil)
        }
        
        let bodyText = generateBodyText()
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["LearnCSinAR@gmail.com"])
            mail.setSubject("Learn CS in AR - App Contribution")
            mail.setMessageBody(bodyText, isHTML: false)
            present(mail, animated: true)
        } else if MFMessageComposeViewController.canSendText() {
            let viewController = MFMessageComposeViewController()
            viewController.recipients = ["+6587766238"]
            viewController.messageComposeDelegate = self
            viewController.body = bodyText
            present(viewController, animated: true)
        } else {
            showSendMailErrorAlert()
        }
    }
}
