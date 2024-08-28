import Foundation

class Rule {
    var uuid: String
    var ruleID: String
    var key: String
    var path: String?
    var name: String?
    var endpointAddr: String?
    var endpointHost: String?
    var endpointPort: String?
    var pid: NSNumber
    var isGlobal: NSNumber = 0
    var isDirectory: NSNumber = 0
    var type: NSNumber
    var `protocol`: NSNumber
    var action: NSNumber
    var scope: NSNumber
    var csInfo: [String: Any]
    var isEndpointAddrRegex: Bool
    
    init(uuid: String, key: String, path: String?, name: String?, endpointAddr: String?, endpointPort: String?, pid: NSNumber, type: NSNumber, `protocol`: NSNumber, action: NSNumber, scope: NSNumber, csInfo: [String: Any], isEndpointAddrRegex: Bool) {
        self.uuid = uuid
        self.key = key
        self.path = path
        self.name = name
        self.endpointAddr = endpointAddr
        self.endpointPort = endpointPort
        self.pid = pid
        self.type = type
        self.`protocol` = `protocol`
        self.action = action
        self.scope = scope
        self.csInfo = csInfo
        self.isEndpointAddrRegex = isEndpointAddrRegex
        self.ruleID = ""
        self.ruleID = generateID()
    }
    
    private func generateID() -> String {
        return "\(csInfo["signatureIdentifier"] ?? "")-\(endpointAddr ?? "")-\(endpointPort ?? "")-\(type)-\(action)"
    }

    func description() -> String {
        return """
        Rule ID: \(ruleID)
        UUID: \(uuid)
        Key: \(key)
        Path: \(path ?? "N/A")
        Name: \(name ?? "N/A")
        Endpoint Address: \(endpointAddr ?? "N/A")
        Endpoint Port: \(endpointPort ?? "N/A")
        PID: \(pid)
        Type: \(type)
        Protocol: \(`protocol`)
        Action: \(action)
        Scope: \(scope)
        CS Info: \(csInfo)
        Is Endpoint Addr Regex: \(isEndpointAddrRegex)
        """
    }
}
