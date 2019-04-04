//
//  Canvas.swift
//  Drawing
//
//  Created by Shashwat  on 03/04/19.
//  Copyright © 2019 Shashwat . All rights reserved.
//

import Foundation
import UIKit

class Canvas : UIView {
    
    var chosenColor : UIColor!
    var chosenWidth : Float!
    
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        guard let context = UIGraphicsGetCurrentContext() else { return }
        //        let startingPoint = CGPoint(x: 0, y: 0)
        //        let finalPoint = CGPoint(x: 100, y: 100)
        //        context.move(to: startingPoint)
        //        context.addLine(to: finalPoint)
        lines.forEach { (line) in
            context.setLineWidth(CGFloat(line.width))
            context.setStrokeColor(line.color.cgColor)
            context.setLineCap(.round)
            for (i,p) in line.points.enumerated() {
                if i == 0 {
                    context.move(to: p)
                }else {
                    context.addLine(to: p)
                    
                }
                
            }
            context.strokePath()
        }
//        lines.forEach { (line) in
//            for (i,p) in line.enumerated() {
//            }
//        }
//
       
    }
    
    fileprivate var lines = [Line]()
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        lines.append(Line(color: chosenColor, width: chosenWidth, points: []))
    }
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let point = touches.first?.location(in: nil) else {return}
        guard var lastLine = lines.popLast() else { return }
        lastLine.points.append(point)
        lines.append(lastLine)
        setNeedsDisplay()
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(frame: CGRect, withColor : UIColor) {
        self.init(frame : frame)
        chosenColor = withColor
        chosenWidth = 1
    }
    
    func cleanCanvas()  {
        lines.removeAll()
        setNeedsDisplay()
    }
    
    func undoCanvas() {
       let _ =  lines.popLast()
        setNeedsDisplay()
    }
    
    
}
