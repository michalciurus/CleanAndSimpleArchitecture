//  Created by Michal Ciurus

import Foundation

fileprivate enum KeychainAccessConstants {
    static let service = "com.box"
    static let tokenAccount = "CurrentToken"
}

final public class KeychainAccess {
    
    fileprivate typealias C = KeychainAccessConstants
    
    public static func save(accessToken: String) {
        if let dataFromString = accessToken.data(using: String.Encoding.utf8, allowLossyConversion: false) {
            
            let query: NSMutableDictionary = NSMutableDictionary(objects: [kSecClassGenericPassword, C.service, C.tokenAccount, dataFromString], forKeys: [NSString(format: kSecClass), kSecAttrService, kSecAttrAccount, kSecValueData])
            
            SecItemAdd(query as CFDictionary, nil)
        }
    }
    
    public static func loadAccessToken() -> String? {
       
        let query: NSMutableDictionary = NSMutableDictionary(objects: [kSecClassGenericPassword, C.service, C.tokenAccount, kCFBooleanTrue, kSecMatchLimitOne], forKeys: [NSString(format: kSecClass), kSecAttrService, kSecAttrAccount, kSecReturnData, kSecMatchLimit])
        
        var dataTypeRef: AnyObject?
        
        SecItemCopyMatching(query, &dataTypeRef)
        
        if let data = dataTypeRef as? Data {
             return String(data: data, encoding: String.Encoding.utf8)
        }
        
        return nil
    }
    
}
