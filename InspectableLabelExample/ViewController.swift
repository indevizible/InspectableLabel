//
//    Copyright © 2016 Nattawut Singhchai <jadedragon17650@gmail.com>
//
//    Licensed under the Apache License, Version 2.0 (the "License");
//    you may not use this file except in compliance with the License.
//    You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
//    Unless required by applicable law or agreed to in writing, software
//    distributed under the License is distributed on an "AS IS" BASIS,
//    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//    See the License for the specific language governing permissions and
//    limitations under the License.
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

