//
//  EnemyCollectionViewCell.swift
//  IconRPG
//
//  Created by Bradley Root on 11/18/18.
//  Copyright © 2018 Brad Root. All rights reserved.
//

import UIKit

protocol EnemyCollectionViewCellDelegate {
    func buttonPressed(cell: EnemyCollectionViewCell)
}

class EnemyCollectionViewCell: UICollectionViewCell {

    var delegate: EnemyCollectionViewCellDelegate?
    var enemy: Enemy = Enemy()

    @IBOutlet weak var deathMarker: UIImageView!
    @IBOutlet weak var enemyButton: UIButton!
    
    @IBAction func enemyButtonTouchUpInside(_ sender: UIButton) {
        buttonUp(button: sender)
        delegate?.buttonPressed(cell: self)
    }
    
    @IBAction func enemyButtonTouchDown(_ sender: UIButton) {
        buttonPress(button: sender)
    }
    
    @IBAction func enemyButtonTouchUp(_ sender: UIButton) {
        buttonUp(button: sender)
    }
    
    // MARK: - View Setup

    override func layoutSubviews() {
        super.layoutSubviews()
        self.setupButton()
    }
    
    func updateLifeStatus() {
        print("Laying out enemy button... \(enemy.alive)")
        if enemy.alive {
            self.deathMarker.isHidden = true
            self.enemyButton.isEnabled = true
        } else {
            self.deathMarker.frame.size = CGSize(width: self.enemyButton.imageView!.frame.width, height: self.enemyButton.imageView!.frame.height)
            self.deathMarker.center = self.enemyButton.center
            self.deathMarker.isHidden = false
            self.deathMarker.image = self.deathMarker.image!.withRenderingMode(.alwaysTemplate)
            self.deathMarker.tintColor = UIColor.red
            // self.deathMarker.transform = CGAffineTransform(rotationAngle: CGFloat.random(in: 1 ... 6))
            self.enemyButton.isEnabled = false
        }
    }
    
    // MARK: - Button Appearance
    
    func setupButton() {
        self.enemyButton.setImage(enemy.appearance, for: .normal)
        self.enemyButton.backgroundColor = UIColor.white
        self.enemyButton.layer.cornerRadius = self.enemyButton.frame.width / 2
        self.enemyButton.clipsToBounds = true
        self.enemyButton.layer.shadowPath = UIBezierPath(
            roundedRect: self.enemyButton.bounds,
            cornerRadius: self.enemyButton.layer.cornerRadius).cgPath
        self.enemyButton.layer.shadowColor = UIColor.black.cgColor
        self.enemyButton.layer.shadowOffset = CGSize(width: 3, height: 3)
        self.enemyButton.layer.shadowRadius = 5
        self.enemyButton.layer.shadowOpacity = 0.15
        self.enemyButton.layer.masksToBounds = false
        
        let edgeInset = self.enemyButton.frame.width * 0.2
        
        self.enemyButton.imageEdgeInsets = UIEdgeInsets(top: edgeInset, left: edgeInset, bottom: edgeInset, right: edgeInset)
    }
    
    func buttonPress(button: UIButton) {
        UIView.animate(withDuration: 0.1, animations: {
            button.transform = CGAffineTransform(translationX: 1, y: 2)
        })
        let offsetAnimation = CABasicAnimation(keyPath: "shadowOffset")
        offsetAnimation.fromValue = button.layer.shadowOffset
        offsetAnimation.toValue = CGSize(width: 1, height: 1)
        offsetAnimation.duration = 0.1
        
        button.layer.add(offsetAnimation, forKey: offsetAnimation.keyPath)
        button.layer.shadowOffset = CGSize(width: 1, height: 1)
    }
    
    func buttonUp(button: UIButton) {
        UIView.animate(withDuration: 0.1, animations: {
            button.transform = CGAffineTransform(translationX: -1, y: -2)
        })
        let offsetAnimation = CABasicAnimation(keyPath: "shadowOffset")
        offsetAnimation.fromValue = button.layer.shadowOffset
        offsetAnimation.toValue = CGSize(width: 3, height: 3)
        offsetAnimation.duration = 0.1
        
        button.layer.add(offsetAnimation, forKey: offsetAnimation.keyPath)
        button.layer.shadowOffset = CGSize(width: 3, height: 3)
    }
    
}
