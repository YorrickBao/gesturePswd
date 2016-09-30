//
//  GesturePswdModel.swift
//  gesturePswd
//
//  Created by 鲍的Mac on 9/30/16.
//  Copyright © 2016 com.YorrickBao. All rights reserved.
//

import UIKit
import Foundation

struct constantsKEY {
    static let pswdKEY = "passwordkey"
}

class GesturePswdModel {
    
    //MARK: - Storable property:
    
    var pswdInput = ""
    var grid = [GPswdView]()
    var bezierPathView = GPPathView()
    var failureHandler: () -> ()
    var successHandler: () -> ()
    private var superView: UIView
    private var tileMargin: CGFloat
    
    //MARK: - Computed property:
    
    private var tileLenth: CGFloat { get { return (superView.bounds.width - 4 * tileMargin) / 3 } }
    private var tileSize: CGSize { get { return CGSize(width: tileLenth, height: tileLenth) } }
    private lazy var tileFrames: Array<CGRect> = { [unowned self] in
            var frames = [CGRect]()
            let startX = self.tileMargin
            let startY = self.superView.center.y - self.tileMargin - self.tileLenth * 1.5
            for i in 0..<9 {
                let frame = CGRect(x: startX + (self.tileMargin + self.tileLenth) * CGFloat(i % 3),
                                   y: startY + (self.tileMargin + self.tileLenth) * CGFloat(i / 3),
                                   width: self.tileLenth,
                                   height: self.tileLenth)
                frames.append(frame)
            }
            return frames
    }()
    var password: String {
        get {
            return UserDefaults.standard.string(forKey: constantsKEY.pswdKEY) ?? ""
        }
        set {
            let ud = UserDefaults.standard
            ud.set(newValue, forKey: constantsKEY.pswdKEY)
            ud.synchronize()
        }
    }
    
    //MARK: - Methods:
    
    init(tileMargin margin: CGFloat, superView sView: UIView, failureHandler failure: @escaping () -> (), successHandler success: @escaping () -> ()) {
        tileMargin = margin
        superView = sView
        failureHandler = failure
        successHandler = success
        setupSubviews()
        setupGesture()
    }
    
    private func setupSubviews() {
        bezierPathView = GPPathView(frame: superView.frame, lineColor: UIColor(red:0.43, green:0.97, blue:1.00, alpha:1.00))
        superView.addSubview(bezierPathView)
        
        for i in 0..<9 {
            let gView = GPswdView(frame: tileFrames[i], id: i)
            grid.append(gView)
            superView.addSubview(gView)
        }
    }
    
    private func setupGesture() {
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(panGesture(_:)))
        superView.addGestureRecognizer(gesture)
    }
    
    @objc private func panGesture(_ gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .began:
            fallthrough
        case .changed:
            let gPoint = gesture.location(in: gesture.view)
            for tile in grid {
                if tile.frame.contains(gPoint) && !tile.lightUp {
                    tile.lightUp = true
                    pswdInput += "\(tile.id)"
                    bezierPathView.bezierPoints.append(tile.center)
                } else {
                    if !bezierPathView.bezierPoints.isEmpty {
                        bezierPathView.fakePoint = gPoint
                    }
                }
            }
            
        case .ended:
            validate()
        default:
            break
        }
    }
    
    private func validate() {
        
        if pswdInput == password {
            successHandler()
        } else {
            failureHandler()
        }
        reset()
    }
    
    private func reset() {
        pswdInput = ""
        bezierPathView.reset()
        for tile in grid {
            tile.lightUp = false
        }
    }
    
    
}
