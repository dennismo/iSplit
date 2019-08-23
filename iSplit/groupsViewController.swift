//
//  addTrans.swift
//  iSplit
//
//  Created by Dennis Mo on 5/25/19.
//  Copyright © 2019 Dennis Mo. All rights reserved.
//

import UIKit

class grouptableCell :UITableViewCell{

    @IBOutlet weak var groupName: UILabel!
    
    @IBOutlet weak var groupIcon: UIImageView!
    @IBAction func selectGroup(_ sender: UIButton) {
    }
    func setgroupTable(name:String, image:UIImage){
        groupName.text = name
        groupIcon.image = image
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
        addGroupVC.parentVC = self
        self.present(addGroupVC, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
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
        return groups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let g = groups[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Groups") as! tableCell
//        cell.setTransaction(trans: g)
        return cell
    }
}
