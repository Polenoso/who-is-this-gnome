//
//  DetailComponentTableViewCell.swift
//  knowTheGnome
//
//  Created by Aitor Pagán on 20/2/18.
//  Copyright © 2018 Aitor Pagán. All rights reserved.
//

import UIKit

class DetailComponentTableViewCell: UITableViewCell {
    
    static let DetailComponentTableViewCellIdentifier  = "DetailComponentTableViewCellIdentifier"

    
    var titleLabel : UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: DetailComponentTableViewCell.DetailComponentTableViewCellIdentifier)
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
        
        titleLabel = UILabel()
        titleLabel.numberOfLines = 0
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(titleLabel)
    }
    
    private func setupConstraints() {
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leadingMargin, multiplier: 1.0, constant: 8.0))
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailingMargin, multiplier: 1.0, constant: -8.0))
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: self, attribute: .topMargin, multiplier: 1.0, constant: 8.0))
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottomMargin, multiplier: 1.0, constant: -8.0))
    }
    
    func updateUI(title : String?) {
        titleLabel.text = title
    }

}
