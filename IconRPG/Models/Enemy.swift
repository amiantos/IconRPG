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
    var name = ""
    var health = 100
    var strength = 10
    var intelligence = 10
    var dexterity = 10
    var appearance: UIImage
    var alive: Bool = true
    
    init() {
        // Determine enemy appearance
        let images = ["enemy_furry_demon", "enemy_ghost", "enemy_demon"]
        self.appearance = UIImage(named: images.randomElement() ?? "enemy_furry_demon")!
    }
}
