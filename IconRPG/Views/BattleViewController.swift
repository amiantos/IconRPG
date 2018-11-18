//
//  BattleViewController.swift
//  IconRPG
//
//  Created by Bradley Root on 11/17/18.
//  Copyright © 2018 Brad Root. All rights reserved.
//

import UIKit

class BattleViewController: UIViewController {

    @IBAction func buttonTouchDown(_ sender: UIButton) {
        buttonPress(button: sender)
        if sender.restorationIdentifier == "guard" {
            print("guard")
        }
    }
    @IBAction func buttonTouchUpInside(_ sender: UIButton) {
        buttonUp(button: sender)
        print(sender.restorationIdentifier!)
    }
    @IBAction func buttonTouchUp(_ sender: UIButton) {
        buttonUp(button: sender)
    }

    @IBOutlet weak var weaponButton: UIButton!
    @IBOutlet weak var guardButton: UIButton!
    @IBOutlet weak var bandageButton: UIButton!
    @IBOutlet weak var magicButton: UIButton!
    @IBOutlet weak var inventoryButton: UIButton!

    
    @IBOutlet weak var enemyImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.setupView()
    }
    
    func setupView() {
        let enemy = Enemy()
        self.enemyImageView.image = enemy.appearance
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupButton(button: self.weaponButton)
        setupButton(button: self.bandageButton)
        setupButton(button: self.guardButton)
        setupButton(button: self.magicButton)
        setupButton(button: self.inventoryButton)
        self.startWiggling()
    }
    
    func setupButton(button: UIButton) {
        button.backgroundColor = UIColor.white
        button.layer.cornerRadius = button.frame.width / 2
        button.clipsToBounds = true
        button.layer.shadowPath = UIBezierPath(
            roundedRect: button.bounds,
            cornerRadius: button.layer.cornerRadius).cgPath
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 3, height: 3)
        button.layer.shadowRadius = 5
        button.layer.shadowOpacity = 0.15
        button.layer.masksToBounds = false
        
        let edgeInset = button.frame.width * 0.2

        button.imageEdgeInsets = UIEdgeInsets(top: edgeInset, left: edgeInset, bottom: edgeInset, right: edgeInset)
    }
    
    func buttonPress(button: UIButton) {
        
        UIView.animate(withDuration: 0.2, animations: {
                button.transform = CGAffineTransform(translationX: 1, y: 2)
            })
        let animation = CABasicAnimation(keyPath: "shadowOpacity")
        animation.fromValue = button.layer.shadowOpacity
        animation.toValue = 0.1
        animation.duration = 0.2
        
        button.layer.add(animation, forKey: animation.keyPath)
        button.layer.shadowOpacity = 0.1
    }
    
    func buttonUp(button: UIButton) {
        UIView.animate(withDuration: 0.2, animations: {
            button.transform = CGAffineTransform(translationX: -1, y: -2)
        })
        let animation = CABasicAnimation(keyPath: "shadowOpacity")
        animation.fromValue = button.layer.shadowOpacity
        animation.toValue = 0.15
        animation.duration = 0.2
        
        button.layer.add(animation, forKey: animation.keyPath)
        button.layer.shadowOpacity = 0.15
    }
    
    func startWiggling() {
        guard enemyImageView.layer.animation(forKey: "wiggle") == nil else { return }
        guard enemyImageView.layer.animation(forKey: "bounce") == nil else { return }
        
        let angle = 0.01
        
        let wiggle = CAKeyframeAnimation(keyPath: "transform.rotation.z")
        wiggle.values = [-angle, angle]
        wiggle.autoreverses = true
        wiggle.duration = 1
        wiggle.repeatCount = Float.infinity
        enemyImageView.layer.add(wiggle, forKey: "wiggle")
        
        let bounce = CAKeyframeAnimation(keyPath: "transform.translation.y")
        bounce.values = [1.0, 0.0]
        bounce.autoreverses = true
        bounce.duration = 0.5
        bounce.repeatCount = Float.infinity
        enemyImageView.layer.add(bounce, forKey: "bounce")
    }

}

