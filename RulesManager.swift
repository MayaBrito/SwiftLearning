import Foundation

class RulesManager {
    private var rules: [String: Rule] = [:]
    
    func addRule(_ rule: Rule) {
        rules[rule.ruleID] = rule
        print("Rule added with ID: \(rule.ruleID)")
    }
    
    func removeRule(byID ruleID: String) {
        if let removedRule = rules.removeValue(forKey: ruleID) {
            print("Rule removed with ID: \(removedRule.ruleID)")
        } else {
            print("No rule found with ID: \(ruleID)")
        }
    }
    
    func getRule(byID ruleID: String) -> Rule? {
        return rules[ruleID]
    }
}
