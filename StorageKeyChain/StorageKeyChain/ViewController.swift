//
//  ViewController.swift
//  StorageKeyChain
//
//  Created by Thirawuth on 22/11/2563 BE.
//

import UIKit
import Security

//SecItemAdd
//SecItemCopyMatching
//SecItemUpdate
//SecItemDelete

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        save(item: "polygo")
        read()
//        let result = ref as! NSDictionary
//        print("result")
//        result.forEach { key, value in
//            print("\(key) : \(value)")
//
//        }
    }
    //SecItemAdd
    private func save(item: String) {
        let keychainItemQuery = [
            kSecValueData: item.data(using: .utf8)!,
            kSecAttrAccount: "champy",
            kSecAttrServer: "google.com",
            kSecClass: kSecClassInternetPassword
        ] as CFDictionary
        
//        let keychainItemQuery = [
//            kSecValueData: item.data(using: .utf8)!,
//            kSecAttrAccount: "champ",
//            kSecAttrServer: "apple.com",
//            kSecClass: kSecClassInternetPassword
//        ] as CFDictionary
        
        let status = SecItemAdd(keychainItemQuery, .none)
        print("Operation status :: \(status)")
    }

    
    private func read() {
        let query = [
            kSecClass: kSecClassInternetPassword,
            kSecAttrServer: "google.com",
            kSecReturnData: true,
            kSecReturnAttributes: true
        ] as CFDictionary
        
        var result: AnyObject?
        let status = SecItemCopyMatching(query, &result)
        print("Read Operation Status :: \(status)")
        
        let dic = result as! NSDictionary
        let username = dic[kSecAttrAccount]!
        let passwordData = dic[kSecValueData] as! Data
        let password = String(data: passwordData, encoding: .utf8)!
        
        print("username : \(username) \npassword : \(password)")
    }

}

