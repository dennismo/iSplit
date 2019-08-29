//
//  groupDetailViewController.swift
//  iSplit
//
//  Created by Dennis Mo on 8/28/19.
//  Copyright © 2019 Dennis Mo. All rights reserved.
//

import UIKit

class usertableCell: UITableViewCell {

    @IBOutlet weak var memberName: UILabel!
    @IBOutlet weak var balance: UILabel!
    var user: User?
    func setuserTable(u: User) {
        user = u
        memberName.text = u.name
        if(u.balance >= 0) {
            balance.textColor = UIColor.green
        } else {
            balance.textColor = UIColor.red
        }
        balance.text = "Balance: $" + String(format: "%.2f", u.balance)
    }

}

class groupDetailViewController: UIViewController {

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

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }
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
extension groupDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bank.currGroup?.users.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let g = (bank.currGroup?.users[indexPath.row])!
        let cell = tableView.dequeueReusableCell(withIdentifier: "groupDetail") as! usertableCell
        cell.setuserTable(u: g)
        return cell
    }
}
