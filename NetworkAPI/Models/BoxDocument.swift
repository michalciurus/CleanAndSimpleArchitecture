//  Created by Michal Ciurus

import Foundation

public enum Scope: String, Codable {
    case device
    case user
    case product
}

public struct BoxDocument: Codable {
    
    public var key: String?
    public var value: String?
    public var scope: Scope?
    public var deviceId: String?
    public var productId: Int?
    public var updatedAt: Date?
    
    public init() { }
    
    private enum CodingKeys: String, CodingKey {
        case key
        case value
        case scope
        case deviceId = "device_id"
        case productId = "product_id"
        case updatedAt = "updated_at"
    }
}
