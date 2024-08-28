import Foundation

class RulesManager {
    private var rules: [String: Rule] = [:]
    
    func addRule(_ rule: Rule) {
        rules[rule.ruleID] = rule
        print("Rule added with ID: \(rule.ruleID)")
    }
    
    func removeRule(byID ruleID: String) -> Rule? {
        return rules.removeValue(forKey: ruleID)
    }
    
    func getRule(byID ruleID: String) -> Rule? {
        return rules[ruleID]
    }
}
