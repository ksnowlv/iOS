//
//  HashAlgorithms.swift
//  EventTrackerSDK
//
//  Created by ksnowlv on 2024/8/27.
//

import Foundation

import CommonCrypto

@objc public class HashAlgorithms: NSObject {
    
    
     @objc public static func sha256(data: Data) -> String {
        var hash = [UInt8](repeating: 0, count: Int(CC_SHA256_DIGEST_LENGTH))
        data.withUnsafeBytes {
            _ = CC_SHA256($0.baseAddress,CC_LONG(data.count),&hash)
        }
        
        let hashData = Data(hash)
        let hexBytes = hashData.map { String(format: "%02hhx", $0) }
        return hexBytes.joined()
        
    }
    
    @objc public static func sha256(hashString: String) -> String {
        guard let data = hashString.data(using: .utf8) else {
            // 这里根据实际情况决定返回空字符串
            return ""
        }
        
        return HashAlgorithms.sha256(data: data)
    }
    
    @objc public static func md5(string: String) -> String {
        
        guard let data = string.data(using: .utf8)  else { return "" }
        
        var hash = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
        data.withUnsafeBytes {
            _ = CC_MD5($0.baseAddress, CC_LONG(data.count), &hash)
        }
        return hash.map { String(format: "%02x", $0) }.joined()
    }
}
