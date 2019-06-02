//
//  addTrans.swift
//  iSplit
//
//  Created by Dennis Mo on 5/25/19.
//  Copyright © 2019 Dennis Mo. All rights reserved.
//

import UIKit

class addViewController: UIViewController {

    @IBAction func addTransactionButton(_ sender: UIButton) {
//        print("dismissed!")
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
    @IBAction func transactionName(_ sender: UITextField) {
    }
    @IBAction func amountSpent(_ sender: UITextField) {
    }
    @IBAction func dateofPurchase(_ sender: UIDatePicker) {
    }
    @IBOutlet weak var splitPicker: UIPickerView!
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
