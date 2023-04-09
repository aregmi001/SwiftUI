//
//  BetterRestTests.swift
//  SwiftySwiftUITests
//
//  Created by Amit on 2023-04-08.
//

import XCTest

final class BetterRestUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = true
    }

    override func tearDownWithError() throws {
    }

    func testBetterRestCalculate() throws {
        let app = XCUIApplication()
        app.launch()

        /* check all UI components exist */

        let timeout = TimeInterval(2)
        let desiredSleepStepper = app.steppers["desiredSleepStepper"]
        let desiredSleepStepperIncButton = desiredSleepStepper.buttons["desiredSleepStepper-Increment"]
        let desiredSleepStepperDecButton = desiredSleepStepper.buttons["desiredSleepStepper-Decrement"]

        let coffeeIntakeStepper = app.steppers["coffeeIntakeStepper"]
        let coffeeIntakeStepperIncBtn = coffeeIntakeStepper.buttons["coffeeIntakeStepper-Increment"]
        let coffeeIntakeStepperDecBtn = coffeeIntakeStepper.buttons["coffeeIntakeStepper-Decrement"]

        let calculateButton = app.buttons["calculateButton"]

        XCTAssertTrue(desiredSleepStepper.waitForExistence(timeout: timeout))
        XCTAssertTrue(desiredSleepStepperIncButton.waitForExistence(timeout: timeout))
        XCTAssertTrue(desiredSleepStepperDecButton.waitForExistence(timeout: timeout))

        XCTAssertTrue(coffeeIntakeStepper.waitForExistence(timeout: timeout))
        XCTAssertTrue(coffeeIntakeStepperIncBtn.waitForExistence(timeout: timeout))
        XCTAssertTrue(coffeeIntakeStepperDecBtn.waitForExistence(timeout: timeout))

        XCTAssertTrue(calculateButton.waitForExistence(timeout: timeout))
        XCTAssertTrue(calculateButton.isEnabled)

        calculateButton.tap()

    }
}
