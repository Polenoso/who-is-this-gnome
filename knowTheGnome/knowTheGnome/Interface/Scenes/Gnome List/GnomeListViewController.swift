//
//  GnomeListViewController.swift
//  knowTheGnome
//
//  Created by Aitor Pagán on 18/2/18.
//  Copyright © 2018 Aitor Pagán. All rights reserved.
//

import UIKit

struct DisplayedGnomes {
    let asset : String
    let name : String
    let age : String
    let weight : String
    let height : String
}

class GnomeListViewController: UIViewController {
    
    //Main view
    var gnomeListView : GnomeListView?
    
    //Presenter
    var presenter : GnomeListPresenter?
    
    //Data Source
    var dataSource: [DisplayedGnomes] = [] {
        didSet{
            if let tableView = gnomeListView?.tableView {
                tableView.reloadData()
            }
        }
    }
    
    override func loadView() {
        super.loadView()
        self.view = GnomeListView(frame: self.view.frame)
        gnomeListView = self.view as? GnomeListView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = GnomeListPresenterImpl(with: self)
        setupNavigationBar()
        setupInitialData()
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.isHidden = true
    }
    
    private func setupInitialData() {
        gnomeListView?.tableView.register(GnomeTableViewCell.classForCoder(), forCellReuseIdentifier: GnomeTableViewCell.GnomeTableViewCellIdentifier)
        gnomeListView?.tableView.dataSource = self
        gnomeListView?.tableView.delegate = self
        gnomeListView?.tableView.rowHeight = UITableViewAutomaticDimension
        gnomeListView?.tableView.estimatedRowHeight = 400
        presenter?.getGnomes()
    }
}

extension GnomeListViewController: GnomeListViewOutput {
    func displayErrorOnRetrieve(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func displayGnomes(data: [DisplayedGnomes]) {
        gnomeListView?.tableView.tableFooterView = UIView()
        self.dataSource = data
    }
    
    func displayLoading() {
        let activityView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        gnomeListView?.tableView.tableFooterView = activityView
        activityView.startAnimating()
    }
}

// MARK: Table View Data Source
extension GnomeListViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: GnomeTableViewCell.GnomeTableViewCellIdentifier, for: indexPath) as! GnomeTableViewCell
        let displayed = dataSource[indexPath.row]
        cell.updateUI(genderAsset: displayed.asset, name: displayed.name, age: displayed.age, weight: displayed.weight, height: displayed.height)
        
        return cell
    }
}
