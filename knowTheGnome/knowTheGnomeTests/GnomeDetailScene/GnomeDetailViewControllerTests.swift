//
//  GnomeDetailViewControllerTests.swift
//  knowTheGnomeTests
//
//  Created by Aitor Pagán on 21/2/18.
//  Copyright © 2018 Aitor Pagán. All rights reserved.
//

import XCTest
@testable import knowTheGnome

class GnomeDetailViewControllerTests: XCTestCase {
    
    var gnomeDetailViewController : GnomeDetailViewController!
    var window : UIWindow!
    
    override func setUp() {
        super.setUp()
        window = UIWindow()
        setupViewController()
    }
    
    func setupViewController() {
        gnomeDetailViewController = GnomeDetailViewController(presenter: GnomeDetailViewControllerOutputSpy())
    }
    
    func loadView() {
        window.addSubview(gnomeDetailViewController.view)
        RunLoop.current.run(until: Date())
    }
    
    class GnomeDetailViewControllerOutputSpy : GnomeDetailPresenter {
        
        weak var output: GnomeDetailViewOutput?
        
        var selectedGnome: Gnome?
        
        var getGnomeCalled = false
        func getGnome() {
            getGnomeCalled = true
        }
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        window = nil
    }
    
    func testViewDidLoadShouldAskInteractorToGetGnome() {
        // Given
        let outputSpy = GnomeDetailViewControllerOutputSpy()
        gnomeDetailViewController.presenter = outputSpy
        outputSpy.selectedGnome = Gnome(id: 0, name: "", thumbnail: nil, age: 0, weight: 0.0, height: 0.0, hair_color: "", professions: [], friends: [])
        
        // When
        loadView()
        
        // Then
        XCTAssertTrue(outputSpy.getGnomeCalled)
    }
    
}
