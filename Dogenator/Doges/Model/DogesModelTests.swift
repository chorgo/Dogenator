//
//  DogesModelTests.swift
//  DogenatorTests
//
//  Created by Jan Theile on 07/08/2019.
//  Copyright © 2019 Chorgo. All rights reserved.
//

import XCTest
@testable import Dogenator

class DogesModelTests: XCTestCase {

    func testLoadNextHappyPath() {
        let string =
        """
    {
"doges":[
"http://test1.jpg",
"http://test2.png",
"http://test3.jpg",
]
}
"""
        guard let data = string.data(using: String.Encoding.utf16) else {
            XCTFail("No valid data")
            return
        }
        let session = SessionMock(with: data)
        let model = DogesModel(with: session, dogesUrl: URL(string: "https://test.de")!)
        let delegate = DogesViewModelMock(with: model)
        model.delegate = delegate

        XCTAssertEqual(delegate.addCalled, 0)
        XCTAssertEqual(delegate.addCalledNewDoges, nil)
        XCTAssertEqual(delegate.noNewDogesCalled, 0)

        model.loadNext()

        let newDoges = [URL(string: "http://test1.jpg")!,
                        URL(string: "http://test2.png")!,
                        URL(string: "http://test3.jpg")!]

        XCTAssertEqual(delegate.addCalled, 1)
        XCTAssertEqual(delegate.addCalledNewDoges, newDoges)
        XCTAssertEqual(delegate.noNewDogesCalled, 0)
    }

    func testNoData() {
        let session = SessionMock(with: nil)
        let model = DogesModel(with: session, dogesUrl: URL(string: "https://test.de")!)
        let delegate = DogesViewModelMock(with: model)
        model.delegate = delegate

        XCTAssertEqual(delegate.addCalled, 0)
        XCTAssertEqual(delegate.addCalledNewDoges, nil)
        XCTAssertEqual(delegate.noNewDogesCalled, 0)

        model.loadNext()

        XCTAssertEqual(delegate.addCalled, 0)
        XCTAssertEqual(delegate.addCalledNewDoges, nil)
        XCTAssertEqual(delegate.noNewDogesCalled, 1)
    }

    func testInvalidJson() {
        let string =
        """
    {
"doges":[
"http://test1.jpg",
"http://test2.png",
"http://test3.jpg",
"""
        guard let data = string.data(using: String.Encoding.utf16) else {
            XCTFail("No valid data")
            return
        }
        let session = SessionMock(with: data)
        let model = DogesModel(with: session, dogesUrl: URL(string: "https://test.de")!)
        let delegate = DogesViewModelMock(with: model)
        model.delegate = delegate

        XCTAssertEqual(delegate.addCalled, 0)
        XCTAssertEqual(delegate.addCalledNewDoges, nil)
        XCTAssertEqual(delegate.noNewDogesCalled, 0)

        model.loadNext()

        XCTAssertEqual(delegate.addCalled, 0)
        XCTAssertEqual(delegate.addCalledNewDoges, nil)
        XCTAssertEqual(delegate.noNewDogesCalled, 1)
    }

    func testWrongJsonFormat() {
        let string =
        """
    {
"dogs":[
"http://test1.jpg",
"http://test2.png",
"http://test3.jpg",
]
}
"""
        guard let data = string.data(using: String.Encoding.utf16) else {
            XCTFail("No valid data")
            return
        }
        let session = SessionMock(with: data)
        let model = DogesModel(with: session, dogesUrl: URL(string: "https://test.de")!)
        let delegate = DogesViewModelMock(with: model)
        model.delegate = delegate

        XCTAssertEqual(delegate.addCalled, 0)
        XCTAssertEqual(delegate.addCalledNewDoges, nil)
        XCTAssertEqual(delegate.noNewDogesCalled, 0)

        model.loadNext()

        XCTAssertEqual(delegate.addCalled, 0)
        XCTAssertEqual(delegate.addCalledNewDoges, nil)
        XCTAssertEqual(delegate.noNewDogesCalled, 1)
    }

