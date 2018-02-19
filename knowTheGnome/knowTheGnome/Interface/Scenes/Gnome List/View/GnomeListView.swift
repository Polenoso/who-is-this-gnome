//
//  GnomeListView.swift
//  knowTheGnome
//
//  Created by Aitor Pagán on 18/2/18.
//  Copyright © 2018 Aitor Pagán. All rights reserved.
//

import UIKit

class GnomeListView : UIView {
    
    var filterStackView: UIStackView!
    var filterTextField: UITextField!
    var tableView: UITableView!
    var emptyView: UIView!
    var emptyLabel: UILabel!
    var sortingStackView: UIStackView!
    var sortingPickerView: UIPickerView!
    var sortingOrderButton: UIButton!
    
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
        
        //Stack View
        filterStackView = UIStackView()
        filterStackView.axis = .vertical
        filterStackView.translatesAutoresizingMaskIntoConstraints = false
        
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
        
        //EmptyView
        emptyView = UIView()
        emptyView.isHidden = true
        emptyView.translatesAutoresizingMaskIntoConstraints = false
        
        //EmptyLabel
        emptyLabel = UILabel()
        emptyLabel.numberOfLines = 0
        emptyLabel.text = "Gnomes not found, please try again"
        emptyLabel.font = Fonts.title
        emptyLabel.textColor = UIColor.red
        emptyLabel.textAlignment = .center
        emptyLabel.translatesAutoresizingMaskIntoConstraints = false
        
        //SortingStackView
        sortingStackView = UIStackView()
        sortingStackView.axis = .horizontal
        sortingStackView.translatesAutoresizingMaskIntoConstraints = false
        
        //Picker View
        sortingPickerView = UIPickerView()
        sortingPickerView.backgroundColor = UIColor.white
        sortingPickerView.translatesAutoresizingMaskIntoConstraints = false
        
        //Sorting Button
        sortingOrderButton = UIButton()
        sortingOrderButton.backgroundColor = UIColor.white
        sortingOrderButton.setTitleColor(UIColor.red, for: .normal)
        sortingOrderButton.setTitle("asc", for: .normal)
        sortingOrderButton.translatesAutoresizingMaskIntoConstraints = false
        
        //View
        backgroundColor = UIColor.white
        addSubview(filterStackView)
        filterStackView.addArrangedSubview(filterTextField)
        addSubview(tableView)
        emptyView.addSubview(emptyLabel)
        addSubview(emptyView)
        sortingStackView.addArrangedSubview(sortingPickerView)
        sortingStackView.addArrangedSubview(sortingOrderButton)
        filterStackView.addArrangedSubview(sortingStackView)
        
    }
    
    private func setupConstraints() {
        
        // StackView
        addConstraint(NSLayoutConstraint(item: filterTextField, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 45.0))
        addConstraint(NSLayoutConstraint(item: filterStackView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .topMargin, multiplier: 1.0, constant: 8))
        addConstraint(NSLayoutConstraint(item: filterStackView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leadingMargin, multiplier: 1.0, constant: 16.0))
        addConstraint(NSLayoutConstraint(item: filterStackView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailingMargin, multiplier: 1.0, constant: 16.0))
        
        // TableView to View
        addConstraint(NSLayoutConstraint(item: tableView, attribute: .top, relatedBy: .equal, toItem: filterStackView, attribute: .bottomMargin, multiplier: 1.0, constant: 0.0))
        addConstraint(NSLayoutConstraint(item: tableView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottomMargin, multiplier: 1.0, constant: 0.0))
        addConstraint(NSLayoutConstraint(item: tableView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailingMargin, multiplier: 1.0, constant: 0.0))
        addConstraint(NSLayoutConstraint(item: tableView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leadingMargin, multiplier: 1.0, constant: 0.0))
        
        // EmptyView
        addConstraint(NSLayoutConstraint(item: emptyView, attribute: .top, relatedBy: .equal, toItem: filterStackView, attribute: .bottomMargin, multiplier: 1.0, constant: 0.0))
        addConstraint(NSLayoutConstraint(item: emptyView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailingMargin, multiplier: 1.0, constant: 0.0))
        addConstraint(NSLayoutConstraint(item: emptyView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leadingMargin, multiplier: 1.0, constant: 0.0))
        addConstraint(NSLayoutConstraint(item: emptyView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 200.0))
        
        // EmptyLabel
        addConstraint(NSLayoutConstraint(item: emptyLabel, attribute: .centerY, relatedBy: .equal, toItem: emptyView, attribute: .centerYWithinMargins, multiplier: 1.0, constant: 0.0))
        addConstraint(NSLayoutConstraint(item: emptyLabel, attribute: .leading, relatedBy: .equal, toItem: emptyView, attribute: .leadingMargin, multiplier: 1.0, constant: 4.0))
        addConstraint(NSLayoutConstraint(item: emptyLabel, attribute: .trailing, relatedBy: .equal, toItem: emptyView, attribute: .trailingMargin, multiplier: 1.0, constant: 4.0))
        
        //Picker view
        addConstraint(NSLayoutConstraint(item: sortingPickerView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 55.0))
        
        //Button
        addConstraint(NSLayoutConstraint(item: sortingOrderButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 55.0))
        addConstraint(NSLayoutConstraint(item: sortingOrderButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 55.0))
    }
}
