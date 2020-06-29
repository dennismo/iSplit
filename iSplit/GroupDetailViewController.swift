//
//  groupDetailViewController.swift
//  iSplit
//
//  Created by Dennis Mo on 8/28/19.
//  Copyright © 2019 Dennis Mo. All rights reserved.
//

import UIKit

class UsertableCell : UITableViewCell{


    @IBOutlet weak var memberName: UILabel!
    @IBOutlet weak var balance: UILabel!
    var user: User?
    func setuserTable(u: User){
        user = u
        memberName.text = u.name
        if(u.balance >= 0){
            balance.textColor = UIColor.green
        }else{
            balance.textColor = UIColor.red
        }
        balance.text = "Balance: $" + String(format: "%.2f", u.balance)
    }
    
}

class GroupDetailViewController: UIViewController {

    
    @IBOutlet weak var gName: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func doneButton(_ sender: UIButton) {
    self.navigationController?.popViewController(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        gName.text = bank.currGroup?.groupName
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
}
extension GroupDetailViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bank.currGroup?.users.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let g = (bank.currGroup?.users[indexPath.row])!
        let cell = tableView.dequeueReusableCell(withIdentifier: "groupDetail") as! UsertableCell
        cell.setuserTable(u: g)
        return cell
    }
}
