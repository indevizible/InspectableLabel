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

@IBDesignable
public class InspectableLabel: UILabel {
    
    public var truncateLastVisibleLine:Bool = true
    
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
    
    var paragraph = NSMutableParagraphStyle() {
        didSet {
            textAlignment = paragraph.alignment
            lineSpacing = paragraph.minimumLineHeight
            paragraphSpacing = paragraph.paragraphSpacingBefore
        }
    }
    
    public func updateView() {
        
        paragraph.alignment = textAlignment

        paragraph.minimumLineHeight = lineSpacing
        
        paragraph.maximumLineHeight = lineSpacing
        
        paragraph.paragraphSpacingBefore = paragraphSpacing
        
        paragraph.lineBreakMode = lineBreakMode

        var attr = [NSFontAttributeName:font,
            NSParagraphStyleAttributeName: paragraph,
            NSForegroundColorAttributeName: textColor
        ]
        
        attr[NSKernAttributeName] = charSpacing
        
        if let text = text {
            attributedText = NSAttributedString(string: text, attributes:attr)
        }
        
        var options:NSStringDrawingOptions = [.UsesLineFragmentOrigin,.UsesFontLeading]
        if truncateLastVisibleLine {
            options.insert(.TruncatesLastVisibleLine)
        }
        
        attributedText?.drawWithRect(CGRect(origin: CGPoint(x: 0, y: yDrawingSpace),
            size: CGSize(width: frame.width, height: ceil(frame.height - yDrawingSpace))),
            options: options,
            context: nil)
    }
    
    var yDrawingSpace: CGFloat {
        let ls = -lineSpacing + font.pointSize + (font.capHeight - font.xHeight)
        return lineSpacing <= 0 ? 0 : ls
    }
    
    public override func sizeThatFits(size: CGSize) -> CGSize {
        guard let attributedText = attributedText else {
            return CGSizeZero
        }
        return InspectableLabel.sizeThatFitsWithAttributedText(attributedText,
            size: size,
            font: font,
            paragraph: paragraph)
    }
    
    private class
        func sizeThatFitsWithAttributedText(attributedText: NSAttributedString,size:CGSize,font:UIFont,paragraph:NSParagraphStyle) -> CGSize {
            let calcSize = attributedText.boundingRectWithSize(size,
                options: [.UsesLineFragmentOrigin,.UsesFontLeading],
                context: nil)
            var height = calcSize.height
            if paragraph.minimumLineHeight > 0 {
                height = calcSize.height - paragraph.minimumLineHeight + font.pointSize - font.descender
            }
            
            return CGSize(
                width: ceil(calcSize.width),
                height: ceil(height)
            )
    }
}

extension NSAttributedString {
    
    public func in_boundingSizeWithSize(size: CGSize) -> CGSize {
        let pointer = NSRangePointer()
        guard let   paragraph = attribute(NSParagraphStyleAttributeName, atIndex: 0, effectiveRange: pointer) as? NSParagraphStyle,
                    font = attribute(NSFontAttributeName, atIndex: 0, effectiveRange: pointer) as? UIFont else {
            return CGSizeZero
        }
        return InspectableLabel.sizeThatFitsWithAttributedText(self,
            size: size,
            font: font,
            paragraph: paragraph)

    }
    
}

extension String {
    
    public func in_boundingSizeWithSize(size: CGSize,
        font: UIFont,
        lineSpacing: CGFloat? = nil,
        charSpacing:CGFloat? = nil,
        paragraphSpacing:CGFloat? = nil) -> CGSize {
        
        let paragraph = NSMutableParagraphStyle()
            if let lineSpacing = lineSpacing {
                paragraph.minimumLineHeight = lineSpacing
            }
            if let paragraphSpacing = paragraphSpacing {
                 paragraph.paragraphSpacingBefore = paragraphSpacing
            }
            
            var attr:[String:AnyObject] = [
                NSFontAttributeName:font
            ]
            if let charSpacing = charSpacing {
                attr[NSKernAttributeName] = charSpacing
            }
            
            return InspectableLabel.sizeThatFitsWithAttributedText(NSAttributedString(string: self, attributes: attr),
                size: size,
                font: font,
                paragraph: paragraph)
            
    }
}

