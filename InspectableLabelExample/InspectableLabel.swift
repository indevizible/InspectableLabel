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
    
    var paragraph = NSMutableParagraphStyle()
    
    public func updateView() {
        
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
        
        
        attributedText?.drawWithRect(CGRect(origin: CGPoint(x: 0, y: -lineSpacing + font.pointSize + (font.capHeight - font.xHeight)), size: CGSize(width: frame.width, height: CGFloat.max)), options: [.UsesLineFragmentOrigin,.UsesFontLeading], context: nil)
        
    }
    
}

extension InspectableLabel {
    func boundingSizeWithSize(size: CGSize) -> CGSize {
        guard let attributedText = attributedText else {
            return CGSizeZero
        }
        let calcSize = attributedText.boundingRectWithSize(size,
            options: [.UsesLineFragmentOrigin,.UsesFontLeading],
            context: nil)
        
        return CGSize(
            width: ceil(calcSize.width),
            height: ceil(calcSize.height - (paragraph.minimumLineHeight) + font.pointSize - font.descender)
        )
    }
}
