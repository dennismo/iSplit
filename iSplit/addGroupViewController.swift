import UIKit

class AddGroupViewController: UIViewController {
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    var g: Group = Group()
    @IBAction func addGroupButton(_ sender: UIButton) {
    bank.groups.append(g)
        dismiss(animated: true, completion: nil)
    }
    func stringToNames(s: String) -> [String]{
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
        var ns = stringToNames(s: sender.text!)
        for i in 0...ns.count - 1 {
            g.users.append(User(name: ns[i],id: i))
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

