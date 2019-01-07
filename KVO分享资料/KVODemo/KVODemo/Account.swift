//
//  Account.swift
//  KVODemo
//
//  Created by zhy on 2018/9/24.
//  Copyright © 2018 zhy. All rights reserved.
//

import Cocoa

class Account: NSObject {
    
    //swift本身屏幕了运行时机制 ，加上dynamic关键字获取动态性
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
//        if key == "balance"
//        {
//            automatic = false
//        }
//        else {
            automatic = super.automaticallyNotifiesObservers(forKey: key)
//        }
        return automatic
    }
}
