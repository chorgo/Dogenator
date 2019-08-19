//
//  DogesModelProtocol.swift
//  Dogenator
//
//  Created by Jan Theile on 07/08/2019.
//  Copyright © 2019 Chorgo. All rights reserved.
//

import Foundation

protocol DogesModelDelegate: class {

    func add(newDoges: [URL])
    func noNewDoges()

}

protocol DogesModelProtocol {

    var delegate: DogesModelDelegate? { get set }

    init(with session: SessionWrapper, dogesUrl: URL)
    func loadNext()

}
