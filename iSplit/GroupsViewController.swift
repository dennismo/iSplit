//
//  addTrans.swift
//  iSplit
//
//  Created by Dennis Mo on 5/25/19.
//  Copyright © 2019 Dennis Mo. All rights reserved.
//

import UIKit

class GrouptableCell : UITableViewCell{
    @IBOutlet weak var memberNames: UILabel!
    
    @IBOutlet weak var groupName: UILabel!
    
    @IBAction func selectGroup(_ sender: UIButton) {
        bank.currGroup = cellGroup
        parentVC?.Exit()
    }
    var parentVC: GroupsViewController?
    var cellGroup: Group?
    func setgroupTable(group: Group,vc: GroupsViewController){
        parentVC = vc
        cellGroup = group
        groupName.text = group.groupName
    }
}


class GroupsViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    public var groups = [Group]()
    public func Exit(){
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func doneGroup(_ sender: UIButton) {
        self.Exit()
    }
    @IBAction func addGroup(_ sender: UIButton) {
        let addGroupVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "addGroupViewController") as! AddGroupViewController
        self.present(addGroupVC, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated);
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
extension GroupsViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bank.groups.count
    }
//    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
//        indexPath.row
//    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let g = bank.groups[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Groups") as! GrouptableCell
        cell.setgroupTable(group: g,vc: self)
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            bank.groups.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
}
