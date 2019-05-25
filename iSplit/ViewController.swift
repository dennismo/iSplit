//
//  ViewController.swift
//  iSplit
//
//  Created by Dennis Mo on 5/25/19.
//  Copyright © 2019 Dennis Mo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
//    lazy var scene = StartScene(size: view.bounds.size)
    
    @IBAction func addItem(_ sender: UIButton) {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
//        let skView = view as! View
//        skView.ignoresSiblingOrder = true
//        skView.showsFPS = true
//        skView.showsNodeCount = true
//        scene.scaleMode = .resizeFill
//        skView.presentScene(scene)
    }
    
    @IBAction func groups(_ sender: UIButton) {
        
    }
    @IBOutlet weak var purchases: UITableView!
    
    
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


