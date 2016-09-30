//
//  GPswdPathView.swift
//  gesturePswd
//
//  Created by 鲍的Mac on 9/30/16.
//  Copyright © 2016 com.YorrickBao. All rights reserved.
//

import UIKit

class GPPathView: UIView {
    
    var bezierPoints = [CGPoint]() { didSet { setNeedsDisplay() } }
    var fakePoint: CGPoint? { didSet { setNeedsDisplay() } }
    var lineColor = UIColor.black
    
    override func draw(_ rect: CGRect) {
        guard !bezierPoints.isEmpty else {return}
        
        let path = UIBezierPath()
        path.move(to: bezierPoints[0])
        
        if bezierPoints.count > 1 {
            for i in 1..<bezierPoints.count {
                path.addLine(to: bezierPoints[i])
            }
        }
        
        if let fakePoint = fakePoint { path.addLine(to: fakePoint) }
        
        path.lineCapStyle = .round
        path.lineWidth = 10
        lineColor.setStroke()
        path.stroke()
        
    }
    
    func reset() {
        bezierPoints.removeAll()
        fakePoint = nil
    }
    
    
}

extension GPPathView {
    convenience init(frame: CGRect, lineColor: UIColor = UIColor.black) {
        self.init(frame: frame)
        self.lineColor = lineColor
        self.isOpaque = false
    }
}
