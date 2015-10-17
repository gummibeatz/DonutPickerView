//
//  DonutPickerView.swift
//  DonutPicker
//
//  Created by Linus Liang on 10/12/15.
//  Copyright © 2015 Linus Liang. All rights reserved.
//

import Foundation
import UIKit

let π:CGFloat = CGFloat(M_PI)

protocol DonutPickerViewDelegate {
    func didSelectDonutPiece(index: Int)
}

class DonutPickerView: UIView {
    
    var touchBeganPoint: CGPoint = CGPoint()
    var pathIsSelected: [Bool] = []
    var bezierPaths: [UIBezierPath] = []
    var shapeLayers: [CAShapeLayer] = []
    var region: Int = -1
    
    var isSelectedOffset: Int?
    var delegate: DonutPickerViewDelegate?
    
    lazy var DonutCenter: CGPoint = CGPoint(x: self.bounds.width/2, y: self.bounds.height/2)
    lazy var maxRadius: CGFloat = max(self.bounds.width, self.bounds.height)
    lazy var arcWidth: CGFloat = self.maxRadius/3
    
    var colors: [UIColor] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
//    init(frame: CGRect, colors: [UIColor]) {
//        super.init(frame: frame)
//        print("yay")
//        self.colors = colors
//        
//        setupPaths()
//    }
    
    init(frame: CGRect, colors: [UIColor], isSelectedOffset: Int = 30) {
        super.init(frame: frame)
        print("yay")
        self.colors = colors
        self.isSelectedOffset = isSelectedOffset
        setupPaths()
    }
    
    override func drawRect(rect: CGRect) {
        UIColor.blackColor().setStroke()
        for(var i=0; i < colors.count; i++) {
            colors[i].setFill()
            bezierPaths[i].stroke()
            bezierPaths[i].fill()
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event)
        let touch: UITouch = touches.first!
        touchBeganPoint = touch.locationInView(self)
        print("=====touchbegan=====")
        print("(\(self.touchBeganPoint.x),\(self.touchBeganPoint.y))")
        for(var i = 0; i < bezierPaths.count; i++) {
            
            if(bezierPaths[i].containsPoint(touchBeganPoint)) {
                region = i
                print("region = \(region)")
            }
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesEnded(touches, withEvent: event)
        let touch: UITouch = touches.first!
        let firstTouch: CGPoint = touch.locationInView(self)
        print("=====touchend======")
        print("(\(firstTouch.x),\(firstTouch.y))")
        
        for( var i=0; i < bezierPaths.count; i++) {
            if(bezierPaths[i].containsPoint(firstTouch) && i == region) {
                self.selectPathWithIndex(i)
                self.delegate?.didSelectDonutPiece(i)
            }
        }
    }
    
    func setupPaths() {
        let colorCount:CGFloat = CGFloat(colors.count)
        for(var i=0; i < colors.count; i++) {
            let startAngle:CGFloat = CGFloat(i)*2*π/colorCount
            let endAngle:CGFloat = CGFloat(i+1)*2*π/colorCount
            let startPath = UIBezierPath(arcCenter: DonutCenter, radius: maxRadius/3, startAngle: startAngle, endAngle: endAngle, clockwise: true)
            startPath.addArcWithCenter(DonutCenter, radius: maxRadius/9, startAngle: endAngle, endAngle: startAngle, clockwise: false)
            startPath.closePath()
    
            bezierPaths.append(startPath)
            pathIsSelected.append(false)
        }
    }
    
    
    func selectPathWithIndex(index: Int) {
        print("selected path with index")
        var r: CGFloat = CGFloat(isSelectedOffset!)
        if pathIsSelected[index]{
            pathIsSelected[index] = false
            r = r * -1
        } else {
            pathIsSelected[index] = true
        }
        
        let ø = (CGFloat(2*index)+1.0) * π / CGFloat(colors.count)
        let tx = r * cos(ø)
        let ty = r * sin(ø)
        let transform: CGAffineTransform = CGAffineTransformMakeTranslation( tx, ty)
        bezierPaths[index].applyTransform(transform)
        self.setNeedsDisplay()
    }
    
}