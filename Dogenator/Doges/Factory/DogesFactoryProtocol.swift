//
//  DogesFactoryProtocol.swift
//  Dogenator
//
//  Created by Jan Theile on 07/08/2019.
//  Copyright © 2019 Chorgo. All rights reserved.
//

import UIKit

protocol DogesFactoryProtocol {

    func getDoges(with session: SessionWrapper, dogesUrl: URL) -> UIViewController

}
