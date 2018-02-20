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
    var jobsTableView : UITableView!
    var friendsTableView : UITableView!

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
    
        // Scroll View
        scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        // Content View
        contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        // Image View
        thumbnailImageView = UIImageView()
        thumbnailImageView.contentMode = .scaleAspectFit
        thumbnailImageView.translatesAutoresizingMaskIntoConstraints = false
        
        // Name Label
        nameLabel = UILabel()
        nameLabel.font = Fonts.title
        nameLabel.textAlignment = .center
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Age Label
        ageLabel = UILabel()
        ageLabel.font = Fonts.component
        ageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Weight Image
        weightImage = UIImageView(image: #imageLiteral(resourceName: "weight"))
        weightImage.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    private func setupConstraints() {
        
    }
}

class EmptyView : UIView {
    
    var label = UILabel()
    
    class func initWithSuperView(_ view: UIView, information: String) -> EmptyView {
        let emptyView = EmptyView(frame: view.bounds)
        emptyView.label.text = information
        emptyView.label.frame = emptyView.bounds
        emptyView.addSubview(emptyView.label)
        return emptyView
    }
}
