//
//  GnomeListView.swift
//  knowTheGnome
//
//  Created by Aitor Pagán on 18/2/18.
//  Copyright © 2018 Aitor Pagán. All rights reserved.
//

import UIKit

class GnomeListView : UIView {
    
    var filterTextField: UITextField!
    var tableView: UITableView!
    
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
    
    private func setupViews() {
        
        //TextField
        filterTextField = UITextField()
        filterTextField.placeholder = "Search by name..."
        filterTextField.font = Fonts.component
        filterTextField.textColor = UIColor.darkGray
        filterTextField.autocorrectionType = .no
        filterTextField.translatesAutoresizingMaskIntoConstraints = false
        
        //TableView
        tableView = UITableView()
        tableView.backgroundColor = UIColor.clear
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.tableFooterView = UIView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        //View
        backgroundColor = UIColor.white
        
        addSubview(tableView)
    }
    
    private func setupConstraints() {
        
        // TextField
        addConstraint(NSLayoutConstraint(item: filterTextField, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 45.0))
        addConstraint(NSLayoutConstraint(item: filterTextField, attribute: .top, relatedBy: .equal, toItem: self, attribute: .topMargin, multiplier: 1.0, constant: 8))
        addConstraint(NSLayoutConstraint(item: filterTextField, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leadingMargin, multiplier: 1.0, constant: 16.0))
        addConstraint(NSLayoutConstraint(item: filterTextField, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: 16.0))
        
        // TableView to View
        addConstraint(NSLayoutConstraint(item: tableView, attribute: .top, relatedBy: .equal, toItem: filterTextField, attribute: .bottomMargin, multiplier: 1.0, constant: 0.0))
        addConstraint(NSLayoutConstraint(item: tableView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottomMargin, multiplier: 1.0, constant: 0.0))
        addConstraint(NSLayoutConstraint(item: tableView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailingMargin, multiplier: 1.0, constant: 0.0))
        addConstraint(NSLayoutConstraint(item: tableView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leadingMargin, multiplier: 1.0, constant: 0.0))
    }
}
