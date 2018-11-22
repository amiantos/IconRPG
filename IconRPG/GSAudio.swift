//
//  GSAudio.swift
//  IconRPG
//
//  Created by Bradley Root on 11/18/18.
//  Copyright © 2018 Brad Root. All rights reserved.
//

import Foundation
import AVFoundation

class GSAudio: NSObject, AVAudioPlayerDelegate {

    static let sharedInstance = GSAudio()

    private override init() { }

    var players: [URL: AVAudioPlayer] = [:]
    var duplicatePlayers: [AVAudioPlayer] = []

    func playSound(soundFileName: String) {

        guard let bundle = Bundle.main.path(forResource: soundFileName, ofType: "wav") else { return }
        let soundFileNameURL = URL(fileURLWithPath: bundle)

        if let player = players[soundFileNameURL] { //player for sound has been found

            if !player.isPlaying { //player is not in use, so use that one
                player.prepareToPlay()
                player.play()
            } else { // player is in use, create a new, duplicate, player and use that instead

                do {
                    let duplicatePlayer = try AVAudioPlayer(contentsOf: soundFileNameURL)

                    duplicatePlayer.delegate = self
                    //assign delegate for duplicatePlayer so delegate can remove the duplicate once it's stopped playing

                    duplicatePlayers.append(duplicatePlayer)
                    //add duplicate to array so it doesn't get removed from memory before finishing

                    duplicatePlayer.prepareToPlay()
                    duplicatePlayer.play()
                } catch let error {
                    print(error.localizedDescription)
                }

            }
        } else { //player has not been found, create a new player with the URL if possible
            do {
                let player = try AVAudioPlayer(contentsOf: soundFileNameURL)
                players[soundFileNameURL] = player
                player.prepareToPlay()
                player.play()
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }

    func playSounds(soundFileNames: [String]) {
        for soundFileName in soundFileNames {
            playSound(soundFileName: soundFileName)
        }
    }

    func playSounds(soundFileNames: String...) {
        for soundFileName in soundFileNames {
            playSound(soundFileName: soundFileName)
        }
    }

    func playSounds(soundFileNames: [String], withDelay: Double) { //withDelay is in seconds
        for (index, soundFileName) in soundFileNames.enumerated() {
            let delay = withDelay * Double(index)
            _ = Timer.scheduledTimer(
                timeInterval: delay,
                target: self,
                selector: #selector(playSoundNotification(_:)),
                userInfo: ["fileName": soundFileName],
                repeats: false)
        }
    }

    @objc func playSoundNotification(_ notification: NSNotification) {
        if let soundFileName = notification.userInfo?["fileName"] as? String {
            playSound(soundFileName: soundFileName)
        }
    }

    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if let index = duplicatePlayers.index(of: player) {
            duplicatePlayers.remove(at: index)
        }
    }

}
