//
//  DogesViewMock.swift
//  DogenatorTests
//
//  Created by Jan Theile on 07/08/2019.
//  Copyright © 2019 Chorgo. All rights reserved.
//

@testable import Dogenator
import UIKit
import XCTest

final class DogesViewMock: UIViewController, DogesViewModelDelegate {

    var insertedDogesCalled = 0
    var insertedDogesNewIndexPaths: [IndexPath]?

    var expectation: XCTestExpectation?

    func insertedDoges(at newIndexPaths: [IndexPath]) {
        insertedDogesCalled += 1
        insertedDogesNewIndexPaths = newIndexPaths
        expectation?.fulfill()
    }

}
