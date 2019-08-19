//
//  MockDogesModel.swift
//  DogenatorTests
//
//  Created by Jan Theile on 07/08/2019.
//  Copyright © 2019 Chorgo. All rights reserved.
//

@testable import Dogenator
import Foundation

final class DogesModelMock: DogesModelProtocol {

    var loadNextCalled = 0

    weak var delegate: DogesModelDelegate?

    private let session: SessionWrapper
    private let dogesURL: URL

    init(with session: SessionWrapper, dogesUrl: URL) {
        self.session = session
        self.dogesURL = dogesUrl
    }

    func loadNext() {
        loadNextCalled += 1
    }

}
