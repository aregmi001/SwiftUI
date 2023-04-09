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

final class SwiftySwiftUnitTests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = true
    }

    override func tearDownWithError() throws {
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

    func testViewInspectorBaseline() throws {
        let expected = "it lives!"
        let sut = Text(expected)  // sut = System Under Test
        let value = try sut.inspect().text().string()
        XCTAssertEqual(value, expected)
    }

    func testInitialTitle() throws {
        let contentView = SampleUIView()

        let text = try contentView.inspect()
            .find(text: "Hello World!")

        let font = try text.attributes().font()
        XCTAssertEqual(font, Font.title)
    }

    func testWelcomeTitle() throws {
        let viewModel = SampleUIView.ViewModel()
        viewModel.style = .welcome
        let contentView = SampleUIView(viewModel: viewModel)

        _ = try contentView.inspect().find(text: "Welcome World!")
    }
}
