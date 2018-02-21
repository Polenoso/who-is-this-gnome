//
//  GnomeListPresenterTests.swift
//  knowTheGnomeTests
//
//  Created by Aitor Pagán on 18/2/18.
//  Copyright © 2018 Aitor Pagán. All rights reserved.
//

import XCTest
@testable import knowTheGnome

class GnomeListPresenterTests: XCTestCase {
    
    var gnomeListPresenter: GnomeListPresenterImpl!
    
    override func setUp() {
        super.setUp()
        setupPresenter()
    }
    
    func setupPresenter() {
        gnomeListPresenter = GnomeListPresenterImpl()
    }
    
    class GnomeListPresenterOutputSpy : GnomeListViewOutput {
        var navigateToDetailCalled = false
        func navigateToDetail(data: Gnome) {
            navigateToDetailCalled = true
        }
        
        var displayErrorOnRetreiveCalled = false
        func displayErrorOnRetrieve(title: String, message: String) {
            displayErrorOnRetreiveCalled = true
        }
        
        var displayGnomesCalled = false
        func displayGnomes(data: [DisplayedGnomes]) {
            displayGnomesCalled = true
        }
        
        var displayLoadingCalled = false
        func displayLoading() {
            displayLoadingCalled = true
        }
        
        var displayEmptyListCalled = false
        func displayEmptyList() {
            displayEmptyListCalled = true
        }
        
    }
    
    class GnomeServiceSpy : GnomeService {
        var isSuccess = true
        var getGnomesCalled = false
        func getGnomes(_ successHandler: @escaping GetGnomesSuccessHandler, errorHandler: @escaping GetGnomesErrorHandler) {
            getGnomesCalled = true
            if isSuccess {
                successHandler([])
            } else {
                errorHandler(ReturnError.generic("error"))
            }
        }
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testLoadPresenterShouldDoNothing() {
        let outputSpy = GnomeListPresenterOutputSpy()
        gnomeListPresenter.output = outputSpy
        XCTAssertFalse(outputSpy.displayLoadingCalled)
        XCTAssertFalse(outputSpy.displayGnomesCalled)
        XCTAssertFalse(outputSpy.displayErrorOnRetreiveCalled)
    }
    
    func testGetGnomesWithSuccessShouldAskViewToDisplayEmptyGnomes() {
        //Given
        let outputSpy = GnomeListPresenterOutputSpy()
        gnomeListPresenter.output = outputSpy
        let serviceSpy = GnomeServiceSpy()
        serviceSpy.isSuccess = true
        gnomeListPresenter.gnomeService = serviceSpy
        
        //When
        gnomeListPresenter.getGnomes()
        
        //Then
        XCTAssertTrue(outputSpy.displayLoadingCalled)
        XCTAssertTrue(serviceSpy.getGnomesCalled)
        XCTAssertTrue(outputSpy.displayEmptyListCalled)
    }
    
    func testGetGnomesWithErrorShouldAskViewToDisplayError() {
        //Given
        let outputSpy = GnomeListPresenterOutputSpy()
        gnomeListPresenter.output = outputSpy
        let serviceSpy = GnomeServiceSpy()
        serviceSpy.isSuccess = false
        gnomeListPresenter.gnomeService = serviceSpy
        
        //When
        gnomeListPresenter.getGnomes()
        
        //Then
        XCTAssertTrue(outputSpy.displayLoadingCalled)
        XCTAssertTrue(serviceSpy.getGnomesCalled)
        XCTAssertTrue(outputSpy.displayErrorOnRetreiveCalled)
    }
    
    func testFilterWithEmptyListShouldAskViewToDisplayEmptyList() {
        //Given
        let outputSpy = GnomeListPresenterOutputSpy()
        gnomeListPresenter.output = outputSpy
        let serviceSpy = GnomeServiceSpy()
        serviceSpy.isSuccess = false
        gnomeListPresenter.gnomeService = serviceSpy
        gnomeListPresenter.gnomes = []
        
        //When
        gnomeListPresenter.filter(with: "", sortedBy: "", order: SortOrder.asc)
        
        //Then
        XCTAssertTrue(outputSpy.displayEmptyListCalled)
    }
    
    func testFilterWithContainedGnomeShouldAskViewToDisplayGnomes() {
        //Given
        let outputSpy = GnomeListPresenterOutputSpy()
        gnomeListPresenter.output = outputSpy
        let serviceSpy = GnomeServiceSpy()
        serviceSpy.isSuccess = false
        gnomeListPresenter.gnomeService = serviceSpy
        let gnomeNameTest = "test"
        gnomeListPresenter.gnomes = [Gnome(id: 0, name: gnomeNameTest, thumbnail: nil, age: 0, weight: 0.0, height: 0.0, hair_color: "", professions: [], friends: [])]
        
        //When
        gnomeListPresenter.filter(with: gnomeNameTest, sortedBy: "", order: SortOrder.asc)
        
        //Then
        XCTAssertTrue(outputSpy.displayGnomesCalled)
    }
    
    func testDidSelectGnomeShouldAskViewToNavigateToDetail() {
        //Given
        let outputSpy = GnomeListPresenterOutputSpy()
        gnomeListPresenter.output = outputSpy
        let serviceSpy = GnomeServiceSpy()
        serviceSpy.isSuccess = false
        gnomeListPresenter.gnomeService = serviceSpy
        let gnomeNameTest = "test"
        gnomeListPresenter.gnomes = [Gnome(id: 0, name: gnomeNameTest, thumbnail: nil, age: 0, weight: 0.0, height: 0.0, hair_color: "", professions: [], friends: [])]
        
        // When
        gnomeListPresenter.didSelectGnome(at: 0)
        
        // Then
        XCTAssertTrue(outputSpy.navigateToDetailCalled)
    }
    
    func testDidSelectGnomeOutOfBoundsShouldNotNavigateToDetail() {
        //Given
        let outputSpy = GnomeListPresenterOutputSpy()
        gnomeListPresenter.output = outputSpy
        let serviceSpy = GnomeServiceSpy()
        serviceSpy.isSuccess = false
        gnomeListPresenter.gnomeService = serviceSpy
        
        // When
        gnomeListPresenter.didSelectGnome(at: 0)
        
        // Then
        XCTAssertFalse(outputSpy.navigateToDetailCalled)
    }
}
