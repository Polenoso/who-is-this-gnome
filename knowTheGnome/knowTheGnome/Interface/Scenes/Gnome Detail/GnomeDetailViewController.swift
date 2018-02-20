//
//  GnomeDetailViewController.swift
//  knowTheGnome
//
//  Created by Pagán Narro, Aitor on 20/02/2018.
//  Copyright © 2018 Aitor Pagán. All rights reserved.
//

import UIKit

struct DisplayedGnome {
    let image : URL?
    let name : String
    let age : String
    let weight : String
    let height : String
    let jobs : [String]?
    let friends : [String]?
}

class GnomeDetailViewController : UIViewController {
    
    var presenter : GnomeDetailPresenter?
    
    init(presenter: GnomeDetailPresenter) {
        self.presenter = presenter
        
        super.init(nibName: nil, bundle: nil)
        
        self.presenter?.output = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        // Do any additional setup after loading the view.
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "Gnome Details"
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
}

// MARK: GnomeDetailViewOutput
extension GnomeDetailViewController : GnomeDetailViewOutput {
    
    func displayGnome(data: DisplayedGnome) {
        
    }
}
