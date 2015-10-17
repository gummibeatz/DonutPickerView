//
//  PentagonShape.swift
//  DonutPicker
//
//  Created by Linus Liang on 10/9/15.
//  Copyright © 2015 Linus Liang. All rights reserved.
//

import Foundation
import UIKit

class PentagonShape: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func drawRect(rect: CGRect) {
        var aPath: UIBezierPath = UIBezierPath(ovalInRect: CGRect(x: 0, y: 0, width: 200, height: 100))
        UIColor.blackColor().setStroke()
        UIColor.redColor().setFill()
        
        var context:CGContextRef = UIGraphicsGetCurrentContext()!
        CGContextSaveGState(context)
        
        CGContextTranslateCTM(context, 50, 50)
        aPath.lineWidth = 5
        aPath.fill()
        aPath.stroke()
        CGContextRestoreGState(context)
    }
}