//
//  DogesFactory.swift
//  Dogenator
//
//  Created by Jan Theile on 07/08/2019.
//  Copyright © 2019 Chorgo. All rights reserved.
//

import UIKit

final class DogesFactory: DogesFactoryProtocol {

    func getDoges(with session: SessionWrapper, dogesUrl: URL) -> UIViewController {
        let model = DogesModel(with: session, dogesUrl: dogesUrl)
        let viewModel = DogesViewModel(with: model)
        model.delegate = viewModel
        let view = DogesCollectionViewController(with: viewModel, session: session)
        viewModel.delegate = view
        return view
    }

}
