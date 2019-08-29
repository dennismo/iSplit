//
//  addGroupViewController.swift
//  iSplit
//
//  Created by Dennis Mo on 5/25/19.
//  Copyright © 2019 Dennis Mo. All rights reserved.
//
import UIKit

class addGroupViewController: UIViewController {
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    var g = Group()
    @IBAction func addGroupButton(_ sender: UIButton) {
        bank.groups.append(g)
        dismiss(animated: true, completion: nil)
    }

    func stringToNames(s: String) -> [String] {
        return s.components(separatedBy: ",")
    }

    @IBAction func cancel(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func groupName(_ sender: UITextField) {
        g.groupName = sender.text!
    }

    @IBAction func memberName(_ sender: UITextField) {
        g.users.removeAll()
        for name in stringToNames(s: sender.text!) {
            g.users.append(User(name: name))
        }
    }

    @IBAction func addGroup(_ sender: UIButton) {

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override var prefersStatusBarHidden: Bool {
        return false
    }

}
