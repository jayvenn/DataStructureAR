//
//  OperationCollectionViewCell.swift
//  DataStructureAR
//
//  Created by Jayvenn on 2022-06-19.
//

import UIKit
import SnapKit

final class OperationCollectionViewCell: UICollectionViewCell {
  // MARK: - Properties
  private lazy var operationButton: UIButton = {
    let button = UIButton(type: UIButton.ButtonType.roundedRect)
    button.sizeToFit()
    button.accessibilityLabel = "Operation label"
    button.backgroundColor = .white
    button.layer.borderColor = UIColor.black.cgColor
    button.layer.borderWidth = 1
    button.layer.cornerRadius = 15
    button.layer.masksToBounds = true
    button.setTitleColor(UIColor.black, for: .normal)
    button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
    button.titleLabel?.numberOfLines = 2
    button.titleLabel?.textAlignment = .center
    button.titleLabel?.minimumScaleFactor = 0.5
    button.addTarget(self, action: #selector(operationButtonDidTouchUpDown), for: .touchUpInside)
    return button
  }()
  private let operationLabel: UILabel = {
    let label = UILabel()
    label.accessibilityLabel = "Operation"
    label.backgroundColor = .black
    label.textColor = .white
    label.layer.borderColor = UIColor.black.cgColor
    label.layer.borderWidth = 1
    label.layer.cornerRadius = 15
    return label
  }()
  private let notificationCenter = NotificationCenter.default
  private var operation: Operation! {
    didSet {
      let operationName = operation.rawValue
      operationButton.accessibilityLabel = operationName
      operationButton.setTitle(operationName, for: .normal)
    }
  }
  override var isHighlighted: Bool {
    didSet {
      UIView.animate(withDuration: 0.1) {
        let scale: CGFloat = 0.95
        self.transform = self.isHighlighted ? CGAffineTransform(scaleX: scale, y: scale) : .identity
      }
    }
  }
  // MARK: - Methods
  func configureCell(_ operation: Operation) {
    self.operation = operation
  }
  @objc func operationButtonDidTouchUpDown(sender: UIButton) {
    notificationCenter.post(name: .operationButtonDidTouchUpInside, object: operation)
  }
  // MARK: - Initializers
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupLayout()
  }
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  // MARK: - UI, Layout, Overheads
  private func setupLayout() {
    addSubview(operationButton)
    operationButton.snp.makeConstraints { $0.leading.trailing.top.bottom.equalToSuperview() }
  }
}

