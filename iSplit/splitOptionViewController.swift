//
//  splitOptionViewController.swift
//  iSplit
//
//  Created by Dennis Mo on 9/5/19.
//  Copyright © 2019 Dennis Mo. All rights reserved.
//

import UIKit

class SplitOptionCell:UITableViewCell{

    @IBOutlet weak var memberName: UILabel!
    
    @IBAction func splitRatio(_ sender: UITextField) {
        if user != nil {
            bank.pendingPayTable?[user!.id] = Double(sender.text!)! / 100.0
        }
        
    }
    
    var user:user?
    func setUser(u: user){
        user = u;
        memberName.text = u.name
    }
}

class SplitOptionViewController: UIViewController{
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func doneButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    override var shouldAutorotate: Bool {
        return true
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated);
        tableView.reloadData()
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

extension SplitOptionViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bank.currGroup?.users.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let g = (bank.currGroup?.users[indexPath.row])!
        let cell = tableView.dequeueReusableCell(withIdentifier: "splitOption") as! SplitOptionCell
        cell.setUser(u: g)
        return cell
    }
}
