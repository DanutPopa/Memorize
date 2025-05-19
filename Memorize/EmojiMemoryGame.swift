//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Danut Popa on 15.05.2025.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    private static let vehicles = ["🚜", "🚲", "🚁", "🚌", "🚗", "🚔", "⛵️", "🚀", "🚂", "🛳️", "🚅", "🚁", "🚌", "⛵️", "🛵", "🚜", "🚗", "🚲", "🚀", "🚂", "🛳️", "🛵", "🚅", "🚔"]
    
    private static func createMemoryGame() -> MemoryGame<String> {
       return MemoryGame(numberOfPairsOfCards: 16) { pairIndex in
           if vehicles.indices.contains(pairIndex) {
               return vehicles[pairIndex]
           } else {
               return "⁉️"
           }
        }
    }
    
    @Published private var model = createMemoryGame()
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    // MARK: - Intents
    
    func shuffle() {
        model.shuffle()
    }
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
}
