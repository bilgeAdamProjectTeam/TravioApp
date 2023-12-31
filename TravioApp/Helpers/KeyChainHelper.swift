//
//  KeyChainHelper.swift
//  TravioApp
//
//  Created by Şevval Çakıroğlu on 28.08.2023.
//

import Foundation


final class KeychainHelper {
    
    static let standard = KeychainHelper()
    private init() {}
    
    func save(_ data: Data, service: String, account: String) {
        
        
        // Create query
        let query = [
            kSecValueData: data,
            kSecAttrService: service,
            kSecAttrAccount: account,
            kSecClass: kSecClassGenericPassword
        ] as CFDictionary
        
        
        let status = SecItemAdd(query, nil)
        
        if status == errSecDuplicateItem {
            // Item already exist, thus update it.
            let query = [
                kSecAttrService: service,
                kSecAttrAccount: account,
                kSecClass: kSecClassGenericPassword,
            ] as CFDictionary
            
            let attributesToUpdate = [kSecValueData: data] as CFDictionary
            
            SecItemUpdate(query, attributesToUpdate)
        }
    }
    
    func read(service: String, account: String) -> Data? {
        
        let query = [
            kSecAttrService: service,
            kSecAttrAccount: account,
            kSecClass: kSecClassGenericPassword,
            kSecReturnData: true
        ] as CFDictionary
        
        var result: AnyObject?
        SecItemCopyMatching(query, &result)
        
        return (result as? Data)
    }
    
    
    func delete(_ service:String, account:String){
        
        let query = [
            kSecAttrService: service,
            kSecAttrAccount: account,
            kSecClass: kSecClassGenericPassword,
            ] as CFDictionary
        
        // Delete item from keychain
        SecItemDelete(query)
    }
 
    func getAllKeyChainItemsOfClass(_ secClass: String) -> [String:String] {

        let query: [String: Any] = [
            kSecClass as String : secClass,
            kSecReturnData as String  : kCFBooleanTrue,
            kSecReturnAttributes as String : kCFBooleanTrue,
            kSecReturnRef as String : kCFBooleanTrue,
            kSecMatchLimit as String : kSecMatchLimitAll
        ]

        var result: AnyObject?

        let lastResultCode = withUnsafeMutablePointer(to: &result) {
            SecItemCopyMatching(query as CFDictionary, UnsafeMutablePointer($0))
        }

        var values = [String:String]()
        if lastResultCode == noErr {
            let array = result as? Array<Dictionary<String, Any>>

            for item in array! {
                if let key = item[kSecAttrAccount as String] as? String,
                    let value = item[kSecValueData as String] as? Data {
                    values[key] = String(data: value, encoding:.utf8)
                }
            }
        }

        return values
    }
    
}
