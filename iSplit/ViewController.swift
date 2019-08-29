//
//  ViewController.swift
//  iSplit
//
//  Created by Dennis Mo on 5/25/19.
//  Copyright © 2019 Dennis Mo. All rights reserved.
//

import UIKit

var bank = CentralBank()

class tableCell: UITableViewCell {
    @IBOutlet weak var transName: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var amount: UILabel!
    func setTransaction(trans: Transaction) {
        transName.text = trans.tranName
        date.text = trans.date.description
        amount.text = "$" + trans.totalAmount.description
    }
}

class ViewController: UIViewController {

//    lazy var scene = StartScene(size: view.bounds.size)
//    var groups = [group]()

    @IBOutlet weak var tableView: UITableView!

    @IBOutlet weak var currentGroup: UILabel!
    @IBAction func addItem(_ sender: UIButton) {

    }

    @IBAction func showBalance(_ sender: UIButton) {
        let balanceVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "groupDetail") as! groupDetailViewController
        self.navigationController?.pushViewController(balanceVC, animated: true)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if (bank.currGroup == nil) {
            currentGroup.text = "Select a Group First"
        } else {
            currentGroup.text = "Current Group: " + bank.currGroup!.groupName
        }
        tableView.reloadData()

    }
    override func viewDidLoad() {
        super.viewDidLoad()

//        let addStoryBoard = UIStoryboard(name:"Add View Controller", bundle: Bundle.main)
//        guard addStoryBoard.instantiateViewController(withIdentifier:  "addViewController") is addViewController else {
//            return
//        }
        //bank = UserDefaults.standard.object(forKey: "bank") as? centralBank ?? centralBank()
        bank.groups.append(Group(name: "Group", members: ["Dennis", "Bill", "Yifei", "Timmy"]))
        bank.currGroup = bank.groups[0]
        var tempTrans = Transaction()
        tempTrans.date = Date.init(timeIntervalSince1970: 500)
        tempTrans.tranName = "TestTransaction"
        tempTrans.totalAmount = 30.5
        tempTrans.payTable = [1, -0.3, -0.2, -0.4]
        bank.newTransaction(trans: tempTrans)
        tableView.dataSource = self
        tableView.delegate = self
    }

    @IBAction func groups(_ sender: UIButton) {
        let GroupsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "groupsViewController") as! GroupsViewController
        self.navigationController?.pushViewController(GroupsVC, animated: true)
    }

    @IBOutlet weak var purchases: UITableView!

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return false
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bank.currGroup?.tranHistory.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let t = bank.currGroup?.tranHistory[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "transaction") as! tableCell
        if ((t) != nil) {
            cell.setTransaction(trans: t!)
        }
        return cell
    }
}
