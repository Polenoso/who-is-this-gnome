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
    
    enum ViewState {
        case empty
        case data([DisplayedGnomes])
        case loading
    }
    
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
    
    //View State
    var viewState : ViewState = .loading {
        didSet {
            switch viewState {
            case .loading:
                gnomeListView?.tableView.isHidden = false
                let activityView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
                gnomeListView?.tableView.tableFooterView = activityView
                activityView.startAnimating()
                gnomeListView?.emptyView.isHidden = true
            case .empty:
                gnomeListView?.tableView.isHidden = true
                gnomeListView?.emptyView.isHidden = false
            case .data(let data):
                let view = UIView()
                gnomeListView?.tableView.tableFooterView = view
                gnomeListView?.tableView.isHidden = false
                gnomeListView?.emptyView.isHidden = true
                dataSource = data
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
        // Setup Delegates
        gnomeListView?.tableView.register(GnomeTableViewCell.classForCoder(), forCellReuseIdentifier: GnomeTableViewCell.GnomeTableViewCellIdentifier)
        gnomeListView?.tableView.dataSource = self
        gnomeListView?.tableView.delegate = self
        gnomeListView?.tableView.rowHeight = UITableViewAutomaticDimension
        gnomeListView?.tableView.estimatedRowHeight = 400
        gnomeListView?.filterTextField.delegate = self
        //Hide Keyboard when touch outside
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        //Load Gnomes
        presenter?.getGnomes()
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
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
        viewState = .data(data)
    }
    
    func displayEmptyList() {
        viewState = .empty
    }
    
    func displayLoading() {
        viewState = .loading
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

// MARK: TextField Delegate
extension GnomeListViewController : UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = textField.text ?? ""
        let newText = (text as NSString).replacingCharacters(in: range, with: string)
        presenter?.filter(with: newText, sortedBy: "default")
        return true
    }
}
