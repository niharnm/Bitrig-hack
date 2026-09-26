//
//  MonetizationTests.swift
//  DuoAppTests
//
//  OWNER: LANE-RC · Comprehensive validation of RevenueCat identifiers,
//  EntitlementState status machine, and offer error modeling.
//

import XCTest
@testable import DuoApp

final class MonetizationTests: XCTestCase {

  func testRCIdentifiersContract() {
    // TC-R01 & TC-R06: Verify real Test Store key and lowercase entitlement "pro"
    XCTAssertTrue(RCIdentifiers.apiKey.hasPrefix("test_"), "API key must use test_ prefix for Test Store")
    XCTAssertFalse(RCIdentifiers.apiKey.contains("PLACEHOLDER"), "Must have zero PLACEHOLDER tokens in API key")
    XCTAssertEqual(RCIdentifiers.entitlementId, "pro", "Entitlement must be strictly 'pro' (case-sensitive)")
    XCTAssertFalse(RCIdentifiers.offeringId.contains("PLACEHOLDER"), "Offering ID must be populated")
    XCTAssertFalse(RCIdentifiers.packageId.contains("PLACEHOLDER"), "Package ID must be populated")
    XCTAssertFalse(RCIdentifiers.productId.contains("PLACEHOLDER"), "Product ID must be populated")
  }

  func testEntitlementStateStatusMachine() {
    // TC-R03 / TC-R05: Status machine state mapping to isPro
    let unknownState = EntitlementState(status: .unknown, entitlementID: "pro")
    XCTAssertFalse(unknownState.isPro, "Unknown status must not grant Pro")

    let loadingState = EntitlementState(status: .loading, entitlementID: "pro")
    XCTAssertFalse(loadingState.isPro, "Loading status must not grant Pro")

    let inactiveState = EntitlementState(status: .inactive, entitlementID: "pro")
    XCTAssertFalse(inactiveState.isPro, "Inactive status must not grant Pro")

    let errorState = EntitlementState(status: .error, entitlementID: "pro", lastError: "Network failure")
    XCTAssertFalse(errorState.isPro, "Error status must not grant Pro")
    XCTAssertEqual(errorState.lastError, "Network failure")

    let activeState = EntitlementState(status: .active, entitlementID: "pro")
    XCTAssertTrue(activeState.isPro, "Active status must grant Pro")
  }

  @MainActor
  func testEntitlementsModelInitialState() {
    let model = EntitlementsModel.shared
    XCTAssertEqual(model.state.entitlementID, "pro")
  }

  func testOfferingsErrorCases() {
    let err = OfferingsError.currentNil
    XCTAssertEqual(err, OfferingsError.currentNil)
  }

  func testPurchaseOutcomeCases() {
    let success = PurchaseOutcome.purchased
    let cancel = PurchaseOutcome.cancelled
    let fail = PurchaseOutcome.failed("declined")

    switch success {
    case .purchased: break
    default: XCTFail("Expected purchased")
    }

    switch cancel {
    case .cancelled: break
    default: XCTFail("Expected cancelled")
    }

    switch fail {
    case .failed(let reason): XCTAssertEqual(reason, "declined")
    default: XCTFail("Expected failed")
    }
  }
}
