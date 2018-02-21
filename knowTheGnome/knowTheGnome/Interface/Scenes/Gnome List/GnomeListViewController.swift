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
    
    init(presenter: GnomeListPresenter) {
        self.presenter = presenter
        
        super.init(nibName: nil, bundle: nil)
        
        self.presenter?.output = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
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
    
    let sortingOptions = [[SortStyle.byDefault.rawValue : "Default"], [SortStyle.byAge.rawValue : "By Age"], [SortStyle.byWeight.rawValue : "By Weight"], [SortStyle.byHeight.rawValue : "By Height"]]
    
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
                gnomeListView?.sortingStackView.isHidden = true
            case .empty:
                gnomeListView?.tableView.isHidden = true
                gnomeListView?.emptyView.isHidden = false
                gnomeListView?.sortingStackView.isHidden = true
            case .data(let data):
                let view = UIView()
                gnomeListView?.tableView.tableFooterView = view
                gnomeListView?.tableView.isHidden = false
                gnomeListView?.emptyView.isHidden = true
                gnomeListView?.sortingStackView.isHidden = false
                dataSource = data
            }
        }
    }
    
    // View lifeCycle
    override func loadView() {
        super.loadView()
        self.view = GnomeListView(frame: self.view.frame)
        gnomeListView = self.view as? GnomeListView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupInitialData()
    }
    
    private func setupNavigationBar() {
        let backbutton = UIBarButtonItem()
        backbutton.title = " "
        navigationItem.backBarButtonItem = backbutton
    }
    
    private func setupInitialData() {
        // Setup Delegates
        gnomeListView?.tableView.register(GnomeTableViewCell.classForCoder(), forCellReuseIdentifier: GnomeTableViewCell.GnomeTableViewCellIdentifier)
        gnomeListView?.tableView.dataSource = self
        gnomeListView?.tableView.delegate = self
        gnomeListView?.tableView.rowHeight = UITableViewAutomaticDimension
        gnomeListView?.tableView.estimatedRowHeight = 400
        gnomeListView?.filterTextField.delegate = self
        gnomeListView?.sortingPickerView.delegate = self
        gnomeListView?.sortingPickerView.dataSource = self
        gnomeListView?.sortingOrderButton.addTarget(self, action: #selector(self.orderButtonTouched(_:)), for: .touchUpInside)
        //Hide Keyboard when touch outside
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        //Load Gnomes
        presenter?.getGnomes()
    }
    
    // MARK: Actions
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func orderButtonTouched(_ sender: Any) {
        let buttontitle = gnomeListView?.sortingOrderButton.titleLabel?.text ?? ""
        //Toggle button
        if buttontitle == "asc" {
            gnomeListView?.sortingOrderButton.setTitle("desc", for: .normal)
        } else {
            gnomeListView?.sortingOrderButton.setTitle("asc", for: .normal)
        }
        presenter?.filter(with: gnomeListView?.filterTextField.text, sortedBy: sortingOptions[(gnomeListView?.sortingPickerView.selectedRow(inComponent: 0))!].keys.first ?? "", order: SortOrder(from: gnomeListView?.sortingOrderButton.titleLabel?.text ?? ""))
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
    
    func navigateToDetail(data: Gnome) {
        let vc = GnomeDetailViewController(presenter: GnomeDetailPresenterImpl())
        vc.presenter?.selectedGnome = data
        navigationController?.pushViewController(vc, animated: true)
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.didSelectGnome(at: indexPath.row)
    }
}

// MARK: TextField Delegate
extension GnomeListViewController : UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = textField.text ?? ""
        let newText = (text as NSString).replacingCharacters(in: range, with: string)
        presenter?.filter(with: newText, sortedBy: "default", order: SortOrder(from: gnomeListView?.sortingOrderButton.titleLabel?.text ?? ""))
        return true
    }
}

// MARK: Picker View DataSource and Delegate
extension GnomeListViewController : UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return sortingOptions.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        presenter?.filter(with: self.gnomeListView?.filterTextField.text, sortedBy: sortingOptions[row].keys.first ?? "", order: SortOrder(from: gnomeListView?.sortingOrderButton.titleLabel?.text ?? ""))
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return sortingOptions[row].values.first
    }
    
}
