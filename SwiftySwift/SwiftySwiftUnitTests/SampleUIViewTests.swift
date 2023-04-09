//
//  SwiftySwiftUnitTests.swift
//  SwiftySwiftUnitTests
//
//  Created by Amit on 2023-04-08.
//

import SwiftUI
import ViewInspector
@testable import SwiftySwift
import XCTest

final class SampleUIViewTests: XCTestCase {

    fileprivate var viewModel: SampleUIView.ViewModel?
    var contentView: SampleUIView?

    override func setUpWithError() throws {
        continueAfterFailure = true
    }

    override func tearDownWithError() throws {
    }

    override func setUp() {
        super.setUp()
        self.viewModel = SampleUIView.ViewModel()
        self.contentView = SampleUIView()
    }

    override func tearDown() {
        self.viewModel = nil
        self.contentView = nil
        super.tearDown()
    }

//    func testViewInspectorBaseline() throws {
//        let expected = "it lives!"
//        let sut = Text(expected)  // sut = System Under Test
//        let value = try sut.inspect().text().string()
//        XCTAssertEqual(value, expected)
//    }

    func testInitialTitle() throws {
        let text = try self.contentView.inspect()
            .find(text: "Hello World!")

        let font = try text.attributes().font()
        XCTAssertEqual(font, Font.title)
    }

    func testWelcomeTitle() throws {
        self.viewModel?.style = .welcome
        self.contentView = SampleUIView(viewModel: self.viewModel!)

        _ = try self.contentView.inspect().find(text: "Welcome World!")

        self.viewModel?.style = .hello
        _ = try self.contentView.inspect().find(text: "Hello World!")
    }
}
