//
//  DogesViewModelTests.swift
//  DogenatorTests
//
//  Created by Jan Theile on 07/08/2019.
//  Copyright © 2019 Chorgo. All rights reserved.
//

import XCTest
@testable import Dogenator

class DogesViewModelTests: XCTestCase {

    var model: DogesModelMock!

    override func setUp() {
        model = DogesModelMock(with: SessionMock(with: nil), dogesUrl: URL(string: "https://test.de")!)
    }

    func testLoadNextHappyPath() {
        let viewModel = DogesViewModel(with: model)

        XCTAssertEqual(model.loadNextCalled, 0)

        viewModel.loadNext()

        XCTAssertEqual(model.loadNextCalled, 1)
    }

    func testNoNewDogesHappyPath() {
        let viewModel = DogesViewModel(with: model)

        viewModel.noNewDoges()
    }

    func testAddNewDogesHappyPath() {
        let viewModel = DogesViewModel(with: model)
        let expectation = XCTestExpectation(description: "insertedDogesCalled")
        let view = DogesViewMock(nibName: nil, bundle: nil)
        view.expectation = expectation
        viewModel.delegate = view

        XCTAssertEqual(view.insertedDogesCalled, 0)
        XCTAssertEqual(view.insertedDogesNewIndexPaths, nil)

        let newDoges = [URL(string: "http://test1.jpg")!,
                        URL(string: "http://test2.png")!,
                        URL(string: "http://test3.jpg")!]
        viewModel.add(newDoges: newDoges)

        wait(for: [expectation], timeout: 5)

        let newIndexPaths = [IndexPath(row: 0, section: 0),
                            IndexPath(row: 1, section: 0),
                            IndexPath(row: 2, section: 0)]
        XCTAssertEqual(view.insertedDogesCalled, 1)
        XCTAssertEqual(view.insertedDogesNewIndexPaths, newIndexPaths)
    }

    func testAddNewDogesJustOneNew() {
        let viewModel = DogesViewModel(with: model)
        let expectation = XCTestExpectation(description: "insertedDogesCalled")
        let view = DogesViewMock(nibName: nil, bundle: nil)
        view.expectation = expectation
        viewModel.delegate = view

        XCTAssertEqual(view.insertedDogesCalled, 0)
        XCTAssertEqual(view.insertedDogesNewIndexPaths, nil)

        let newDoges = [URL(string: "http://test1.jpg")!]
        viewModel.add(newDoges: newDoges)

        wait(for: [expectation], timeout: 5)

        let newIndexPaths = [IndexPath(row: 0, section: 0)]
        XCTAssertEqual(view.insertedDogesCalled, 1)
        XCTAssertEqual(view.insertedDogesNewIndexPaths, newIndexPaths)
    }

    func testAddNewDogesNoNewIndexPaths() {
        let viewModel = DogesViewModel(with: model)
        let expectation = XCTestExpectation(description: "insertedDogesCalled")
        let view = DogesViewMock(nibName: nil, bundle: nil)
        view.expectation = expectation
        viewModel.delegate = view

        XCTAssertEqual(view.insertedDogesCalled, 0)
        XCTAssertEqual(view.insertedDogesNewIndexPaths, nil)

        let newDoges = [URL]()
        viewModel.add(newDoges: newDoges)

        XCTAssertEqual(view.insertedDogesCalled, 0)
        XCTAssertEqual(view.insertedDogesNewIndexPaths, nil)
    }

}
