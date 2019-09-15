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
    @IBAction func addTransactionButton(_ sender: UIButton) {
        if bank.pendingTransaction.tranName == "" || bank.pendingTransaction.totalAmount == 0 {
            let alert = UIAlertController(title: "Incomplete Transaction", message: "Please input all required values", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "I KNOW", style: .cancel, handler: nil))
            self.present(alert, animated: true)
        }
        else{
            bank.newTransaction(trans: bank.pendingTransaction)
            dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func cancel(_ sender: UIButton) {
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
        options.append("Advanced Spliting Option")
        splitPicker.delegate = self
    }
    @IBAction func transactionName(_ sender: UITextField) {
        bank.pendingTransaction.tranName = sender.text ?? ""
    }
    @IBAction func amountSpent(_ sender: UITextField) {
        if sender.text != nil { bank.pendingTransaction.totalAmount = Double(sender.text!)!
        }
    }
    @IBAction func dateofPurchase(_ sender: UIDatePicker) {
        bank.pendingTransaction.date = sender.date
    }
    @IBOutlet weak var splitPicker: UIPickerView!
    
    @IBAction func splitOptionButton(_ sender: UIButton) {
        if bank.pendingTransaction.totalAmount != 0 {
            bank.pendingTransaction.payTable = []
            for i in 0...(bank.currGroup?.users.count)! - 1 {
                bank.pendingTransaction.payTable.append(0.0)
            }
            let splitVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "splitOption") as! SplitOptionViewController
            present(splitVC, animated: true, completion: nil)
        }
    }
    @IBAction func settleUpButton(_ sender: UIButton) {
        let alert = UIAlertController(title: "Do you want to Settle Up?", message: "All user balance will be set the zero.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (alert) -> Void in
            for u in bank.currGroup!.users {
                u.balance = 0
            }
            bank.currGroup?.tranHistory.insert(transaction(tranName:"Settle Up" , date: bank.pendingTransaction.date), at: 0)
            self.dismiss(animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "OOPS,NVM", style: .cancel, handler: nil))
        self.present(alert, animated: true)
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
        if (row != options.count - 1){
            bank.pendingTransaction.payTable.removeAll()
            for i in 0...bank.currGroup!.users.count - 1 {
                if(i == row){
                    bank.pendingTransaction.payTable.append(1.0 - 1.0 / Double((bank.currGroup!.users.count)))
                }
                else{
                    bank.pendingTransaction.payTable.append(-1.0 / Double((bank.currGroup!.users.count)))
                }
            }
        }
    }
}
