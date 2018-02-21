//
//  GnomeDetailPresenterTests.swift
//  knowTheGnomeTests
//
//  Created by Aitor Pagán on 21/2/18.
//  Copyright © 2018 Aitor Pagán. All rights reserved.
//

import XCTest
@testable import knowTheGnome

class GnomeDetailPresenterTests: XCTestCase {
    
    var gnomeDetailPresenter : GnomeDetailPresenterImpl!
        
    override func setUp() {
        super.setUp()
        setupPresenter()
    }
    
    private func setupPresenter() {
        gnomeDetailPresenter = GnomeDetailPresenterImpl()
    }
    
    class GnomeDetailPresenterOutputSpy : GnomeDetailViewOutput {
        
        var displayGnomeCalled = false
        func displayGnome(data: DisplayedGnome) {
            displayGnomeCalled = true
        }
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGetGnomeShouldAskViewToDisplayGnome() {
        //Given
        let outputSpy = GnomeDetailPresenterOutputSpy()
        gnomeDetailPresenter.output = outputSpy
        
        //When
        gnomeDetailPresenter.getGnome()
        
        //Then
        XCTAssertTrue(outputSpy.displayGnomeCalled)
    }

}
