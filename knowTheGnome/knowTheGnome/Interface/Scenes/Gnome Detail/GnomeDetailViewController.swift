//
//  GnomeDetailViewController.swift
//  knowTheGnome
//
//  Created by Pagán Narro, Aitor on 20/02/2018.
//  Copyright © 2018 Aitor Pagán. All rights reserved.
//

import UIKit
import Kingfisher

struct DisplayedGnome {
    let image : URL?
    let name : String
    let age : String
    let weight : String
    let height : String
    let hairColor : String
    let jobs : [String]?
    let friends : [String]?
}

class GnomeDetailViewController : UIViewController {
    
    var presenter : GnomeDetailPresenter?
    
    var gnomeDetailView : GnomeDetailView?
    
    // Helpers
    var jobsTableView : UITableView?
    var friendsTableView : UITableView?
    
    // Datasources
    var jobs : [String]? {
        didSet {
            jobsTableView?.reloadData()
            jobsTableView?.layoutIfNeeded()
            gnomeDetailView?.jobsTableViewHeightConstraint.constant = jobsTableView?.contentSize.height ?? 40.0
        }
    }
    var friends : [String]? {
        didSet {
            friendsTableView?.reloadData()
            friendsTableView?.layoutIfNeeded()
            gnomeDetailView?.friendsTableViewHeightConstraint.constant = friendsTableView?.contentSize.height ?? 40.0
        }
    }
    
    init(presenter: GnomeDetailPresenter) {
        self.presenter = presenter
        
        super.init(nibName: nil, bundle: nil)
        
        self.presenter?.output = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // View lifeCycle
    override func loadView() {
        super.loadView()
        self.view = GnomeDetailView(frame: self.view.bounds)
        gnomeDetailView = self.view as? GnomeDetailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupComponents()
        presenter?.getGnome()
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "Gnome Details"
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    private func setupComponents() {
        jobsTableView = gnomeDetailView?.jobsTableView
        friendsTableView = gnomeDetailView?.friendsTableView
        jobsTableView?.register(DetailComponentTableViewCell.classForCoder(), forCellReuseIdentifier: DetailComponentTableViewCell.DetailComponentTableViewCellIdentifier)
        friendsTableView?.register(DetailComponentTableViewCell.classForCoder(), forCellReuseIdentifier: DetailComponentTableViewCell.DetailComponentTableViewCellIdentifier)
        jobsTableView?.dataSource = self
        friendsTableView?.dataSource = self
        jobsTableView?.rowHeight = UITableViewAutomaticDimension
        jobsTableView?.estimatedRowHeight = 55.0
        friendsTableView?.rowHeight = UITableViewAutomaticDimension
        friendsTableView?.estimatedRowHeight = 55.0
    }
}

// MARK: GnomeDetailViewOutput
extension GnomeDetailViewController : GnomeDetailViewOutput {
    
    func displayGnome(data: DisplayedGnome) {
        gnomeDetailView?.thumbnailImageView.kf.setImage(with: data.image)
        gnomeDetailView?.nameLabel.text = data.name
        gnomeDetailView?.ageLabel.text = data.age
        gnomeDetailView?.weightLabel.text = data.weight
        gnomeDetailView?.heightLabel.text = data.height
        gnomeDetailView?.hairColorLabel.text = data.hairColor
        jobs = data.jobs
        friends = data.friends
    }
}

// MARK: TableView DataSource && Delegate
extension GnomeDetailViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == jobsTableView {
            return jobs?.count ?? 0
        } else if tableView == friendsTableView {
            return friends?.count ?? 0
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DetailComponentTableViewCell.DetailComponentTableViewCellIdentifier, for: indexPath) as! DetailComponentTableViewCell
        if tableView == jobsTableView {
            cell.updateUI(title: jobs?[indexPath.row])
        } else if tableView == friendsTableView {
            cell.updateUI(title: friends?[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if tableView == jobsTableView {
            return "Professions"
        } else {
            return "Friends"
        }
    }
}
