//
//  ScalingTextViewController.swift
//  AboutLayout
//
//  Created by NixonShih on 2017/1/20.
//  Copyright © 2017年 Nixon. All rights reserved.
//

import UIKit

class ScalingTextViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 以4寸為基準調整比例
        let rate = UIScreen.main.bounds.width / 320
        changeFontSize(withScalingRate: rate)
    }
}
