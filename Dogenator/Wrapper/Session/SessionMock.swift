//
//  MockSessionWrapper.swift
//  DogenatorTests
//
//  Created by Jan Theile on 07/08/2019.
//  Copyright © 2019 Chorgo. All rights reserved.
//

@testable import Dogenator
import Foundation

final class SessionMock: SessionWrapper {

    var wrappedDataTaskCalled = 0

    private let data: Data?

    init(with data: Data?) {
        self.data = data
    }

    func wrappedDataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> DataTaskWrapper {
        wrappedDataTaskCalled += 1
        return DataTaskMock(with: data, completionHandler: completionHandler)
    }

}
