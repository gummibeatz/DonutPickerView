//
//  ViewController.swift
//  DonutPicker
//
//  Created by Linus Liang on 10/4/15.
//  Copyright © 2015 Linus Liang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let colors = [UIColor.blueColor(), UIColor.redColor(), UIColor.yellowColor(), UIColor.greenColor(), UIColor.blackColor()]

    lazy var rect: CGRect = CGRect(origin: CGPoint(x: 0 , y: self.view.bounds.height/2), size: CGSize(width: self.view.bounds.width , height: self.view.bounds.height/2))
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor.whiteColor()
        
        let DonutPicker: DonutPickerView = DonutPickerView(frame: rect, colors: colors, isSelectedOffset: 30)
        DonutPicker.backgroundColor = UIColor.clearColor()
        DonutPicker.delegate = self
        
        self.view.addSubview(DonutPicker)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ViewController: DonutPickerViewDelegate {
    func didSelectDonutPiece(index: Int) {
        print("selected Donut Donutce at index \(index)")
    }
}
