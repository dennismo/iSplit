//
//  appBrain.swift
//  iSplit
//
//  Created by Dennis Mo on 5/25/19.
//  Copyright © 2019 Dennis Mo. All rights reserved.
//

import UIKit

class User {
    var name: String
    var balance: Double
    init(name: String) {
        self.name = name
        self.balance = 0
    }
}

class Group {
    var groupName: String
    var groupImage: UIImage?
    var users = [User]()
    var tranHistory = [Transaction]()
    init(name: String, members: [String]) {
        groupName = name
        for u in members {
            users.append(User(name: u))
        }
    }
    func getMembers() -> String {
        var temp: String = ""
        for u in users {
            temp.append(u.name)
            temp.append(" ")
        }
        return temp
    }
}

struct Transaction {
    var tranName: String
    var payTable = [Double]()
    var date: Date
    var totalAmount: Double
    init() {
        tranName = ""
        date = Date()
        totalAmount = 0
    }
}

class CentralBank: NSCoding {

    var groups: [Group]
    var currGroup: Group?
    func newTransaction(trans: Transaction) {
        currGroup?.tranHistory.insert(trans, at: 0)
        for i in 0...currGroup!.users.count - 1{
            currGroup!.users[i].balance += trans.payTable[i]*trans.totalAmount
        }
    }

    init() {
        groups = []
    }

    func encode(with aCoder: NSCoder) {

    }

    required init?(coder aDecoder: NSCoder) {
        groups = []
    }
}
