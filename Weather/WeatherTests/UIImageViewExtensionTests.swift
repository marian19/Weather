//
//  UIImageViewExtensionTests.swift
//  WeatherTests
//
//  Created by Marian on 6/9/18.
//  Copyright © 2018 Marian. All rights reserved.
//

import XCTest
@testable import Weather

class UIImageViewExtensionTests: XCTestCase {
    
    var imageView: UIImageView!

    override func setUp() {
        super.setUp()
        imageView = UIImageView.init()
    }
    
    override func tearDown() {
        imageView = nil
        super.tearDown()
    }
    
    func testThatImageCanBeDownloadedFromIcone() {
        
       imageView.setImageFrom(icon: "10dd")
        let exists = NSPredicate(format: "image != nil")
        expectation(for: exists, evaluatedWith: self.imageView, handler: nil)
        waitForExpectations(timeout: 10, handler: nil)
    }
    
  
    
}
