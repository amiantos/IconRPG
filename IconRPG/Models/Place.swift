//
//  Place.swift
//  IconRPG
//
//  Created by Brad Root on 11/19/18.
//  Copyright © 2018 Brad Root. All rights reserved.
//

import Foundation
import UIKit

class Place {
    var enemies: [Enemy] = []
    var health = 100
    var strength = 10
    var intelligence = 10
    var dexterity = 10
    var appearance: UIImage
    
    init() {
        // Add enemies to place
        let random = Int.random(in: 1 ... 3)
        for _ in 1 ... random {
            enemies.append(Enemy())
        }
        // Determine appearance
        let images = ["place_castle", "place_church"]
        self.appearance = UIImage(named: images.randomElement()!)!
    }
}
