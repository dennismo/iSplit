//
//  ViewController.swift
//  iSplit
//
//  Created by Dennis Mo on 5/25/19.
//  Copyright © 2019 Dennis Mo. All rights reserved.
//

import UIKit

var bank = centralBank()

class tableCell :UITableViewCell{
    @IBOutlet weak var transName: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var amount: UILabel!
    func setTransaction(trans:transaction){
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if (bank.currGroup == nil){
            currentGroup.text = "Select a Group First"
        }
        else{
            currentGroup.text = "Current Group: " + bank.currGroup!.groupName
        }
            
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let addStoryBoard = UIStoryboard(name:"Add View Controller", bundle: Bundle.main)
//        guard addStoryBoard.instantiateViewController(withIdentifier:  "addViewController") is addViewController else {
//            return
//        }
        //bank = UserDefaults.standard.object(forKey: "bank") as? centralBank ?? centralBank()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func createTrans()->[transaction]{
        var tempTrans = [transaction]()
        
//        let t1 = transaction(tranName: "tran1", names: ["Dennis","Stellar","Maxwell"], personPaid: "Dennis", payRatio: [0.333,0.333,0.333], totalAmount: 100, time:Date.init(timeIntervalSinceNow: 0))
//        let t2 = transaction(tranName: "Food Basics", names: ["Dennis","Stellar","Maxwell"], personPaid: "Stellar", payRatio: [0.2,0.4,0.4], totalAmount: 50, time:Date.init(timeIntervalSinceNow: 100))
//        let t3 = transaction(tranName: "Lunch", names: ["Dennis","Stellar","Maxwell"], personPaid: "Maxwell", payRatio: [0.1,0.9,0], totalAmount: 25, time: Date.init(timeIntervalSinceNow: 1000))
//        tempTrans.append(t1)
//        tempTrans.append(t2)
//        tempTrans.append(t3)
        return tempTrans
    }
    
    @IBAction func groups(_ sender: UIButton) {
        let GroupsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "groupsViewController") as! groupsViewController
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

extension ViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bank.currGroup?.tranHistory.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let t = bank.currGroup?.tranHistory[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "transaction") as! tableCell
        if ((t) != nil){
            cell.setTransaction(trans: t!)
        }
        return cell
    }
}
