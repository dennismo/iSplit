//
//  HomeViewController.swift
//  iSplit
//
//  Created by Dennis Mo on 5/25/19.
//  Copyright © 2019 Dennis Mo. All rights reserved.
//

import UIKit

var bank = CentralBank()

class tableCell: UITableViewCell{
    @IBOutlet weak var transName: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var amount: UILabel!
    @IBAction func transInfo(_ sender: UIButton) {
        let transVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "detailTrans") as! DetailTransactionViewController
        transVC.trans = self.trans
        if parent != nil {
            parent!.present(transVC, animated: true, completion: nil)
        }
    }
    var parent: UIViewController?
    var trans = Transaction()
    func setTransaction(trans: Transaction,parentVC: UIViewController){
        self.parent = parentVC
        self.trans = trans
        transName.text = trans.tranName
        date.text = trans.date.description
        amount.text = "$" + trans.totalAmount.description
    }
}


class HomeViewController: UIViewController {
    
//    lazy var scene = StartScene(size: view.bounds.size)
//    var groups = [Group]()
    
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
            let addVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "addTrans") as! AddViewController
            self.navigationController?.pushViewController(addVC, animated: true)
        }
    }
    
    
    @IBAction func showBalance(_ sender: UIButton) {
        let balanceVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "groupDetail") as! GroupDetailViewController
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
        self.navigationController?.isNavigationBarHidden = true
        
//        let addStoryBoard = UIStoryboard(name:"Add View Controller", bundle: Bundle.main)
//        guard addStoryBoard.instantiateViewController(withIdentifier:  "addViewController") is addViewController else {
//            return
//        }
        //bank = UserDefaults.standard.object(forKey: "bank") as? centralBank ?? centralBank()
        loadBankData()
//        bank.groups.append(Group(name: "Group", members:["Dennis","Bill","Yifei","Timmy"]))
//        bank.currGroup = bank.groups[0]
//        var tempTrans = Transaction()
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
        let groupsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "groupsViewController") as! GroupsViewController
        self.navigationController?.pushViewController(groupsVC, animated: true)
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

    override func becomeFirstResponder() -> Bool {
        return true
    }

    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            saveBankData()
            let alert = UIAlertController(title: "Good News", message: "Data has been saved.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Got it!", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}

extension HomeViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bank.currGroup?.tranHistory.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let t = bank.currGroup?.tranHistory[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "transaction") as! tableCell
        if ((t) != nil){
            cell.setTransaction(trans: t!,parentVC: self)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            bank.removeTransaction(index: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
}
