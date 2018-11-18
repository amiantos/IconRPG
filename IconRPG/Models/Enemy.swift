//
//  Enemy.swift
//  IconRPG
//
//  Created by Bradley Root on 11/17/18.
//  Copyright © 2018 Brad Root. All rights reserved.
//

import Foundation
import UIKit

class Enemy {
    @objc dynamic var name = ""
    @objc dynamic var health = 100
    @objc dynamic var strength = 10
    @objc dynamic var intelligence = 10
    @objc dynamic var dexterity = 10
    @objc dynamic var appearance: UIImage
    
    init() {
        let images = ["enemy_furry_demon", "enemy_ghost", "enemy_demon"]
        self.appearance = UIImage(named: images.randomElement() ?? "enemy_furry_demon")!
    }
}
