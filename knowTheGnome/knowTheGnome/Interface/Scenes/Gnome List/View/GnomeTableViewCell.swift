//
//  GnomeTableViewCell.swift
//  knowTheGnome
//
//  Created by Aitor Pagán on 18/2/18.
//  Copyright © 2018 Aitor Pagán. All rights reserved.
//

import UIKit
import Kingfisher

class GnomeTableViewCell: UITableViewCell {
    static let GnomeTableViewCellIdentifier = "GnomeTableViewCellIdentifier"
    
    var genderImageView: UIImageView!
    var nameLabel: UILabel!
    var ageLabel: UILabel!
    var weightLabel: UILabel!
    var heightLabel: UILabel!
    var weightIcon: UIImageView!
    var heightIcon: UIImageView!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: GnomeTableViewCell.GnomeTableViewCellIdentifier)
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    private func initialize() {
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        // icon gender image
        genderImageView = UIImageView()
        genderImageView.backgroundColor = UIColor.clear
        genderImageView.contentMode = .scaleAspectFit
        genderImageView.translatesAutoresizingMaskIntoConstraints = false
        
        // name label
        nameLabel = UILabel()
        nameLabel.numberOfLines = 1
        nameLabel.textColor = UIColor.black
        nameLabel.font = Fonts.title
        nameLabel.textAlignment = .center
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // age label
        ageLabel = UILabel()
        ageLabel.numberOfLines = 1
        ageLabel.textColor = UIColor.darkGray
        ageLabel.font = Fonts.component
        ageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // weight label
        weightLabel = UILabel()
        weightLabel.numberOfLines = 1
        weightLabel.textColor = UIColor.darkGray
        weightLabel.font = Fonts.component
        weightLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // height label
        heightLabel = UILabel()
        heightLabel.numberOfLines = 1
        heightLabel.textColor = UIColor.darkGray
        heightLabel.font = Fonts.component
        heightLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Height icon
        heightIcon = UIImageView()
        heightIcon.backgroundColor = UIColor.clear
        heightIcon.contentMode = .scaleAspectFill
        heightIcon.image = #imageLiteral(resourceName: "height")
        heightIcon.translatesAutoresizingMaskIntoConstraints = false
        
        // Weight icon
        weightIcon = UIImageView()
        weightIcon.backgroundColor = UIColor.clear
        weightIcon.contentMode = .scaleAspectFill
        weightIcon.image = #imageLiteral(resourceName: "weight")
        weightIcon.translatesAutoresizingMaskIntoConstraints = false
        
        // Add subviews
        addSubview(genderImageView)
        addSubview(nameLabel)
        addSubview(ageLabel)
        addSubview(weightLabel)
        addSubview(heightLabel)
        addSubview(heightIcon)
        addSubview(weightIcon)
        
    }
    
    private func setupConstraints() {
        
        let genderIconsize : CGFloat = 75.0
        let smallIconSize : CGFloat = 25.0
        
        // Gender Icon
        addConstraint(NSLayoutConstraint(item: genderImageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: genderIconsize))
        addConstraint(NSLayoutConstraint(item: genderImageView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: genderIconsize))
        addConstraint(NSLayoutConstraint(item: genderImageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerYWithinMargins, multiplier: 1.0, constant: 8.0))
        addConstraint(NSLayoutConstraint(item: genderImageView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leadingMargin, multiplier: 1.0, constant: 8.0))
        
        // Name
        addConstraint(NSLayoutConstraint(item: nameLabel, attribute: .leading, relatedBy: .equal, toItem: genderImageView, attribute: .trailingMargin, multiplier: 1.0, constant: 8.0))
        addConstraint(NSLayoutConstraint(item: nameLabel, attribute: .top, relatedBy: .equal, toItem: self, attribute: .topMargin, multiplier: 1.0, constant: 8.0))
        addConstraint(NSLayoutConstraint(item: nameLabel, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailingMargin, multiplier: 1.0, constant: 16.0))
        
        // Age
        addConstraint(NSLayoutConstraint(item: ageLabel, attribute: .leading, relatedBy: .equal, toItem: nameLabel, attribute: .leading, multiplier: 1.0, constant: 0.0))
        addConstraint(NSLayoutConstraint(item: ageLabel, attribute: .top, relatedBy: .equal, toItem: nameLabel, attribute: .bottomMargin, multiplier: 1.0, constant: 16.0))
        addConstraint(NSLayoutConstraint(item: ageLabel, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailingMargin, multiplier: 1.0, constant: 16.0))
        
        // Weight Icon
        addConstraint(NSLayoutConstraint(item: weightIcon, attribute: .leading, relatedBy: .equal, toItem: nameLabel, attribute: .leading, multiplier: 1.0, constant: 0.0))
        addConstraint(NSLayoutConstraint(item: weightIcon, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: smallIconSize))
        addConstraint(NSLayoutConstraint(item: weightIcon, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: smallIconSize))
        addConstraint(NSLayoutConstraint(item: weightIcon, attribute: .top, relatedBy: .equal, toItem: ageLabel, attribute: .bottomMargin, multiplier: 1.0, constant: 8.0))
        
        // Weight Label
        addConstraint(NSLayoutConstraint(item: weightLabel, attribute: .leading, relatedBy: .equal, toItem: weightIcon, attribute: .trailingMargin, multiplier: 1.0, constant: 16.0))
        addConstraint(NSLayoutConstraint(item: weightLabel, attribute: .top, relatedBy: .equal, toItem: ageLabel, attribute: .bottomMargin, multiplier: 1.0, constant: 8.0))
        addConstraint(NSLayoutConstraint(item: weightLabel, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailingMargin, multiplier: 1.0, constant: 16.0))
        addConstraint(NSLayoutConstraint(item: weightLabel, attribute: .height, relatedBy: .equal, toItem: weightIcon, attribute: .height, multiplier: 1.0, constant: 0.0))
        
        // Height Icon
        addConstraint(NSLayoutConstraint(item: heightIcon, attribute: .leading, relatedBy: .equal, toItem: nameLabel, attribute: .leading, multiplier: 1.0, constant: 0.0))
        addConstraint(NSLayoutConstraint(item: heightIcon, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: smallIconSize))
        addConstraint(NSLayoutConstraint(item: heightIcon, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: smallIconSize))
        addConstraint(NSLayoutConstraint(item: heightIcon, attribute: .top, relatedBy: .equal, toItem: weightIcon, attribute: .bottomMargin, multiplier: 1.0, constant: 8.0))
        addConstraint(NSLayoutConstraint(item: heightIcon, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottomMargin, multiplier: 1.0, constant: 8.0))
        
        // Height Label
        addConstraint(NSLayoutConstraint(item: heightLabel, attribute: .leading, relatedBy: .equal, toItem: heightIcon, attribute: .trailingMargin, multiplier: 1.0, constant: 16.0))
        addConstraint(NSLayoutConstraint(item: heightLabel, attribute: .top, relatedBy: .equal, toItem: weightIcon, attribute: .bottomMargin, multiplier: 1.0, constant: 8.0))
        addConstraint(NSLayoutConstraint(item: heightLabel, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailingMargin, multiplier: 1.0, constant: 16.0))
        addConstraint(NSLayoutConstraint(item: heightLabel, attribute: .height, relatedBy: .equal, toItem: heightIcon, attribute: .height, multiplier: 1.0, constant: 0.0))
        addConstraint(NSLayoutConstraint(item: heightLabel, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottomMargin, multiplier: 1.0, constant: 8.0))
        
    }
    
    func updateUI(genderAsset: String, name: String, age: String, weight: String, height: String) {
        let asset = UIImage(imageLiteralResourceName: genderAsset)
        genderImageView.image = asset
        nameLabel.text = name
        ageLabel.text = "\(age) years old"
        weightLabel.text = "\(weight) g."
        heightLabel.text = "\(height) mm."
    }
}
