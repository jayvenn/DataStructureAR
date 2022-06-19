//
//  HomeViewController.swift
//  DataStructuresAR
//
//  Created by Jayvenn on 2022-06-19.
//

import UIKit

final class HomeViewController: BaseMenuViewController {
  private let headerLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = -1
    label.textAlignment = .center
    label.minimumScaleFactor = 0.5
    label.adjustsFontForContentSizeCategory = true
    label.sizeToFit()
    label.accessibilityLabel = "App name"
    return label
  }()
  private lazy var beginButton: ActionButton = {
    let buttonText = NSLocalizedString("Begin", comment: "Begin")
    let button = ActionButton(type: .system)
    button.setTitle(buttonText, for: .normal)
    button.addTarget(self, action: #selector(beginButtonDidTouchUpInside(_:)), for: .touchUpInside)
    button.accessibilityLabel = buttonText
    button.accessibilityHint = "Course selection"
    return button
  }()
  fileprivate lazy var bottomStackView: UIStackView = {
    let stackView = UIStackView(arrangedSubviews: [beginButton])
    stackView.axis = .vertical
    stackView.distribution = .fill
    stackView.spacing = 12
    return stackView
  }()
  private lazy var stackView: UIStackView = {
    let stackView = UIStackView(arrangedSubviews: [headerLabel, bottomStackView])
    stackView.axis = .vertical
    stackView.spacing = 24
    stackView.translatesAutoresizingMaskIntoConstraints = false
    return stackView
  }()
  @objc private func beginButtonDidTouchUpInside(_ sender: UIButton) {
    let navigationController = MenuNavigationController()
    present(navigationController, animated: true)
  }
  override func configureView() {
    super.configureView()
    setHeaderLabelFont()
    setButtonFonts()
  }
}
// MARK:  - Life cycles
extension HomeViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    setUpLayout()
    setUpUI()
    setHeaderLabelFont()
  }
}
// MARK: HomeViewController - UI, Layout, Overhead
extension HomeViewController {
  private func setUpLayout() {
    view.addSubview(stackView)
    NSLayoutConstraint.activate(
      [
        stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
        stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40),
        stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
        stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
        beginButton.heightAnchor.constraint(equalToConstant: 44)
      ]
    )
  }
  
  func setHeaderLabelFont() {
    let titleText = "Data Structure"
    let subTitleText = NSLocalizedString("Augmented Reality", comment: "Augmented Reality")
    let titleTextFont = Font(object: .titleLabel).instance
    let subtitleTextFont = Font(object: .subTitleLabel).instance
    let titleTextAttributes = [
      NSAttributedString.Key.foregroundColor: UIColor.black,
      NSAttributedString.Key.font: titleTextFont
    ]
    let titleAttributedText = NSMutableAttributedString(string: "\(titleText)\n", attributes: titleTextAttributes)
    let subTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black,
                                  NSAttributedString.Key.font: subtitleTextFont]
    let subTitleAttributedText = NSMutableAttributedString(string: "\(subTitleText)",
                                                           attributes: subTitleTextAttributes)
    titleAttributedText.append(subTitleAttributedText)
    headerLabel.accessibilityValue = "\(titleText). \(subTitleText)."
    headerLabel.attributedText = titleAttributedText
    headerLabel.setNeedsDisplay()
  }
  
  func setButtonFonts() {
    let font: UIFont
    let preferredContentSizeCategory = traitCollection.preferredContentSizeCategory
    if preferredContentSizeCategory > .accessibilityMedium {
      font = UIFont.preferredFont(forTextStyle: .headline, compatibleWith: UITraitCollection(displayScale: 18))
    } else {
      font = Font(object: .button).instance
    }
    beginButton.titleLabel?.font = font
  }
  fileprivate func setUpUI() {
    view.backgroundColor = .white
  }
}
