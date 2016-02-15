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
        
        
        attributedText?.drawWithRect(CGRect(origin: CGPoint(x: 0, y: yDrawingSpace), size: CGSize(width: frame.width, height: CGFloat.max)), options: [.UsesLineFragmentOrigin,.UsesFontLeading], context: nil)
        
    }
    
    var yDrawingSpace: CGFloat {
        let ls = -lineSpacing + font.pointSize + (font.capHeight - font.xHeight)
        return lineSpacing <= 0 ? 0 : ls
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
        var height = ceil(calcSize.height)
        if paragraph.minimumLineHeight > 0 {
            height = ceil(calcSize.height - (max(0, paragraph.minimumLineHeight)) + font.pointSize - font.descender)
        }
        
        return CGSize(
            width: ceil(calcSize.width),
            height: height
        )
    }
}
