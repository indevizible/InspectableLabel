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
    
    @IBOutlet weak var ความกว้าง: NSLayoutConstraint!
    
    var fontSize: CGFloat = 35
    
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
        updateViewConstraints()
        print(ความสูง.constant)
    }

    @IBAction func increment(sender: AnyObject) {
        label.font = label.font.fontWithSize(label.font.pointSize + 0.2)
        updateViewConstraints()
    }
    
    @IBAction func decrement(sender: AnyObject) {
        label.font = label.font.fontWithSize(label.font.pointSize - 0.2)
        updateViewConstraints()
    }
    
    @IBAction func incLineSpace(sender: UIButton) {
        label.lineSpacing++
        updateViewConstraints()
    }
    
    @IBAction func decLineSpace(sender: UIButton) {
        label.lineSpacing--
        updateViewConstraints()
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        ความสูง.constant = label.boundingSizeWithSize(CGSize(width: ความกว้าง.constant, height: CGFloat.max)).height
    }
    
}

