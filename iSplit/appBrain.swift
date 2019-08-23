//
//  appBrain.swift
//  iSplit
//
//  Created by Dennis Mo on 5/25/19.
//  Copyright © 2019 Dennis Mo. All rights reserved.
//

import Foundation

class user {
    var name:String
    var balance:Double
    init(name:String){
        self.name = name
        self.balance = 0;
    }
}

class group {
    var groupName:String
    var users = [user]()
    var tranHistory = [transaction]()
    init(name:String,members:[String]){
        groupName = name
        for u in members {
            users.append(user(name: u))
        }
    }
}
struct transaction{
    var tranName:String
    var payTable = [String:Double]()
    var date:Date
    var totalAmount:Double
    init(tranName:String,names:[String],personPaid:String,payRatio:[Double],totalAmount:Double,time:Date){
        
        for i in names.indices {
            let name = names[i]
            let amount = name == personPaid ? totalAmount : 0
//            if (name == personPaid){
//                self.payTable[name] = totalAmount
//            }
//            else{
//                self.payTable[name] = 0
//            }
            self.payTable[name] = amount - payRatio[i] * totalAmount
        }
        self.date = time
        self.tranName = tranName
        self.totalAmount = totalAmount
    }
}

