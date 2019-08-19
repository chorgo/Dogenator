//
//  DogesFactoryMock.swift
//  DogenatorTests
//
//  Created by Jan Theile on 07/08/2019.
//  Copyright © 2019 Chorgo. All rights reserved.
//

@testable import Dogenator
import UIKit

final class DogesFactoryMock: DogesFactoryProtocol {

    func getDoges(with session: SessionWrapper, dogesUrl: URL) -> UIViewController {
        let model = DogesModelMock(with: session, dogesUrl: dogesUrl)
        let viewModel = DogesViewModelMock(with: model)
        model.delegate = viewModel
        let view = DogesViewMock()
        viewModel.delegate = view
        return view
    }

}
