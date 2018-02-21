//
//  GnomeDetailView.swift
//  knowTheGnome
//
//  Created by Pagán Narro, Aitor on 20/02/2018.
//  Copyright © 2018 Aitor Pagán. All rights reserved.
//

import UIKit
import Kingfisher

class GnomeDetailView: UIView {
    
    var scrollView : UIScrollView!
    var contentView : UIView!
    var thumbnailImageView : UIImageView!
    var nameLabel : UILabel!
    var ageLabel : UILabel!
    var weightImage : UIImageView!
    var weightLabel : UILabel!
    var heightImage : UIImageView!
    var heightLabel : UILabel!
    var hairColorTitleLabel : UILabel!
    var hairColorLabel : UILabel!
    var tablesStackView : UIStackView!
    var jobsView : UIView!
    var friendsView : UIView!
    var jobsTableView : UITableView!
    var friendsTableView : UITableView!
    
    var jobsTableViewHeightConstraint : NSLayoutConstraint!
    var friendsTableViewHeightConstraint : NSLayoutConstraint!

    override init(frame: CGRect) {
        super.init(frame: frame)
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
    
    private func setupViews(){
        backgroundColor = UIColor.white
    
        // Scroll View
        scrollView = UIScrollView()
        scrollView.backgroundColor = UIColor.white
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        // Content View
        contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        // Image View
        thumbnailImageView = UIImageView(image: #imageLiteral(resourceName: "default"))
        thumbnailImageView.contentMode = .scaleAspectFit
        thumbnailImageView.translatesAutoresizingMaskIntoConstraints = false
        
        // Name Label
        nameLabel = UILabel()
        nameLabel.font = Fonts.title
        nameLabel.textAlignment = .center
        nameLabel.numberOfLines = 0
        nameLabel.text = "Example"
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Age Label
        ageLabel = UILabel()
        ageLabel.font = Fonts.component
        ageLabel.text = "14Years Example"
        ageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Weight Image
        weightImage = UIImageView(image: #imageLiteral(resourceName: "weight"))
        weightImage.translatesAutoresizingMaskIntoConstraints = false
        
        // Height Image
        heightImage = UIImageView(image: #imageLiteral(resourceName: "height"))
        heightImage.translatesAutoresizingMaskIntoConstraints = false
        
        // Weight Label
        weightLabel = UILabel()
        weightLabel.font = Fonts.component
        weightLabel.text = "100g."
        weightLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Height Label
        heightLabel = UILabel()
        heightLabel.font = Fonts.component
        heightLabel.text = "12m."
        heightLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Hair Color Title
        hairColorTitleLabel = UILabel()
        hairColorTitleLabel.font = Fonts.title
        hairColorTitleLabel.text = "Hair Color:"
        hairColorTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Hair Color Label
        hairColorLabel = UILabel()
        hairColorLabel.font = Fonts.component
        hairColorLabel.text = "ZZ"
        hairColorLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Tables Stack View
        tablesStackView = UIStackView()
        tablesStackView.axis = .horizontal
        tablesStackView.distribution = .fillEqually
        tablesStackView.translatesAutoresizingMaskIntoConstraints = false
        
        // Jobs View
        jobsView = UIView()
        jobsView.translatesAutoresizingMaskIntoConstraints = false
        
        // Friends View
        friendsView = UIView()
        friendsView.translatesAutoresizingMaskIntoConstraints = false
        
        // Jobs Table View
        jobsTableView = UITableView()
        jobsTableView.isScrollEnabled = false
        jobsTableView.allowsSelection = false
        jobsTableView.tableFooterView = UIView()
        jobsTableView.translatesAutoresizingMaskIntoConstraints = false
        
        // Friends Table View
        friendsTableView = UITableView()
        friendsTableView.isScrollEnabled = false
        friendsTableView.allowsSelection = false
        friendsTableView.tableFooterView = UIView()
        friendsTableView.translatesAutoresizingMaskIntoConstraints = false
        
        // Adding subviews
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(thumbnailImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(ageLabel)
        contentView.addSubview(weightImage)
        contentView.addSubview(weightLabel)
        contentView.addSubview(heightImage)
        contentView.addSubview(heightLabel)
        contentView.addSubview(hairColorTitleLabel)
        contentView.addSubview(hairColorLabel)
        contentView.addSubview(tablesStackView)
        tablesStackView.addArrangedSubview(jobsView)
        tablesStackView.addArrangedSubview(friendsView)
        jobsView.addSubview(jobsTableView)
        friendsView.addSubview(friendsTableView)
        
    }
    
    private func setupConstraints() {
        
        // Scroll View
        addConstraint(NSLayoutConstraint(item: scrollView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .topMargin, multiplier: 1.0, constant: 8.0))
        addConstraint(NSLayoutConstraint(item: scrollView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leadingMargin, multiplier: 1.0, constant: 0.0))
        addConstraint(NSLayoutConstraint(item: scrollView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailingMargin, multiplier: 1.0, constant: 0.0))
        addConstraint(NSLayoutConstraint(item: scrollView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottomMargin, multiplier: 1.0, constant: 0))
        
        // Content View
        addConstraint(NSLayoutConstraint(item: contentView, attribute: .top, relatedBy: .equal, toItem: scrollView, attribute: .topMargin, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: contentView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leadingMargin, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: contentView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailingMargin, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: contentView, attribute: .bottom, relatedBy: .equal, toItem: scrollView, attribute: .bottomMargin, multiplier: 1.0, constant: 0))
        
         // Thumbnail
        let imageHeight : CGFloat = 300.0
        addConstraint(NSLayoutConstraint(item: thumbnailImageView, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .topMargin, multiplier: 1.0, constant: 16.0))
        addConstraint(NSLayoutConstraint(item: thumbnailImageView, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leadingMargin, multiplier: 1.0, constant: 16.0))
        addConstraint(NSLayoutConstraint(item: thumbnailImageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: imageHeight))
        addConstraint(NSLayoutConstraint(item: thumbnailImageView, attribute: .trailing, relatedBy: .equal, toItem: contentView, attribute: .trailingMargin, multiplier: 1.0, constant: -16.0))
        
        // Name Label
        addConstraint(NSLayoutConstraint(item: nameLabel, attribute: .top, relatedBy: .equal, toItem: thumbnailImageView, attribute: .bottomMargin, multiplier: 1.0, constant: 8.0))
        addConstraint(NSLayoutConstraint(item: nameLabel, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leadingMargin, multiplier: 1.0, constant: 16.0))
        addConstraint(NSLayoutConstraint(item: nameLabel, attribute: .trailing, relatedBy: .equal, toItem: contentView, attribute: .trailingMargin, multiplier: 1.0, constant: -16.0))
        
        // Age Label
        addConstraint(NSLayoutConstraint(item: ageLabel, attribute: .top, relatedBy: .equal, toItem: nameLabel, attribute: .bottomMargin, multiplier: 1.0, constant: 8.0))
        addConstraint(NSLayoutConstraint(item: ageLabel, attribute: .leading, relatedBy: .equal, toItem: nameLabel, attribute: .leading, multiplier: 1.0, constant: 0.0))
        addConstraint(NSLayoutConstraint(item: ageLabel, attribute: .trailing, relatedBy: .equal, toItem: nameLabel, attribute: .trailing, multiplier: 1.0, constant: 0.0))
        
        // Weight & Height Images
        let componentsImageSize : CGFloat = 45.0
        addConstraint(NSLayoutConstraint(item: weightImage, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: componentsImageSize))
        addConstraint(NSLayoutConstraint(item: weightImage, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: componentsImageSize))
        addConstraint(NSLayoutConstraint(item: heightImage, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: componentsImageSize))
        addConstraint(NSLayoutConstraint(item: heightImage, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: componentsImageSize))
        
        // Weight Image
        addConstraint(NSLayoutConstraint(item: weightImage, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leadingMargin, multiplier: 1.0, constant: 16.0))
        addConstraint(NSLayoutConstraint(item: weightImage, attribute: .top, relatedBy: .equal, toItem: ageLabel, attribute: .bottomMargin, multiplier: 1.0, constant: 8.0))
        
        // Weight Label
        addConstraint(NSLayoutConstraint(item: weightLabel, attribute: .leading, relatedBy: .equal, toItem: weightImage, attribute: .trailingMargin, multiplier: 1.0, constant: 4.0))
        addConstraint(NSLayoutConstraint(item: weightLabel, attribute: .bottomMargin, relatedBy: .equal, toItem: weightImage, attribute: .bottomMargin, multiplier: 1.0, constant: 0.0))
        
        //Height Image
        addConstraint(NSLayoutConstraint(item: heightImage, attribute: .top, relatedBy: .equal, toItem: ageLabel, attribute: .bottomMargin, multiplier: 1.0, constant: 8.0))
        addConstraint(NSLayoutConstraint(item: heightImage, attribute: .leading, relatedBy: .greaterThanOrEqual, toItem: weightLabel, attribute: .trailingMargin, multiplier: 1.0, constant: 8.0))
        
        //Height Label
        addConstraint(NSLayoutConstraint(item: heightLabel, attribute: .bottomMargin, relatedBy: .equal, toItem: heightImage, attribute: .bottomMargin, multiplier: 1.0, constant: 0.0))
        addConstraint(NSLayoutConstraint(item: heightLabel, attribute: .trailing, relatedBy: .equal, toItem: contentView, attribute: .trailingMargin, multiplier: 1.0, constant: -16.0))
        addConstraint(NSLayoutConstraint(item: heightLabel, attribute: .leading, relatedBy: .equal, toItem: heightImage, attribute: .trailingMargin, multiplier: 1.0, constant: 4.0))
        
        //Hair Color Title
        addConstraint(NSLayoutConstraint(item: hairColorTitleLabel, attribute: .top, relatedBy: .equal, toItem: weightImage, attribute: .bottomMargin, multiplier: 1.0, constant: 16.0))
        addConstraint(NSLayoutConstraint(item: hairColorTitleLabel, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leadingMargin, multiplier: 1.0, constant: 16.0))
        
        //Hair Color Label
        addConstraint(NSLayoutConstraint(item: hairColorLabel, attribute: .leading, relatedBy: .equal, toItem: hairColorTitleLabel, attribute: .trailingMargin, multiplier: 1.0, constant: 4.0))
        addConstraint(NSLayoutConstraint(item: hairColorLabel, attribute: .bottomMargin, relatedBy: .equal, toItem: hairColorTitleLabel, attribute: .bottomMargin, multiplier: 1.0, constant: 0.0))
        addConstraint(NSLayoutConstraint(item: hairColorLabel, attribute: .trailing, relatedBy: .greaterThanOrEqual, toItem: contentView, attribute: .trailingMargin, multiplier: 1.0, constant: -16.0))
        
        // Tables stack view
        addConstraint(NSLayoutConstraint(item: tablesStackView, attribute: .top, relatedBy: .equal, toItem: hairColorTitleLabel, attribute: .bottomMargin, multiplier: 1.0, constant: 16.0))
        addConstraint(NSLayoutConstraint(item: tablesStackView, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leadingMargin, multiplier: 1.0, constant: 16.0))
        addConstraint(NSLayoutConstraint(item: tablesStackView, attribute: .trailing, relatedBy: .equal, toItem: contentView, attribute: .trailingMargin, multiplier: 1.0, constant: -16.0))
        addConstraint(NSLayoutConstraint(item: tablesStackView, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottomMargin, multiplier: 1.0, constant: -16.0))
        
        // Jobs Table View
        addConstraint(NSLayoutConstraint(item: jobsTableView, attribute: .top, relatedBy: .equal, toItem: jobsView, attribute: .topMargin, multiplier: 1.0, constant: 0.0))
        addConstraint(NSLayoutConstraint(item: jobsTableView, attribute: .leading, relatedBy: .equal, toItem: jobsView, attribute: .leadingMargin, multiplier: 1.0, constant: 0.0))
        addConstraint(NSLayoutConstraint(item: jobsTableView, attribute: .bottom, relatedBy: .equal, toItem: jobsView, attribute: .bottomMargin, multiplier: 1.0, constant: 0.0))
        addConstraint(NSLayoutConstraint(item: jobsTableView, attribute: .trailing, relatedBy: .equal, toItem: jobsView, attribute: .trailingMargin, multiplier: 1.0, constant: 0.0))
        
        // Friends Table View
        addConstraint(NSLayoutConstraint(item: friendsTableView, attribute: .top, relatedBy: .equal, toItem: friendsView, attribute: .topMargin, multiplier: 1.0, constant: 0.0))
        addConstraint(NSLayoutConstraint(item: friendsTableView, attribute: .leading, relatedBy: .equal, toItem: friendsView, attribute: .leadingMargin, multiplier: 1.0, constant: 0.0))
        addConstraint(NSLayoutConstraint(item: friendsTableView, attribute: .bottom, relatedBy: .equal, toItem: friendsView, attribute: .bottomMargin, multiplier: 1.0, constant: 0.0))
        addConstraint(NSLayoutConstraint(item: friendsTableView, attribute: .trailing, relatedBy: .equal, toItem: friendsView, attribute: .trailingMargin, multiplier: 1.0, constant: 0.0))
        
        jobsTableViewHeightConstraint = NSLayoutConstraint(item: jobsTableView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 40.0)
        friendsTableViewHeightConstraint = NSLayoutConstraint(item: friendsTableView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 40.0)
        
        addConstraints([jobsTableViewHeightConstraint, friendsTableViewHeightConstraint])
        
    }
}
