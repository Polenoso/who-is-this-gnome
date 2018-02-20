//
//  GnomeListViewControllerTests.swift
//  knowTheGnomeTests
//
//  Created by Pagán Narro, Aitor on 20/02/2018.
//  Copyright © 2018 Aitor Pagán. All rights reserved.
//

import XCTest
@testable import knowTheGnome

class GnomeListViewControllerTests: XCTestCase {
    
    var gnomeListViewController : GnomeListViewController!
    var window : UIWindow!
    
    override func setUp() {
        super.setUp()
        window = UIWindow()
        setupViewController()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        window = nil
        super.tearDown()
    }
    
    func setupViewController() {
        gnomeListViewController = GnomeListViewController(presenter: GnomeListViewControllerOutputSpy())
    }
    
    func loadView() {
        window.addSubview(gnomeListViewController.view)
        RunLoop.current.run(until: Date())
    }
    
    class GnomeListViewControllerOutputSpy : GnomeListPresenter {
        var output: GnomeListViewOutput?
        
        
        var getGnomesCalled = false
        func getGnomes() {
            getGnomesCalled = true
        }
        
        var filterCalled = false
        func filter(with: String?, sortedBy: String, order: SortOrder) {
            filterCalled = true
        }

    }
    
    func testViewDidLoadShouldAskPresenterToGetGnomes() {
        //Given
        let outputSpy = GnomeListViewControllerOutputSpy()
        gnomeListViewController.presenter = outputSpy
        
        //When
        loadView()
        
        //Then
        XCTAssertTrue(outputSpy.getGnomesCalled)
    }
    
    func testDisplayLoadingShouldHideSortingView() {
        //Given
        let outputSpy = GnomeListViewControllerOutputSpy()
        gnomeListViewController.presenter = outputSpy
        loadView()
        
        //When
        gnomeListViewController.displayLoading()
        
        //Then
        XCTAssertTrue(outputSpy.getGnomesCalled)
        XCTAssertTrue((gnomeListViewController.gnomeListView?.sortingStackView.isHidden)!)
        XCTAssertTrue((gnomeListViewController.gnomeListView?.emptyView.isHidden)!)
        XCTAssertFalse((gnomeListViewController.gnomeListView?.tableView.isHidden)!)
    }
    
    func testDisplayEmptyListShouldHideTableView() {
        //Given
        let outputSpy = GnomeListViewControllerOutputSpy()
        gnomeListViewController.presenter = outputSpy
        loadView()
        
        //When
        gnomeListViewController.displayEmptyList()
        
        //Then
        XCTAssertTrue(outputSpy.getGnomesCalled)
        XCTAssertTrue((gnomeListViewController.gnomeListView?.sortingStackView.isHidden)!)
        XCTAssertFalse((gnomeListViewController.gnomeListView?.emptyView.isHidden)!)
        XCTAssertTrue((gnomeListViewController.gnomeListView?.tableView.isHidden)!)
    }
    
    func testDisplayGnomesShouldHideEmptyView() {
        //Given
        let outputSpy = GnomeListViewControllerOutputSpy()
        gnomeListViewController.presenter = outputSpy
        loadView()
        
        //When
        gnomeListViewController.displayGnomes(data: [DisplayedGnomes(asset: "", name: "", age: "", weight: "", height: "")])
        
        //Then
        XCTAssertTrue(outputSpy.getGnomesCalled)
        XCTAssertFalse((gnomeListViewController.gnomeListView?.sortingStackView.isHidden)!)
        XCTAssertTrue((gnomeListViewController.gnomeListView?.emptyView.isHidden)!)
        XCTAssertFalse((gnomeListViewController.gnomeListView?.tableView.isHidden)!)
    }
}
