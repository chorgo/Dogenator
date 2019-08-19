//
//  DogesViewModelProtocol.swift
//  Dogenator
//
//  Created by Jan Theile on 07/08/2019.
//  Copyright © 2019 Chorgo. All rights reserved.
//

import Foundation

protocol DogesViewModelDelegate: class {

    func insertedDoges(at newIndexPaths: [IndexPath])

}

protocol DogesViewModelProtocol {

    var doges: [URL] { get }
    var delegate: DogesViewModelDelegate? { get set }

    init(with model: DogesModelProtocol)
    func loadNext()

}
