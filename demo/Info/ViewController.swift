//
//  ViewController.swift
//  demo
//
//  Created by west on 24/12/20.
//

import UIKit

class ViewController: UIViewController {
    
    let viewModel = InfoViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }

    @IBAction func tapHistory(_ sender: UIBarButtonItem) {
        self.viewModel.getInfo()
    }
    
}

extension ViewController {
    
}

