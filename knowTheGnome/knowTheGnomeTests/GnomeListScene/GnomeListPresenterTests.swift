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
        gnomeListPresenter = GnomeListPresenterImpl(with: GnomeListPresenterOutputSpy())
    }
    
    class GnomeListPresenterOutputSpy : GnomeListViewOutput {
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
    
    func testGetGnomesWithSuccessShouldAskViewToDisplayGnomes() {
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
        XCTAssertTrue(outputSpy.displayGnomesCalled)
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
}
