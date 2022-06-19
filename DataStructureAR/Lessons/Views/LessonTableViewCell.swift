//
//  LessonTableViewCell.swift
//  DataStructuresAR
//
//  Created by Jayvenn on 2022-06-19.
//

import UIKit

class LessonTableViewCell: UITableViewCell {
  let descriptionLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = 0
    label.adjustsFontForContentSizeCategory = true
    return label
  }()
  var lesson: Lesson! {
    didSet {
      setDescriptionLabelText()
    }
  }
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setUpLayout()
    selectionStyle = .none
  }
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  fileprivate func setUpLayout() {
    addSubview(descriptionLabel)
    NSLayoutConstraint.activate(
      [
        descriptionLabel.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
        descriptionLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
        descriptionLabel.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
        descriptionLabel.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor)
      ]
    )
  }
  fileprivate func setDescriptionLabelText() {
    let nameTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black,
                              NSAttributedString.Key.font: FontManager.shared.titleFont]
    let nameAttributedText = NSMutableAttributedString(string: "\(lesson.name.rawValue)\n", attributes: nameTextAttributes)
    
    let addressTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.lightGray,
                                 NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12, weight: .regular)]
    let addressAttributedText = NSMutableAttributedString(string: "\n\n",
                                                          attributes: addressTextAttributes)
    nameAttributedText.append(addressAttributedText)
    descriptionLabel.attributedText = nameAttributedText
  }
  func configureCell(lesson: Lesson) {
    self.lesson = lesson
  }
}

