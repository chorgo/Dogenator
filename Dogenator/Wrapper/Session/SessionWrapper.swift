//
//  SessionWrapper.swift
//  Dogenator
//
//  Created by Jan Theile on 07/08/2019.
//  Copyright © 2019 Chorgo. All rights reserved.
//

import Foundation

protocol SessionWrapper {

    func wrappedDataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> DataTaskWrapper

}

extension URLSession: SessionWrapper {

    func wrappedDataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> DataTaskWrapper {
        return dataTask(with: url, completionHandler: completionHandler)
    }

}
