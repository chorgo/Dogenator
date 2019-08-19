//
//  MockDataTask.swift
//  DogenatorTests
//
//  Created by Jan Theile on 07/08/2019.
//  Copyright © 2019 Chorgo. All rights reserved.
//

@testable import Dogenator
import Foundation

final class DataTaskMock: DataTaskWrapper {

    private let data: Data?
    private let completionHandler: (Data?, URLResponse?, Error?) -> Void

    init(with data: Data?, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        self.data = data
        self.completionHandler = completionHandler
    }

    func resume() {
        completionHandler(data, nil, nil)
    }

    func cancel() {
        completionHandler(nil, nil, nil)
    }


}
