//
//  MenuTableViewCell.swift
//  DataStructuresAR
//
//  Created by Jayvenn on 2022-06-19.
//

import UIKit

class MenuTableViewCell: UITableViewCell {
  let descriptionLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 0
    label.adjustsFontForContentSizeCategory = true
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  var course: Course! {
    didSet {
      setDescriptionLabelText()
    }
  }
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setUpLayout()
    selectionStyle = .none
    accessibilityValue = "\(course)"
    accessibilityHint = "Open course catalog"
  }
  fileprivate func setUpLayout() {
    addSubview(descriptionLabel)
    NSLayoutConstraint.activate(
      [
        descriptionLabel.topAnchor.constraint(equalTo: topAnchor),
        descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
        descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
        descriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
      ]
    )
  }
  fileprivate func setDescriptionLabelText() {
    let nameTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black,
                              NSAttributedString.Key.font: FontManager.shared.titleFont]
    let nameAttributedText = NSMutableAttributedString(string: "\(course.name)\n", attributes: nameTextAttributes)
    
    let addressTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.lightGray,
                                 NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12, weight: .regular)]
    let addressAttributedText = NSMutableAttributedString(string: course.description + "\n\n",
                                                          attributes: addressTextAttributes)
    nameAttributedText.append(addressAttributedText)
    descriptionLabel.attributedText = nameAttributedText
  }
  func configureCell(course: Course) {
    self.course = course
  }
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
}
