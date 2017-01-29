//
//  ProgrammaticallyViewController.swift
//  AboutLayout
//
//  Created by NixonShih on 2017/1/28.
//  Copyright © 2017年 Nixon. All rights reserved.
//

import UIKit

class ProgrammaticallyViewController: UIViewController {
    
    fileprivate let kTableViewCellIdentifier = "Cell"
    
    fileprivate var musicLogoImageView: UIImageView?
    
    fileprivate let dataSource: [[String:Any]]? = {
        guard let path = Bundle.main.path(forResource: "MusicData", ofType: "json") else {
            return nil;
        }
        guard let jsonData = try? Data(contentsOf: URL(fileURLWithPath: path)) else {
            return nil;
        }
        guard let jsonResult = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers) as! [[String:Any]] else {
            return nil;
        }
        return jsonResult
    }()
    
    fileprivate var timer: Timer?
    
    // MARK: UIViewController Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        logoFlipFromRight()
        timer = Timer.scheduledTimer(timeInterval: 3.5, target: self, selector: #selector(logoFlipFromRight), userInfo: nil, repeats: true)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        timer?.invalidate()
    }
    
    // MARK: UI
    
    fileprivate func prepareUI() {
        
        title = "Show"
        
        let theTableView = UITableView()
        view.addSubview(theTableView)
        theTableView.dataSource = self
        theTableView.register(CustomCell.self, forCellReuseIdentifier: kTableViewCellIdentifier)
        
        let theHeaderBackgroundView = UIView()
        view.addSubview(theHeaderBackgroundView)
        
        let theMusicLogoImageView = UIImageView(image: UIImage(named: "MusicLogo"))
        musicLogoImageView = theMusicLogoImageView
        theHeaderBackgroundView.addSubview(theMusicLogoImageView)
        
        let theTitleLabel = UILabel()
        theTitleLabel.text = "Music Life"
        theHeaderBackgroundView.addSubview(theTitleLabel)
        
        // translatesAutoresizingMaskIntoConstraints 不讓系統自動加 Constraints
        theTableView.translatesAutoresizingMaskIntoConstraints = false
        theHeaderBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        theMusicLogoImageView.translatesAutoresizingMaskIntoConstraints = false
        theTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let views = ["tableView":theTableView,
                     "titleLabel":theTitleLabel,
                     "musicLogoImageView":theMusicLogoImageView,
                     "headerBackgroundView":theHeaderBackgroundView]
        
        // 詳細用法請查 Constraint Visual Format Language
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-(0)-[headerBackgroundView(181)]-(0)-[tableView]-(0)-|", options: .directionLeadingToTrailing, metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(0)-[headerBackgroundView]-(0)-|", options: .directionLeadingToTrailing, metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(0)-[tableView]-(0)-|", options: .directionLeadingToTrailing, metrics: nil, views: views))
        
        let useAnchor = true
        // 示範不同種Constraint的用法，NSLayoutAnchor是iOS9開放的API。
        if useAnchor {
            theHeaderBackgroundView.addConstraint(theMusicLogoImageView.centerXAnchor.constraint(equalTo: theHeaderBackgroundView.centerXAnchor))
            theHeaderBackgroundView.addConstraint(theMusicLogoImageView.centerYAnchor.constraint(equalTo: theHeaderBackgroundView.centerYAnchor, constant: -15))
            
            theHeaderBackgroundView.addConstraint(theTitleLabel.centerXAnchor.constraint(equalTo: theHeaderBackgroundView.centerXAnchor))
            theHeaderBackgroundView.addConstraint(theTitleLabel.topAnchor.constraint(equalTo: theMusicLogoImageView.bottomAnchor, constant: 10))
        }else{
            theHeaderBackgroundView.addConstraint(NSLayoutConstraint(item: theMusicLogoImageView, attribute: .centerX, relatedBy: .equal, toItem: theHeaderBackgroundView, attribute: .centerX, multiplier: 1, constant: 0))
            theHeaderBackgroundView.addConstraint(NSLayoutConstraint(item: theMusicLogoImageView, attribute: .centerY, relatedBy: .equal, toItem: theHeaderBackgroundView, attribute: .centerY, multiplier: 1, constant: -15))
            
            theHeaderBackgroundView.addConstraint(NSLayoutConstraint(item: theTitleLabel, attribute: .centerX, relatedBy: .equal, toItem: theHeaderBackgroundView, attribute: .centerX, multiplier: 1, constant: 0))
            theHeaderBackgroundView.addConstraint(NSLayoutConstraint(item: theTitleLabel, attribute: .top, relatedBy: .equal, toItem: theMusicLogoImageView, attribute: .bottom, multiplier: 1, constant: 10))
        }
    }
    
    // MARK: Animate
    
    @objc fileprivate func logoFlipFromRight() {
        UIView.transition(with: musicLogoImageView!, duration: 1, options: .transitionFlipFromRight, animations: nil, completion: nil)
    }
    
}

extension ProgrammaticallyViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // shit 這都不會返回 nil 啊
        let cell = tableView.dequeueReusableCell(withIdentifier: kTableViewCellIdentifier) ?? CustomCell(style: .subtitle, reuseIdentifier: kTableViewCellIdentifier)

        let info = dataSource![indexPath.row]
        
        cell.textLabel?.text = info["title"] as? String
        cell.detailTextLabel?.text = info["showUnit"] as? String
        
        return cell
    }
}

class CustomCell: UITableViewCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
