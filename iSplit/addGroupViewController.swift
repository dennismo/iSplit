import UIKit

class addGroupViewController: UIViewController {
    
    weak var parentVC:groupsViewController!
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    @IBAction func addGroupButton(_ sender: UIButton) {
        parentVC.groups.append(group(name: groupName.text ?? "", members: stringToNames(s: memberName.text!)))
        dismiss(animated: true, completion: nil)
    }
    func stringToNames(s:String) -> [String]{
        return s.components(separatedBy: ",")
    }
    @IBOutlet weak var memberName: UITextField!
    @IBOutlet weak var groupName: UITextField!
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

