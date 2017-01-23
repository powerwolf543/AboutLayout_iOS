//
//  ArrowView.swift
//  AboutLayout
//
//  Created by NixonShih on 2017/1/20.
//  Copyright © 2017年 Nixon. All rights reserved.
//

import UIKit

@IBDesignable
/** 畫顆朝下的箭頭啦～！！！！！ */
class ArrowView: UIView {

    fileprivate var arrowLayer: CAShapeLayer?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        drawArrow()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        drawArrow()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // 每次 layoutSubviews 的時候都重會一次線。
        arrowLayer?.path = arrowPath().cgPath
    }
    
    fileprivate func drawArrow() {
        
        arrowLayer = CAShapeLayer()
        
        guard let theArrowLayer = arrowLayer else { return }
        
        theArrowLayer.frame = bounds
        theArrowLayer.path = arrowPath().cgPath
        theArrowLayer.fillColor = UIColor.white.cgColor

        layer.addSublayer(theArrowLayer)
    }
    
    fileprivate func arrowPath() -> UIBezierPath {
        let viewSize = bounds.size
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: viewSize.width / 2, y: viewSize.height))
        path.addLine(to: CGPoint(x: viewSize.width, y: 0))
        path.close()
        return path
    }

}
