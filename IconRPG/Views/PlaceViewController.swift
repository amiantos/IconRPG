//
//  PlaceViewController.swift
//  IconRPG
//
//  Created by Bradley Root on 11/18/18.
//  Copyright © 2018 Brad Root. All rights reserved.
//

import UIKit

class PlaceViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, EnemyCollectionViewCellDelegate {
    
    func buttonPressed(cell: EnemyCollectionViewCell) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let battleView = storyBoard.instantiateViewController(withIdentifier: "battleView") as! BattleViewController
        battleView.enemy = cell.enemy
        self.present(battleView, animated: true, completion: nil)
        
    }
    
    @IBOutlet weak var placeImageView: UIImageView!
    @IBOutlet weak var enemyCollectionView: UICollectionView!
    
    var enemies: [Enemy] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let random = Int.random(in: 1 ... 3)
        print(random)
        
        for _ in 1 ... random {
            enemies.append(Enemy())
        }
        
        
        enemyCollectionView.delegate = self
        enemyCollectionView.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return enemies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "enemyButton", for: indexPath) as! EnemyCollectionViewCell
        cell.delegate = self
        cell.enemy = enemies[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width / 3) - 16
        print(width)
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        let cellWidth: CGFloat = (collectionView.frame.width / 3) - 16
        
        let numberOfCells: CGFloat = CGFloat(collectionView.numberOfItems(inSection: 0))
        let divisor = numberOfCells == 2 ? 2 : (numberOfCells + 1)
        let edgeInsets = ((self.view.frame.size.width - (numberOfCells * cellWidth)) / divisor)
        
        print("Edge Insets: \(edgeInsets)")
        
        return UIEdgeInsets(top: 0, left: edgeInsets, bottom: 0, right: edgeInsets)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
