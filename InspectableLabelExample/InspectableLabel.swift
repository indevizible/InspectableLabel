//
//  InspectableLabel.swift
//
//  Created by Nattawut Singhchai on 2/11/16.
//  Copyright © 2016 Nattawut Singhchai. All rights reserved.
//

import UIKit

@IBDesignable
public class InspectableLabel: UILabel {
    
    @IBInspectable
    public var charSpacing: CGFloat = 0.0 {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable
    public var lineSpacing: CGFloat = 0.0{
        didSet {
            updateView()
        }
    }
    
    @IBInspectable
    public var paragraphSpacing: CGFloat = 0.0 {
        didSet {
            updateView()
        }
    }
    
    public override func prepareForInterfaceBuilder() {
        updateView()
    }
    

    public override func drawRect(rect: CGRect) {
        updateView()
    }
    
    public func updateView() {
        
        let paragraph = NSMutableParagraphStyle()
        
        paragraph.alignment = textAlignment

        paragraph.minimumLineHeight = lineSpacing
        
        paragraph.maximumLineHeight = lineSpacing
        
        paragraph.paragraphSpacingBefore = paragraphSpacing
        

        var attr = [NSFontAttributeName:font,
            NSParagraphStyleAttributeName: paragraph,
            NSForegroundColorAttributeName: textColor
        ]
        

        attr[NSKernAttributeName] = charSpacing
        
        if let text = text {
            attributedText = NSAttributedString(string: text, attributes:attr)
        }
        
        attributedText?.drawInRect(CGRect(origin: CGPoint(x: 0, y: font.ascender - font.capHeight), size: frame.size))
        
    }
    
}
