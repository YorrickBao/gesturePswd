//
//  GPswdButton.swift
//  gesturePswd
//
//  Created by 鲍的Mac on 9/30/16.
//  Copyright © 2016 com.YorrickBao. All rights reserved.
//

import UIKit

class GPswdView: UIView {
    
    var id = -1
    var strokeColor = UIColor.gray
    var fillColor = UIColor.white
    var lineWidth: CGFloat = 2
    var lightUp = false { didSet { setNeedsDisplay() } }
    
    override func draw(_ rect: CGRect) {

        if lightUp {
            let center = CGPoint(x: rect.width / 2, y: rect.height / 2)
            let radius = (rect.width - 10) / 2
            let path = UIBezierPath(arcCenter: center , radius: radius, startAngle: 0, endAngle: CGFloat(2*M_PI), clockwise: true)
            path.lineWidth = lineWidth
            UIColor(red:0.43, green:0.97, blue:1.00, alpha:1.00).setFill()
            path.fill()
            
            let center2 = CGPoint(x: rect.width / 2, y: rect.height / 2)
            let radius2 = (rect.width - 10) / 4
            let path2 = UIBezierPath(arcCenter: center2 , radius: radius2, startAngle: 0, endAngle: CGFloat(2*M_PI), clockwise: true)
            path2.lineWidth = lineWidth
            UIColor(red:0.66, green:0.99, blue:0.85, alpha:1.00).setFill()
            path2.fill()
        } else {
            let center = CGPoint(x: rect.width / 2, y: rect.height / 2)
            let radius = (rect.width - 10) / 2
            let path = UIBezierPath(arcCenter: center , radius: radius, startAngle: 0, endAngle: CGFloat(2*M_PI), clockwise: true)
            path.lineWidth = lineWidth
            strokeColor.setStroke()
            fillColor.setFill()
            path.stroke()
            path.fill()
        }

    }
    
}

extension GPswdView {
    convenience init(frame: CGRect, id: Int, strokeColor: UIColor = UIColor.gray, fillColor: UIColor = UIColor.white) {
        self.init(frame: frame)
        self.id = id
        self.strokeColor = strokeColor
        self.fillColor = fillColor
        self.isOpaque = false
    }
}
