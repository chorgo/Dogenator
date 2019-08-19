//
//  DogesViewTests.swift
//  DogenatorTests
//
//  Created by Jan Theile on 07/08/2019.
//  Copyright © 2019 Chorgo. All rights reserved.
//

import XCTest
@testable import Dogenator

class DogesViewTests: XCTestCase {

    var session: SessionMock!
    var model: DogesModelMock!
    var viewModel: DogesViewModelMock!

    override func setUp() {
        session = SessionMock(with: nil)
        model = DogesModelMock(with: session, dogesUrl: URL(string: "https://test.de")!)
        viewModel = DogesViewModelMock(with: model)
        model.delegate = viewModel
    }

    func testIsLookingGood() {
        let view = DogesCollectionViewController(with: viewModel, session: session)
        viewModel.delegate = view

        UIApplication.shared.keyWindow!.rootViewController = view
        XCTAssertNotNil(view)
        XCTAssertNotNil(view.view)
        XCTAssertEqual(view.title, "Dogenator")
        XCTAssertEqual(view.collectionView.visibleCells.count, 0)
    }

    func testInsertedDogesHappyPath() {
        let view = DogesCollectionViewController(with: viewModel, session: session)
        viewModel.delegate = view

        UIApplication.shared.keyWindow!.rootViewController = view
        XCTAssertNotNil(view)
        XCTAssertNotNil(view.view)
        XCTAssertEqual(view.collectionView.visibleCells.count, 0)

        let newDoges = [URL(string: "http://test1.jpg")!,
                        URL(string: "http://test2.png")!,
                        URL(string: "http://test3.jpg")!]
        viewModel.doges = newDoges

        let newIndexPaths = [IndexPath(row: 0, section: 0),
                             IndexPath(row: 1, section: 0),
                             IndexPath(row: 2, section: 0)]
        view.insertedDoges(at: newIndexPaths)

        XCTAssertEqual(view.collectionView.visibleCells.count, 3)
        XCTAssertNotNil(view.collectionView.visibleCells.last)
        guard let cell = view.collectionView.visibleCells.last as? DogesCollectionCell else {
            return
        }
        XCTAssertNotNil(cell)
    }

    func testInsertedDogesNotEmptyCollectionView() {
        let view = DogesCollectionViewController(with: viewModel, session: session)
        viewModel.delegate = view

        UIApplication.shared.keyWindow!.rootViewController = view
        XCTAssertNotNil(view)
        XCTAssertNotNil(view.view)
        XCTAssertEqual(view.collectionView.visibleCells.count, 0)

        let newDoges = [URL(string: "http://test1.jpg")!]
        viewModel.doges = newDoges

        let newIndexPaths = [IndexPath(row: 0, section: 0)]
        view.insertedDoges(at: newIndexPaths)

        XCTAssertEqual(view.collectionView.visibleCells.count, 1)
        XCTAssertNotNil(view.collectionView.visibleCells.last)
        guard let cell = view.collectionView.visibleCells.last as? DogesCollectionCell else {
            return
        }
        XCTAssertNotNil(cell)

        let newDoges2 = [URL(string: "http://test1.jpg")!,
                         URL(string: "http://test2.png")!,
                         URL(string: "http://test3.jpg")!]
        viewModel.doges = newDoges2

        let newIndexPaths2 = [IndexPath(row: 1, section: 0),
                             IndexPath(row: 2, section: 0)]
        view.insertedDoges(at: newIndexPaths2)

        XCTAssertEqual(view.collectionView.visibleCells.count, 3)
        XCTAssertNotNil(view.collectionView.visibleCells.last)
        guard let newCell = view.collectionView.visibleCells.last as? DogesCollectionCell else {
            return
        }
        XCTAssertNotNil(newCell)
    }

    func testInsertedDogesNoNewDoges() {
        let view = DogesCollectionViewController(with: viewModel, session: session)
        viewModel.delegate = view

        UIApplication.shared.keyWindow!.rootViewController = view
        XCTAssertNotNil(view)
        XCTAssertNotNil(view.view)
        XCTAssertEqual(view.collectionView.visibleCells.count, 0)

        let newDoges = [URL(string: "http://test1.jpg")!]
        viewModel.doges = newDoges

        let newIndexPaths = [IndexPath(row: 0, section: 0)]
        view.insertedDoges(at: newIndexPaths)

        XCTAssertEqual(view.collectionView.visibleCells.count, 1)
        XCTAssertNotNil(view.collectionView.visibleCells.last)
        guard let cell = view.collectionView.visibleCells.last as? DogesCollectionCell else {
            return
        }
        XCTAssertNotNil(cell)

        let newIndexPaths2 = [IndexPath]()
        view.insertedDoges(at: newIndexPaths2)

        XCTAssertEqual(view.collectionView.visibleCells.count, 1)
        XCTAssertNotNil(view.collectionView.visibleCells.last)
        guard let newCell = view.collectionView.visibleCells.last as? DogesCollectionCell else {
            return
        }
        XCTAssertNotNil(newCell)
    }

    func testSelectCell() {
        let view = DogesCollectionViewController(with: viewModel, session: session)
        viewModel.delegate = view

        UIApplication.shared.keyWindow!.rootViewController = view
        XCTAssertNotNil(view)
        XCTAssertNotNil(view.view)
        XCTAssertEqual(view.collectionView.visibleCells.count, 0)

        let newDoges = [URL(string: "http://test1.jpg")!]
        viewModel.doges = newDoges

        let newIndexPaths = [IndexPath(row: 0, section: 0)]
        view.insertedDoges(at: newIndexPaths)

        XCTAssertEqual(view.collectionView.visibleCells.count, 1)
        XCTAssertNotNil(view.collectionView.visibleCells.last)
        guard let cell = view.collectionView.visibleCells.last as? DogesCollectionCell else {
            return
        }
        XCTAssertNotNil(cell)
        XCTAssertEqual(session.wrappedDataTaskCalled, 1) // Has been called when loading the cell

        view.collectionView(view.collectionView, didSelectItemAt: IndexPath(row: 0, section: 0))
        XCTAssertEqual(session.wrappedDataTaskCalled, 2)
    }

}
