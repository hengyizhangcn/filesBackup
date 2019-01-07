//
//  main.swift
//  KVODemo
//
//  Created by zhy on 2018/9/24.
//  Copyright © 2018 zhy. All rights reserved.
//

import Foundation

let person = Person.init()

//isKnownUniquelyReferenced

final class Box<A> {
    var unbox: A
    init(_ value: A) { self.unbox = value }
}
var z = Box(NSMutableData())

isKnownUniquelyReferenced(&z)

//var person1 = Person()
//person.account?.addObserver(person1, forKeyPath: "balance", options: [.new], context: &PersonAccountBalanceContext)
