//
//  UIViewController+TextFitScreen.swift
//  AboutLayout
//
//  Created by NixonShih on 2017/1/20.
//  Copyright © 2017年 Nixon. All rights reserved.
//

import UIKit

extension UIViewController {
    
    /** 置換當前ViewController內的字體大小，針對 UILabel 以及 UIButton。 */
    internal func changeFontSize(withScalingRate scalingRate:CGFloat) {
        
        func findText(with theView: UIView, rate: CGFloat) {
            for aView in theView.subviews {
                
                findText(with: aView, rate: rate)
                
                if aView is UILabel {
                    let aLebel = aView as! UILabel
                    scalingText(with: aLebel, scalingRate: rate)
                }
                
                if aView is UIButton {
                    let aButton = aView as! UIButton
                    scalingText(with: aButton, scalingRate: rate)
                }
            }
        }
        
        findText(with: self.view, rate: scalingRate)
    }
    
    fileprivate func scalingText(with theLabel: UILabel?, scalingRate: CGFloat) {
        
        guard let label = theLabel else { return }
        
        label.font = UIFont(name: label.font.fontName,
                            size: label.font.pointSize * scalingRate)
    }
    
    fileprivate func scalingText(with theButton: UIButton, scalingRate: CGFloat) {
        scalingText(with: theButton.titleLabel, scalingRate: scalingRate)
    }
    
}
