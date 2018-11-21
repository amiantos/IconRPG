//
//  RPGButton.swift
//  IconRPG
//
//  Created by Brad Root on 11/20/18.
//  Copyright © 2018 Brad Root. All rights reserved.
//

import UIKit

class RPGButton: UIButton {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    func setup() {
        self.backgroundColor = UIColor.white
        self.layer.cornerRadius = self.frame.width / 2
        self.clipsToBounds = true
        self.layer.shadowPath = UIBezierPath(
            roundedRect: self.bounds,
            cornerRadius: self.layer.cornerRadius).cgPath
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 3, height: 3)
        self.layer.shadowRadius = 5
        self.layer.shadowOpacity = 0.15
        self.layer.masksToBounds = false
        
        let edgeInset = self.frame.width * 0.2
        
        self.imageEdgeInsets = UIEdgeInsets(top: edgeInset, left: edgeInset, bottom: edgeInset, right: edgeInset)
    }
    
    func touchDown() {
        UIView.animate(withDuration: 0.1, animations: {
            self.transform = CGAffineTransform(translationX: 1, y: 2)
        })
        let offsetAnimation = CABasicAnimation(keyPath: "shadowOffset")
        offsetAnimation.fromValue = self.layer.shadowOffset
        offsetAnimation.toValue = CGSize(width: 1, height: 1)
        offsetAnimation.duration = 0.1
        
        self.layer.add(offsetAnimation, forKey: offsetAnimation.keyPath)
        self.layer.shadowOffset = CGSize(width: 1, height: 1)
    }
    
    func touchUp() {
        UIView.animate(withDuration: 0.1, animations: {
            self.transform = CGAffineTransform(translationX: -1, y: -2)
        })
        let offsetAnimation = CABasicAnimation(keyPath: "shadowOffset")
        offsetAnimation.fromValue = self.layer.shadowOffset
        offsetAnimation.toValue = CGSize(width: 3, height: 3)
        offsetAnimation.duration = 0.1
        
        self.layer.add(offsetAnimation, forKey: offsetAnimation.keyPath)
        self.layer.shadowOffset = CGSize(width: 3, height: 3)
    }

}
