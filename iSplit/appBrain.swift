//
//  appBrain.swift
//  iSplit
//
//  Created by Dennis Mo on 5/25/19.
//  Copyright © 2019 Dennis Mo. All rights reserved.
//

import UIKit

class user :Codable{
//    func encode(with aCoder: NSCoder) {
//        aCoder.encode(name,forKey: "name")
//        aCoder.encode(balance,forKey:"balance")
//    }
//    
//    required convenience init?(coder aDecoder: NSCoder) {
//        self.init(name: "")
//        self.name = aDecoder.decodeObject(forKey: "name") as! String
//        self.balance = aDecoder.decodeDouble(forKey: "balance")
//    }
    
    var name:String
    var balance:Double
    var id:Int
    init(name:String,id:Int){
        self.name = name
        self.balance = 0.0
        self.id = id
    }
}

class group:Codable{
//    func encode(with aCoder: NSCoder) {
//        aCoder.encode(groupName,forKey: "groupName")
//        aCoder.encode(users,forKey: "users")
//        aCoder.encode(tranHistory,forKey: "transHistory")
//    }
//
//    required convenience init?(coder aDecoder: NSCoder) {
//        self.init()
//        groupName = aDecoder.decodeObject(forKey: "groupName") as! String
//        users = aDecoder.decodeObject(forKey: "users") as! [user]
//        tranHistory = aDecoder.decodeObject(forKey: "tranHistory") as! [transaction]
//    }
    
    var groupName:String
    //var groupImage:UIImage?
    var users = [user]()
    var tranHistory = [transaction]()
    init(){
        groupName = ""
        users = []
    }
    
    init(name:String,members:[String]){
        groupName = name
        for i in 0...members.count - 1 {
            users.append(user(name: members[i],id: i))
        }
    }
    func getMembers()->String{
        var temp: String = ""
        for u in users {
            temp.append(u.name)
            temp.append(" ")
        }
        return temp
    }
    
}
struct transaction:Codable{
    var tranName: String
    var payTable = [Double]()
    var date: Date
    var percent: Bool
    var totalAmount: Double
    init(){
        tranName = ""
        date = Date()
        totalAmount = 0
        percent = true
    }
    init(tranName:String,date: Date){
        self.tranName = tranName
        self.date = date
        self.totalAmount = 0.0
        self.percent = true
        self.payTable = []
    }
}

class centralBank:Codable{
    
    var groups:[group]
    var currGroup:group?
    func newTransaction(trans:transaction){
        currGroup?.tranHistory.insert(trans, at: 0)
        for i in 0...currGroup!.users.count - 1{
            currGroup!.users[i].balance += trans.payTable[i]*trans.totalAmount
        }
    }
    var pendingTransaction:transaction = transaction()
    init(){
        groups = []
    }
//    func encode(with aCoder: NSCoder) {
//        aCoder.encode(groups,forKey: "groups")
//        aCoder.encode(currGroup,forKey: "currGroup")
//    }
//
//    required convenience init(coder aDecoder: NSCoder) {
//        self.init()
//        self.groups = aDecoder.decodeObject(forKey: "groups") as! [group]? ?? []
//        self.currGroup = aDecoder.decodeObject(forKey: "currGroup") as! group? ?? group()
//    }
}

