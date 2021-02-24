//
//  File.swift
//  
//
//  Created by Tho Do on 24/02/2021.
//

import XCTest
import Combine
@testable import CombineURLSessionExtension

class CombineBaseTestCase: XCTestCase {
    var subscription: [AnyCancellable]!

    override func setUpWithError() throws {
        try super.setUpWithError()
        subscription = [AnyCancellable]()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }
}
