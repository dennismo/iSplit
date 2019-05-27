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
}


class groupsViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var groups = [group]()
    
    @IBAction func doneGroup(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func addGroup(_ sender: UIButton) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "transaction") as! tableCell
//        cell.setTransaction(trans: g)
        return cell
    }
}