    func testNoDogesKey() {
        let string =
        """
[
"http://test1.jpg",
"http://test2.png",
"http://test3.jpg",
]
"""
        guard let data = string.data(using: String.Encoding.utf16) else {
            XCTFail("No valid data")
            return
        }
        let session = SessionMock(with: data)
        let model = DogesModel(with: session, dogesUrl: URL(string: "https://test.de")!)
        let delegate = DogesViewModelMock(with: model)
        model.delegate = delegate

        XCTAssertEqual(delegate.addCalled, 0)
        XCTAssertEqual(delegate.addCalledNewDoges, nil)
        XCTAssertEqual(delegate.noNewDogesCalled, 0)

        model.loadNext()

        XCTAssertEqual(delegate.addCalled, 0)
        XCTAssertEqual(delegate.addCalledNewDoges, nil)
        XCTAssertEqual(delegate.noNewDogesCalled, 1)
    }

    func testIntInArray() {
        let string =
        """
    {
"doges":[
1,
"http://test2.png",
"http://test3.jpg",
]
}
"""
        guard let data = string.data(using: String.Encoding.utf16) else {
            XCTFail("No valid data")
            return
        }
        let session = SessionMock(with: data)
        let model = DogesModel(with: session, dogesUrl: URL(string: "https://test.de")!)
        let delegate = DogesViewModelMock(with: model)
        model.delegate = delegate

        XCTAssertEqual(delegate.addCalled, 0)
        XCTAssertEqual(delegate.addCalledNewDoges, nil)
        XCTAssertEqual(delegate.noNewDogesCalled, 0)

        model.loadNext()

        let newDoges = [URL(string: "http://test2.png")!,
                        URL(string: "http://test3.jpg")!]

        XCTAssertEqual(delegate.addCalled, 1)
        XCTAssertEqual(delegate.addCalledNewDoges, newDoges)
        XCTAssertEqual(delegate.noNewDogesCalled, 0)
    }

    func testGifInArray() {
        let string =
        """
    {
"doges":[
"http://test1.jpg",
"http://test2.png",
"http://test4.gif",
]
}
"""
        guard let data = string.data(using: String.Encoding.utf16) else {
            XCTFail("No valid data")
            return
        }
        let session = SessionMock(with: data)
        let model = DogesModel(with: session, dogesUrl: URL(string: "https://test.de")!)
        let delegate = DogesViewModelMock(with: model)
        model.delegate = delegate

        XCTAssertEqual(delegate.addCalled, 0)
        XCTAssertEqual(delegate.addCalledNewDoges, nil)
        XCTAssertEqual(delegate.noNewDogesCalled, 0)

        model.loadNext()

        let newDoges = [URL(string: "http://test1.jpg")!,
                        URL(string: "http://test2.png")!]

        XCTAssertEqual(delegate.addCalled, 1)
        XCTAssertEqual(delegate.addCalledNewDoges, newDoges)
        XCTAssertEqual(delegate.noNewDogesCalled, 0)
    }

    func testInvalidUrl() {
        let string =
        """
    {
"doges":[
"http://test1.jpg",
"http://test2.png",
"",
]
}
"""
        guard let data = string.data(using: String.Encoding.utf16) else {
            XCTFail("No valid data")
            return
        }
        let session = SessionMock(with: data)
        let model = DogesModel(with: session, dogesUrl: URL(string: "https://test.de")!)
        let delegate = DogesViewModelMock(with: model)
        model.delegate = delegate

        XCTAssertEqual(delegate.addCalled, 0)
        XCTAssertEqual(delegate.addCalledNewDoges, nil)
        XCTAssertEqual(delegate.noNewDogesCalled, 0)

        model.loadNext()

        let newDoges = [URL(string: "http://test1.jpg")!,
                        URL(string: "http://test2.png")!]

        XCTAssertEqual(delegate.addCalled, 1)
        XCTAssertEqual(delegate.addCalledNewDoges, newDoges)
        XCTAssertEqual(delegate.noNewDogesCalled, 0)
    }

    func testNoValidUrls() {
        let string =
        """
    {
"doges":[
1,
"a",
"",
]
}
"""
        guard let data = string.data(using: String.Encoding.utf16) else {
            XCTFail("No valid data")
            return
        }
        let session = SessionMock(with: data)
        let model = DogesModel(with: session, dogesUrl: URL(string: "https://test.de")!)
        let delegate = DogesViewModelMock(with: model)
        model.delegate = delegate

        XCTAssertEqual(delegate.addCalled, 0)
        XCTAssertEqual(delegate.addCalledNewDoges, nil)
        XCTAssertEqual(delegate.noNewDogesCalled, 0)

        model.loadNext()

        XCTAssertEqual(delegate.addCalled, 0)
        XCTAssertEqual(delegate.addCalledNewDoges, nil)
        XCTAssertEqual(delegate.noNewDogesCalled, 1)
    }

}
