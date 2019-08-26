//
//  addTrans.swift
//  iSplit
//
//  Created by Dennis Mo on 5/25/19.
//  Copyright © 2019 Dennis Mo. All rights reserved.
//

import UIKit

class grouptableCell :UITableViewCell{
    @IBOutlet weak var memberNames: UILabel!
    
    @IBOutlet weak var groupName: UILabel!
    
    @IBOutlet weak var groupIcon: UIImageView!
    @IBAction func selectGroup(_ sender: UIButton) {
        bank.currGroup = cellGroup
    }
    var cellGroup:group?
    func setgroupTable(group: group){
        cellGroup = group
        groupName.text = group.groupName
        groupIcon.image = group.groupImage
        memberNames.text = group.getMembers()
    }
}


class groupsViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    public var groups = [group]()
    
    @IBAction func doneGroup(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func addGroup(_ sender: UIButton) {
        let addGroupVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "addGroupViewController") as! addGroupViewController
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
extension groupsViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bank.groups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let g = bank.groups[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Groups") as! grouptableCell
        cell.setgroupTable(group: g)
        return cell
    }
}
