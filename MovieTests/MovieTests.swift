//
//  MovieTests.swift
//  MovieTests
//
//  Created by sandy ambarita on 25/02/20.
//

import XCTest
@testable import Movie

class MovieTests: XCTestCase {
    var viewController: UIViewController!
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        viewController = storyboard.instantiateViewController(withIdentifier: "MovieVC") as! MovieVC
        viewController.beginAppearanceTransition(true, animated: false)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()

        viewController.endAppearanceTransition()
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testControllerHasTableView() {
        guard let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MovieVC") as? MovieVC else {
            return XCTFail("Could not instantiate ViewController from main storyboard")
        }

        controller.loadViewIfNeeded()

        XCTAssertNotNil(controller.tableView,
                        "Controller should have a tableview")
    }
    
    func testNotEmptyNumberOfRowsInSection() {
        let vc = MovieVC()
        XCTAssertNotNil(vc.moviesViewModel.numberOfRowsInSection)
    }
    
}
