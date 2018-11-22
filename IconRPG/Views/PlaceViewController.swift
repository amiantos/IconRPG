//
//  PlaceViewController.swift
//  IconRPG
//
//  Created by Bradley Root on 11/18/18.
//  Copyright © 2018 Brad Root. All rights reserved.
//

import UIKit

class PlaceViewController: UIViewController {

    @IBOutlet weak var placeImageView: UIImageView!
    @IBOutlet weak var enemyCollectionView: UICollectionView!

    var enemies: [Enemy] = []
    var place: Place = Place()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.placeImageView.image = place.appearance
        self.enemies = place.enemies

        enemyCollectionView.delegate = self
        enemyCollectionView.dataSource = self

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        enemyCollectionView.reloadData()
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

extension PlaceViewController: EnemyCollectionViewCellDelegate {

    func enemyButtonPressed(cell: EnemyCollectionViewCell) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        if let battleView = storyBoard.instantiateViewController(
                withIdentifier: "battleView") as? BattleViewController {
            battleView.enemy = cell.enemy
            self.present(battleView, animated: true, completion: nil)
        }
    }
}

extension PlaceViewController: UICollectionViewDataSource,
                               UICollectionViewDelegate,
                               UICollectionViewDelegateFlowLayout {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.restorationIdentifier == "enemyCells" {
            return enemies.count
        }
        return 0
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.restorationIdentifier == "enemyCells" {
            if let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: "enemyButton", for: indexPath) as? EnemyCollectionViewCell {
                cell.delegate = self
                cell.enemy = enemies[indexPath.row]
                cell.updateLifeStatus()
                return cell
            }
        }
        return UICollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView.restorationIdentifier == "enemyCells" {
            let width = (collectionView.frame.width / 3)
            let height = collectionView.frame.height
            let size = height < width ? height : width
            return CGSize(width: size, height: size)
        }
        return CGSize(width: 1, height: 1 )
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView.restorationIdentifier == "enemyCells" {
            let width = (collectionView.frame.width / 3)
            let height = collectionView.frame.height
            let cellWidth: CGFloat = height < width ? height : width
            let numberOfCells: CGFloat = CGFloat(collectionView.numberOfItems(inSection: 0))
            let edgeInsets = ((collectionView.frame.size.width - (numberOfCells * cellWidth))
                / (numberOfCells == 2 ? 2 : numberOfCells + 1))
            return UIEdgeInsets(top: 0, left: edgeInsets, bottom: 0, right: edgeInsets)
        }
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }

}
