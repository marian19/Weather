//
//  WeatherTests.swift
//  WeatherTests
//
//  Created by Marian on 6/7/18.
//  Copyright © 2018 Marian. All rights reserved.
//

import XCTest
@testable import Weather

class WeatherTests: XCTestCase {
    
    var viewController: CitiesListViewController!

    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        viewController = storyboard.instantiateViewController(withIdentifier: "CitiesListViewController") as! CitiesListViewController
        UIApplication.shared.keyWindow!.rootViewController = viewController
    }
    
    override func tearDown() {
        viewController = nil
        super.tearDown()
    }
    
    func testIBOutlest() {
        XCTAssertNotNil((viewController.tableView ), "table not connected in storyboard")
        
    }
    
    func testProperties() {
        
        XCTAssertNotNil((viewController.presenter), "presenter not intialize")
        
    }
    
    func testGetCities() {
        viewController.viewDidLoad()
        let presenter = MockPresenter(view: viewController)
        viewController.presenter = presenter
        presenter.getCitiesList()
        XCTAssertTrue(presenter.succesFetch , "login should have been called")
        
    }
    
    
}

class MockPresenter: CitiesListPresenter {
    var succesFetch = false
    
    override func getCitiesList() {
            succesFetch = true
        
    }
    
    
}
