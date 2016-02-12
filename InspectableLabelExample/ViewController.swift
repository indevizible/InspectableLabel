//
//  ViewController.swift
//  InspectableLabelExample
//
//  Created by Nattawut Singhchai on 2/12/16.
//  Copyright © 2016 Nattawut Singhchai. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: InspectableLabel!
    
    @IBOutlet weak var ความสูง: NSLayoutConstraint!
    
    @IBOutlet weak var secndLbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func manualUpdate(sender: AnyObject) {

    }

}

