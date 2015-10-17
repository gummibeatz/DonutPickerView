//
//  sampleShape.swift
//  DonutPicker
//
//  Created by Linus Liang on 10/4/15.
//  Copyright © 2015 Linus Liang. All rights reserved.
//

import Foundation
import UIKit

class SampleShape: UIView {
    
    let π = CGFloat(M_PI)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func drawRect(rect: CGRect) {
        
        UIColor.greenColor().setStroke()
        UIColor.redColor().setFill()
        
        let center:CGPoint = CGPoint(x: self.bounds.width/2, y: self.bounds.height/2)
        let radius:CGFloat = max(self.bounds.width, self.bounds.height)
        let arcWidth:CGFloat = radius/3
        
        let startAngle:CGFloat = 0
        let endAngle:CGFloat = π
        
        var path = UIBezierPath()
        path.addArcWithCenter(center, radius: radius/3, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        
        
        path.lineWidth = arcWidth
//        path.fill()
        path.stroke()
    }
}