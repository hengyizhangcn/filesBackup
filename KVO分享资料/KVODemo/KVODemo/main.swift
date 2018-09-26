//
//  main.swift
//  KVODemo
//
//  Created by zhy on 2018/9/24.
//  Copyright © 2018 zhy. All rights reserved.
//

import Foundation

print("Hello, World!")

let person = Person.init()


var person1 = Person()
person.account?.addObserver(person1, forKeyPath: "balance", options: [.new], context: &PersonAccountBalanceContext)
