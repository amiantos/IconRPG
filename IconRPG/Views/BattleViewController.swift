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

    @IBOutlet weak var weaponButton: RPGButton!
    @IBOutlet weak var guardButton: RPGButton!
    @IBOutlet weak var bandageButton: RPGButton!
    @IBOutlet weak var magicButton: RPGButton!
    @IBOutlet weak var inventoryButton: RPGButton!

    @IBOutlet weak var enemyImageView: UIImageView!
    @IBOutlet weak var enemyHealthBar: UIView!
    @IBOutlet weak var enemyHealthBarInterior: UIView!
    
    @IBOutlet weak var playerHealthBar: UIView!
    @IBOutlet weak var playerHealthBarInterior: UIView!
    
    // MARK: - Actions
    
    @IBAction func buttonTouchDown(_ sender: RPGButton) {
        sender.touchDown()
        if sender.restorationIdentifier == "guard" {
            print("guard")
        }
    }

    @IBAction func buttonTouchUpInside(_ sender: RPGButton) {
        sender.touchUp()
        if sender.restorationIdentifier == "weapon" {
            self.attack()
        }
    }

    @IBAction func buttonTouchUp(_ sender: RPGButton) {
        sender.touchUp()
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
        let buttons: [RPGButton] = [self.weaponButton, self.bandageButton, self.guardButton, self.magicButton, self.inventoryButton]
        for button in buttons {
            button.setup()
        }

        enemyHealthBarInterior.frame = CGRect(x: 0, y: 0, width: enemyHealthBar.frame.width, height: enemyHealthBar.frame.height)
        enemyHealthBarInterior.layer.cornerRadius = enemyHealthBarInterior.frame.height / 2
        enemyHealthBarInterior.clipsToBounds = true
        
        playerHealthBarInterior.frame = CGRect(x: 0, y: 0, width: playerHealthBar.frame.width, height: playerHealthBar.frame.height)
        playerHealthBarInterior.layer.cornerRadius = enemyHealthBarInterior.frame.height / 2
        playerHealthBarInterior.clipsToBounds = true
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

