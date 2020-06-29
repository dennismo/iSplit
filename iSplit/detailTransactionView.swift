//
//  detailTransactionView.swift
//  iSplit
//
//  Created by Dennis Mo on 9/15/19.
//  Copyright © 2019 Dennis Mo. All rights reserved.
//

import UIKit

class memberBalance: UITableViewCell{
    
    @IBOutlet weak var memberName: UILabel!
    @IBOutlet weak var balance: UILabel!
    func setUserTable(u: User){
        memberName.text = u.name
        balance.text = "$" + String(u.balance)
        if u.balance >= 0 {
            balance.textColor = UIColor.green
        }
        else{
            balance.textColor = UIColor.red
        }
    }
}

class DetailTransactionViewController: UIViewController{
    public var trans = Transaction()
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var transName: UILabel!
    @IBAction func doneButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var transComments: UITextView!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var totalAmount: UILabel!
    @IBOutlet weak var receiptImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        transName.text = "Transaction: " + trans.tranName
        transComments.text = trans.comments
        date.text = "Date: " + trans.date.description
        totalAmount.text = "Total Amount: $" + String(trans.totalAmount)
        receiptImage.image = UIImage()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
}
extension DetailTransactionViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bank.currGroup?.users.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let g = (bank.currGroup?.users[indexPath.row])!
        let cell = tableView.dequeueReusableCell(withIdentifier: "memberBalance") as! memberBalance
        cell.setUserTable(u: g)
        return cell
    }
}
