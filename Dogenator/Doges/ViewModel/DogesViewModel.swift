//
//  DogesViewModel.swift
//  Dogenator
//
//  Created by Jan Theile on 07/08/2019.
//  Copyright © 2019 Chorgo. All rights reserved.
//

import Foundation

final class DogesViewModel: DogesViewModelProtocol {

    var doges: [URL]
    weak var delegate: DogesViewModelDelegate?
    
    private let model: DogesModelProtocol

    init(with model: DogesModelProtocol) {
        doges = []
        self.model = model
    }

    func loadNext() {
        model.loadNext()
    }

}

extension DogesViewModel: DogesModelDelegate {

    func add(newDoges: [URL]) {
        guard newDoges.count > 0 else {
            return
        }
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            let firstIndex = self.doges.count
            self.doges.append(contentsOf: newDoges)
            let lastIndex = self.doges.count - 1
            var newIndexPaths = [IndexPath]()
            for index in firstIndex ... lastIndex {
                newIndexPaths.append(IndexPath(row: index, section: 0))
            }
            if newIndexPaths.count > 0 {
                self.delegate?.insertedDoges(at: newIndexPaths)
            }
        }
    }

    func noNewDoges() {
        // Usually error handling would be handled here for example by logging or displaying a message to the user
        // In this case just by printing to console
        print("No new doges")
    }

}
