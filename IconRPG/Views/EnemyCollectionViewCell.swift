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
    @IBOutlet weak var enemyButton: UIButton!
    @IBAction func enemyButtonTouchUpInside(_ sender: UIButton) {
        print("Pressed")
        delegate?.buttonPressed(cell: self)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.setupButton()
    }
    
    func setupButton() {
        enemyButton.setImage(enemy.appearance, for: .normal)
        enemyButton.backgroundColor = UIColor.white
        enemyButton.layer.cornerRadius = enemyButton.frame.width / 2
        enemyButton.clipsToBounds = true
        enemyButton.layer.shadowPath = UIBezierPath(
            roundedRect: enemyButton.bounds,
            cornerRadius: enemyButton.layer.cornerRadius).cgPath
        enemyButton.layer.shadowColor = UIColor.black.cgColor
        enemyButton.layer.shadowOffset = CGSize(width: 3, height: 3)
        enemyButton.layer.shadowRadius = 5
        enemyButton.layer.shadowOpacity = 0.15
        enemyButton.layer.masksToBounds = false
        
        let edgeInset = enemyButton.frame.width * 0.2
        
        enemyButton.imageEdgeInsets = UIEdgeInsets(top: edgeInset, left: edgeInset, bottom: edgeInset, right: edgeInset)
    }
    
}
