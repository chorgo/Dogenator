//
//  DogesViewModelMock.swift
//  DogenatorTests
//
//  Created by Jan Theile on 07/08/2019.
//  Copyright © 2019 Chorgo. All rights reserved.
//

@testable import Dogenator
import Foundation

final class DogesViewModelMock: DogesViewModelProtocol {

    var loadNextCalled = 0
    var addCalled = 0
    var addCalledNewDoges: [URL]?
    var noNewDogesCalled = 0

    var doges: [URL]
    weak var delegate: DogesViewModelDelegate?

    private let model: DogesModelProtocol

    init(with model: DogesModelProtocol) {
        doges = []
        self.model = model
    }

    func loadNext() {
        loadNextCalled += 1
        model.loadNext()
    }

}

extension DogesViewModelMock: DogesModelDelegate {

    func add(newDoges: [URL]) {
        addCalled += 1
        addCalledNewDoges = newDoges
    }

    func noNewDoges() {
        noNewDogesCalled += 1
    }

}
