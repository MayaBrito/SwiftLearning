import XCTest
@testable import SwiftLearning

class RulesManagerTests: XCTestCase {

    var manager: RulesManager!

    override func setUp() {
        super.setUp()
        manager = RulesManager()
    }

    override func tearDown() {
        manager = nil
        super.tearDown()
    }

    // Test case 1: Add a rule and retrieve it
    func testAddAndRetrieveRule() {
        let csInfo1: [String: Any] = [
            "signatureIdentifier": "com.apple.dt.Xcode",
            "signatureStatus": "0",
            "signatureSigner": "2",
            "signatureAuthorities": [
                "Apple Mac OS Application Signing",
                "Apple Worldwide Developer Relations Certification Authority",
                "Apple Root CA"
            ]
        ]

        let rule1 = Rule(
            uuid: "A434FBF5-A0D9-4040-BEF1-285D353C7CC5",
            key: "com.apple.dt.Xcode",
            path: "/Applications/Xcode.app",
            name: "Xcode",
            endpointAddr: "10.456.65.2",
            endpointPort: "*",
            pid: 0,
            type: 2,
            protocol: 1,
            action: 1,
            scope: 0,
            csInfo: csInfo1,
            isEndpointAddrRegex: false
        )

        manager.addRule(rule1)
        let fetchedRule1 = manager.getRule(byID: rule1.ruleID)
        XCTAssertNotNil(fetchedRule1, "Rule should be retrieved")
        XCTAssertEqual(fetchedRule1?.key, "com.apple.dt.Xcode", "The key should match")
    }

    // Test case 2: Add another rule with different attributes
    func testAddAnotherRule() {
        let csInfo2: [String: Any] = [
            "signatureIdentifier": "com.apple.dt.CodeRunner",
            "signatureStatus": "0",
            "signatureSigner": "2",
            "signatureAuthorities": [
                "Apple Mac OS Application Signing",
                "Apple Worldwide Developer Relations Certification Authority",
                "Apple Root CA"
            ]
        ]

        let rule2 = Rule(
            uuid: "B634FBF5-A0D9-4040-BEF1-285D353C7CC6",
            key: "com.apple.dt.CodeRunner",
            path: "/Applications/CodeRunner.app",
            name: "CodeRunner",
            endpointAddr: "192.168.1.1",
            endpointPort: "8080",
            pid: 12345,
            type: 3,
            protocol: 2,
            action: 0,
            scope: 1,
            csInfo: csInfo2,
            isEndpointAddrRegex: true
        )

        manager.addRule(rule2)
        let fetchedRule2 = manager.getRule(byID: rule2.ruleID)
        XCTAssertNotNil(fetchedRule2, "Rule should be retrieved")
        XCTAssertEqual(fetchedRule2?.key, "com.apple.dt.CodeRunner", "The key should match")
    }

    // Test case 3: Attempt to retrieve a rule that doesn't exist
    func testRetrieveNonExistentRule() {
        let nonExistentRuleID = "non-existent-id"
        let fetchedRule = manager.getRule(byID: nonExistentRuleID)
        XCTAssertNil(fetchedRule, "No rule should be found with a non-existent ID")
    }

    // Test case 4: Remove an existing rule
    func testRemoveExistingRule() {
        let ruleID = "A434FBF5-A0D9-4040-BEF1-285D353C7CC5"
        manager.removeRule(byID: ruleID)
        let fetchedRule = manager.getRule(byID: ruleID)
        XCTAssertNil(fetchedRule, "Rule should be nil after removal")
    }

    // Test case 5: Try to remove a rule that has already been removed
    func testRemoveAlreadyRemovedRule() {
        let ruleID = "A434FBF5-A0D9-4040-BEF1-285D353C7CC5"
        manager.removeRule(byID: ruleID)
        let fetchedRule = manager.getRule(byID: ruleID)
        XCTAssertNil(fetchedRule, "Rule should remain nil after repeated removal attempts")
    }

    // Test case 6: Add another rule, retrieve it, print its description, and remove it
    func testAddRetrieveAndRemoveRule() {
        let csInfo1: [String: Any] = [
            "signatureIdentifier": "com.apple.dt.Xcode",
            "signatureStatus": "0",
            "signatureSigner": "2",
            "signatureAuthorities": [
                "Apple Mac OS Application Signing",
                "Apple Worldwide Developer Relations Certification Authority",
                "Apple Root CA"
            ]
        ]

        let rule1 = Rule(
            uuid: "A434FBF5-A0D9-4040-BEF1-285D353C7CC5",
            key: "com.apple.dt.Xcode",
            path: "/Applications/Xcode.app",
            name: "Xcode",
            endpointAddr: "10.456.65.2",
            endpointPort: "*",
            pid: 0,
            type: 2,
            protocol: 1,
            action: 1,
            scope: 0,
            csInfo: csInfo1,
            isEndpointAddrRegex: false
        )

        manager.addRule(rule1)
        
        if let fetchedRule1 = manager.getRule(byID: rule1.ruleID) {
            print("Test 6 - Rule Description:\n\(fetchedRule1.description())")
        }
        
        manager.removeRule(byID: rule1.ruleID)
        let fetchedRuleAfterRemoval = manager.getRule(byID: rule1.ruleID)
        XCTAssertNil(fetchedRuleAfterRemoval, "Rule should not be found after removal")
    }
}
