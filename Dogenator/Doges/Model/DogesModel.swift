//
//  DogesModel.swift
//  Dogenator
//
//  Created by Jan Theile on 07/08/2019.
//  Copyright © 2019 Chorgo. All rights reserved.
//

import Foundation

final class DogesModel: DogesModelProtocol {

    weak var delegate: DogesModelDelegate?

    private let session: SessionWrapper
    private let dogesUrl: URL

    init(with session: SessionWrapper, dogesUrl: URL) {
        self.session = session
        self.dogesUrl = dogesUrl
    }

    func loadNext() {
        let task = session.wrappedDataTask(with: dogesUrl) { [weak self] data, _, error in
            guard let data = data, data.count > 0, error == nil else {
                // Usually propper error logging by using logging endpoint or file logs
                self?.delegate?.noNewDoges()
                return
            }
            guard let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) else {
                self?.delegate?.noNewDoges()
                return
            }
            guard let root = json as? [String: Any] else {
                self?.delegate?.noNewDoges()
                return
            }
            guard let dogesArray = root["doges"] as? [Any] else {
                self?.delegate?.noNewDoges()
                return
            }
            var newDoges = [URL]()
            for dogeAny in dogesArray {
                guard let dogePath = dogeAny as? String else {
                    continue
                }
                guard let dogeUrl = URL(string: dogePath) else {
                    continue
                }

                guard dogeUrl.absoluteString.hasSuffix("jpg") || dogeUrl.absoluteString.hasSuffix("png") else {
                    // Filter out urls that aren't images
                    // Feature: Display gifs and videos if included
                    continue
                }
                newDoges.append(dogeUrl)
            }
            if newDoges.count > 0 {
                self?.delegate?.add(newDoges: newDoges)
            } else {
                self?.delegate?.noNewDoges()
            }
        }
        task.resume()
    }

}
