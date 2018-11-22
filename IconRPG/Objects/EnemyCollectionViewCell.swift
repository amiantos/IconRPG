//
//  EnemyCollectionViewCell.swift
//  IconRPG
//
//  Created by Bradley Root on 11/18/18.
//  Copyright © 2018 Brad Root. All rights reserved.
//

import UIKit

protocol EnemyCollectionViewCellDelegate: AnyObject {
    func enemyButtonPressed(cell: EnemyCollectionViewCell)
}

class EnemyCollectionViewCell: UICollectionViewCell {

    weak var delegate: EnemyCollectionViewCellDelegate?
    var enemy: Enemy = Enemy()

    @IBOutlet weak var deathMarker: UIImageView!
    @IBOutlet weak var enemyButton: RPGButton!

    @IBAction func enemyButtonTouchUpInside(_ sender: RPGButton) {
        sender.touchUp()
        delegate?.enemyButtonPressed(cell: self)
    }

    @IBAction func enemyButtonTouchDown(_ sender: RPGButton) {
        sender.touchDown()
    }

    @IBAction func enemyButtonTouchUp(_ sender: RPGButton) {
        sender.touchUp()
    }

    // MARK: - View Setup

    override func layoutSubviews() {
        super.layoutSubviews()
        self.enemyButton.setup()
    }

    func updateLifeStatus() {
        if enemy.alive {
            self.deathMarker.isHidden = true
            self.enemyButton.isEnabled = true
        } else {
            self.deathMarker.frame.size = CGSize(width: self.enemyButton.imageView!.frame.width,
                                                 height: self.enemyButton.imageView!.frame.height)
            self.deathMarker.center = self.enemyButton.center
            self.deathMarker.isHidden = false
            self.deathMarker.image = self.deathMarker.image!.withRenderingMode(.alwaysTemplate)
            self.deathMarker.tintColor = UIColor.red
            self.enemyButton.isEnabled = false
        }
    }

}
