//
//  ViewController.swift
//  TextView
//
//  Created by Anand on 25/11/16.
//  Copyright © 2016 test. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tapOnPresent(self)
    }

    @IBAction func tapOnPresent(_ sender: Any) {
        let storyBooard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let presentVC: textVC = storyBooard.instantiateViewController(withIdentifier: "textVC") as! textVC
        self.present(presentVC, animated: true, completion: nil)
    }
}

