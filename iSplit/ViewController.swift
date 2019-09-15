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
        if(bank.currGroup == nil){
            let alert = UIAlertController(title: "No Group Selected", message: "", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Select", style: .default, handler: { (alert) -> Void in
                self.presentGroup()
            }))
            alert.addAction(UIAlertAction(title: "FINE", style: .cancel, handler: nil))
            
            self.present(alert, animated: true)
        }
        else{
            let addVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "addTrans") as! addViewController
            present(addVC, animated: true, completion: nil)
        }
    }
    
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
            bank = try! decoder.decode(centralBank.self, from: savedBank)
        }
    }
    
    @IBAction func showBalance(_ sender: UIButton) {
        let balanceVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "groupDetail") as! groupDetailViewController
        self.navigationController?.pushViewController(balanceVC, animated: true)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if (bank.currGroup == nil){
            currentGroup.text = "Select a Group First"
        }
        else{
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
        loadBankData()
//        bank.groups.append(group(name: "Group", members:["Dennis","Bill","Yifei","Timmy"]))
//        bank.currGroup = bank.groups[0]
//        var tempTrans = transaction()
//        tempTrans.date = Date.init(timeIntervalSince1970: 500)
//        tempTrans.tranName = "TestTransaction"
//        tempTrans.totalAmount = 30.5
//        tempTrans.payTable = [1,-0.3,-0.2,-0.4]
//        bank.newTransaction(trans: tempTrans)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    
    @IBAction func groups(_ sender: UIButton) {
        presentGroup()
    }
    func presentGroup(){
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
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            bank.currGroup?.tranHistory.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
}
