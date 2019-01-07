//
//  Person.swift
//  KVODemo
//
//  Created by zhy on 2018/9/24.
//  Copyright © 2018 zhy. All rights reserved.
//

import Cocoa

var PersonAccountBalanceContext = 0

class Person: NSObject {

    var account: Account?
    
    override init() {
        super.init()
        account = Account()
        
        printInfo()
        
        registerAsObserverForAccount(account: account)
        printInfo()
        
//        account!.balance = 14.0
//        account?.setValue(14, forKeyPath: "balance")
        account?.setValue(24, forKey: "balance")
        
    }
    
    deinit {
        unregisterAsObserverForAccount(account: account)
    }
    
    func registerAsObserverForAccount(account: Account?) -> Void {
        account?.addObserver(self, forKeyPath: "balance", options: [.new], context: &PersonAccountBalanceContext)
        
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if context == &PersonAccountBalanceContext {
            if let newValue = change?[NSKeyValueChangeKey.newKey]{
                print("balance new value:", newValue)
            }
        }
        else
        {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }
    
    func unregisterAsObserverForAccount(account: Account?) {
        account?.removeObserver(self, forKeyPath: "balance", context: &PersonAccountBalanceContext)
    }
    
    func printInfo() {
        print("isa:", NSStringFromClass(object_getClass(account!)!), ", supper class:", class_getSuperclass(object_getClass(account!)!)!)
    }
}
