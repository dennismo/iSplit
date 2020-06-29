//
//  appBrain.swift
//  iSplit
//
//  Created by Dennis Mo on 5/25/19.
//  Copyright © 2019 Dennis Mo. All rights reserved.
//

import UIKit

func saveBankData() {
    let encoder = JSONEncoder()
    if let encoded = try? encoder.encode(bank) {
        let defaults = UserDefaults.standard
        defaults.set(encoded, forKey: "bank")
    }
}

func loadBankData() {
    if let savedBank = UserDefaults.standard.object(forKey: "bank") as? Data {
        let decoder = JSONDecoder()
        bank = try! decoder.decode(CentralBank.self, from: savedBank)
    }
}

class User : Codable{
    
    var name: String
    var balance: Double
    var id: Int
    init(name: String,id: Int){
        self.name = name
        self.balance = 0.0
        self.id = id
    }
}

class Group: Codable{
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
//        tranHistory = aDecoder.decodeObject(forKey: "tranHistory") as! [Transaction]
//    }
    
    var groupName: String
    //var groupImage: UIImage?
    var users = [User]()
    var tranHistory = [Transaction]()
    init(){
        groupName = ""
        users = []
    }
    
    init(name: String,members: [String]){
        groupName = name
        for i in 0...members.count - 1 {
            users.append(User(name: members[i],id: i))
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
struct Transaction: Codable{
    var tranName: String
    var payTable = [Double]()
    var date: Date
    var percent: Bool
    var comments: String
    var totalAmount: Double
    init(){
        tranName = ""
        date = Date()
        totalAmount = 0
        percent = true
        comments = ""
    }
    init(tranName: String,date: Date){
        self.tranName = tranName
        self.date = date
        self.totalAmount = 0.0
        self.percent = true
        self.payTable = []
        self.comments = ""
    }
}

class CentralBank: Codable{
    
    var groups: [Group]
    var currGroup: Group?
    func newTransaction(trans: Transaction){
        currGroup?.tranHistory.insert(trans, at: 0)
        for i in 0...currGroup!.users.count - 1{
            currGroup!.users[i].balance += trans.payTable[i] * trans.totalAmount
        }
    }
    func removeTransaction(index: Int){
        let trans = currGroup!.tranHistory[index]
        for i in 0...currGroup!.users.count - 1 {
            currGroup!.users[i].balance -= trans.payTable[i] * trans.totalAmount
        }
        currGroup?.tranHistory.remove(at: index)
    }
    var pendingTransaction: Transaction = Transaction()
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

