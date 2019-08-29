//
//  addTrans.swift
//  iSplit
//
//  Created by Dennis Mo on 5/25/19.
//  Copyright © 2019 Dennis Mo. All rights reserved.
//

import UIKit

class addViewController: UIViewController {
    var options:[String] = []
    var trans:transaction = transaction()
    @IBAction func addTransactionButton(_ sender: UIButton) {
        bank.newTransaction(trans: trans)
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
        
        for u in (bank.currGroup?.users)!  {
            options.append(u.name + " paid and split equally")
        }
        splitPicker.delegate = self
    }
    @IBAction func transactionName(_ sender: UITextField) {
        trans.tranName = sender.text ?? ""
    }
    @IBAction func amountSpent(_ sender: UITextField) {
        trans.totalAmount = Double(sender.text!)!
    }
    @IBAction func dateofPurchase(_ sender: UIDatePicker) {
        trans.date = sender.date
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

extension addViewController:UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return options.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return options[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        trans.payTable.removeAll()
        for i in 0...bank.currGroup!.users.count - 1 {
            if(i == row){
                trans.payTable.append(1.0)
            }
            else{
                trans.payTable.append(-1.0 / Double((bank.currGroup!.users.count - 1)))
            }
        }
    }
    
}
