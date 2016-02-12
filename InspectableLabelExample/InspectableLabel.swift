//
//  InspectableLabel.swift
//  HollywoodReporter
//
//  Created by Nattawut Singhchai on 2/11/16.
//  Copyright © 2016 Nattawut Singhchai. All rights reserved.
//

import UIKit

@IBDesignable
class InspectableLabel: UILabel {
    
    @IBInspectable
    var charSpacing: CGFloat? {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable
    var lineSpacing: CGFloat? {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable
    var paragraphSpacing: CGFloat? {
        didSet {
            updateView()
        }
    }
    
    override func awakeFromNib() {
        updateView()
    }

    override func drawRect(rect: CGRect) {
        super.drawRect(CGRect(origin: CGPointZero, size: rect.size))
        updateView()
    }
    
    func updateView() {
        if  text == nil  {
            text = ""
        }
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = textAlignment
        
        if let minimumLineHeight = lineSpacing {
            paragraph.minimumLineHeight = minimumLineHeight
        }
        
        if let paragraphSpacing = paragraphSpacing {
            paragraph.paragraphSpacingBefore = paragraphSpacing
        }

        var attr = [NSFontAttributeName:font,
            NSParagraphStyleAttributeName: paragraph,
            NSForegroundColorAttributeName: textColor
        ]
        
        if let kern = charSpacing {
            attr[NSKernAttributeName] = kern
        }

        let attrString = NSAttributedString(string: text!, attributes:attr)
        attributedText = attrString
        
    }

}
