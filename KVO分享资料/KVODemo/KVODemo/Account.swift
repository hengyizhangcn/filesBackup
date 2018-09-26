//
//  Account.swift
//  KVODemo
//
//  Created by zhy on 2018/9/24.
//  Copyright © 2018 zhy. All rights reserved.
//

import Cocoa

class Account: NSObject {
    
    @objc dynamic var balance:Double = 0.0
    {
        willSet {
            if newValue > 20 {
                willChangeValue(forKey: "balance")
            }
        }
        didSet {
            didChangeValue(forKey: "balance")
        }
    }
    
    override class func automaticallyNotifiesObservers(forKey key: String) -> Bool
    {
        var automatic = false
        if key == "balance"
        {
            automatic = false
        }
        else {
            automatic = super.automaticallyNotifiesObservers(forKey: key)
        }
        return automatic
    }
    
    func printInfo() {
        print("isa:", NSStringFromClass(object_getClass(self)!), ", supper class:", class_getSuperclass(object_getClass(self)!)!)
    }
}
