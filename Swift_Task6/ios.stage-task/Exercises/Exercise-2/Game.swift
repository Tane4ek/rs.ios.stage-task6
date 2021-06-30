//
//  Game.swift
//  DurakGame
//
//  Created by Дима Носко on 16.06.21.
//

import Foundation

protocol GameCompatible {
    var players: [Player] { get set }
}

struct Game: GameCompatible {
    var players: [Player]
}

extension Game {

    func defineFirstAttackingPlayer(players: [Player]) -> Player? {
        var firstPlayer: Player? = nil
        var firstTrump: Value? = nil
        for player in players {
            if player.hand == nil {
                return nil
            } else {
                for card in player.hand! {
                    if card.isTrump && ( firstTrump == nil || card.value.rawValue < firstTrump!.rawValue) {
                        firstTrump = card.value
                        firstPlayer = player
                    }
                }
            }

        }
        return firstPlayer
    }
}
