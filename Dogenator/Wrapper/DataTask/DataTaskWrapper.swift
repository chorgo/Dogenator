//
//  DataTaskWrapper.swift
//  Dogenator
//
//  Created by Jan Theile on 07/08/2019.
//  Copyright © 2019 Chorgo. All rights reserved.
//

import Foundation

protocol DataTaskWrapper {

    func resume()
    func cancel()

}

extension URLSessionDataTask: DataTaskWrapper { }
