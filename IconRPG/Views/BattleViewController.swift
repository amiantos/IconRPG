//
//  BattleViewController.swift
//  IconRPG
//
//  Created by Bradley Root on 11/17/18.
//  Copyright © 2018 Brad Root. All rights reserved.
//

import UIKit
import AVFoundation

class BattleViewController: UIViewController {
    
    var enemy: Enemy = Enemy()
    
    // MARK: - Outlets

    @IBOutlet weak var weaponButton: UIButton!
    @IBOutlet weak var guardButton: UIButton!
    @IBOutlet weak var bandageButton: UIButton!
    @IBOutlet weak var magicButton: UIButton!
    @IBOutlet weak var inventoryButton: UIButton!

    @IBOutlet weak var enemyImageView: UIImageView!
    @IBOutlet weak var enemyHealthBar: UIView!
    @IBOutlet weak var enemyHealthBarInterior: UIView!
    
    @IBOutlet weak var playerHealthBar: UIView!
    @IBOutlet weak var playerHealthBarInterior: UIView!
    
    // MARK: - Actions
    
    @IBAction func buttonTouchDown(_ sender: UIButton) {
        buttonPress(button: sender)
        if sender.restorationIdentifier == "guard" {
            print("guard")
        }
    }

    @IBAction func buttonTouchUpInside(_ sender: UIButton) {
        buttonUp(button: sender)
        if sender.restorationIdentifier == "weapon" {
            self.attack()
        }
    }

    @IBAction func buttonTouchUp(_ sender: UIButton) {
        buttonUp(button: sender)
    }
    
    // MARK: - View Setup
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
                self.enemyImageView.image = self.enemy.appearance
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.startIdleAnimation()
    }

    override func viewDidLayoutSubviews() {
        setupButton(button: self.weaponButton)
        setupButton(button: self.bandageButton)
        setupButton(button: self.guardButton)
        setupButton(button: self.magicButton)
        setupButton(button: self.inventoryButton)

        enemyHealthBarInterior.frame = CGRect(x: 0, y: 0, width: enemyHealthBar.frame.width, height: enemyHealthBar.frame.height)
        enemyHealthBarInterior.layer.cornerRadius = enemyHealthBarInterior.frame.height / 2
        enemyHealthBarInterior.clipsToBounds = true
        
        playerHealthBarInterior.frame = CGRect(x: 0, y: 0, width: playerHealthBar.frame.width, height: playerHealthBar.frame.height)
        playerHealthBarInterior.layer.cornerRadius = enemyHealthBarInterior.frame.height / 2
        playerHealthBarInterior.clipsToBounds = true
    }
    
    // MARK: - Button Appearance
    
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
    
    // MARK: - Enemy Behavior
    
    func startIdleAnimation() {
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

    // MARK: - Actions
    
    func attack() {
        let swingSounds = ["swing", "swing2", "swing3"]
        let enemySounds = ["ogre1", "ogre2", "ogre3", "ogre4", "ogre5", "giant1", "giant2", "giant3", "giant4", "giant5"]
        let sounds = [swingSounds.randomElement()!, enemySounds.randomElement()!]
        GSAudio.sharedInstance.playSounds(soundFileNames: sounds, withDelay: 0.1)
        
        
        var new_width = enemyHealthBarInterior.frame.size.width - 50
        new_width = (new_width >= 0) ? new_width : 0
        
        if new_width == 0 {
            self.enemy.alive = false
            self.dismiss(animated: true, completion: nil)
        }
        
        UIView.animate(withDuration: 0.2, animations: {
            self.enemyHealthBarInterior.frame = CGRect(x: ((self.enemyHealthBar.frame.width - new_width) / 2), y: 0, width: new_width, height: self.enemyHealthBarInterior.frame.height)
        })
    }

}

