//
//  MemorizeGame.swift
//  Memorize
//
//  Created by Danut Popa on 15.05.2025.
//

import Foundation

struct MemoryGame<CardContent: Equatable> {
    private(set) var cards: Array<Card>
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = []
        // add numberOfPairsOfCards x 2 cards
        for pairIndex in 0..<max(2, numberOfPairsOfCards) {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: "\(pairIndex + 1)a"))
            cards.append(Card(content: content, id: "\(pairIndex + 1)b"))
        }
    }
    
    var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get { cards.indices.filter { index in cards[index].isFaceUp }.only }
        set { cards.indices.forEach { cards[$0].isFaceUp = (newValue == $0) } }
    }
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }) {
            // 1. Allow to flip cards over that are face down and not matched.
            if cards[chosenIndex].isFaceUp == false && cards[chosenIndex].isMatched == false {
                // if there is one and only face up card
                // if the one and only card is face up and you click on the card I'm going to try and match it
                if let potentialMatchedIndex = indexOfTheOneAndOnlyFaceUpCard {
                // and it matches the card you just flipped over
                    if cards[chosenIndex].content == cards[potentialMatchedIndex].content {
                        // mark the cards as matched
                        cards[chosenIndex].isMatched = true
                        cards[potentialMatchedIndex].isMatched = true
                    }
                } else {
                    indexOfTheOneAndOnlyFaceUpCard = chosenIndex
                }
                // turn the card that you clicked on back face up
                cards[chosenIndex].isFaceUp = true
            }
            // I'm going to be the one that turns cards face down
            // If you have two cards that are face up and they don't match I'll turn them back face down when you click the next card
            
            
        }
    }

    mutating func shuffle() {
        cards.shuffle()
        print(cards)
    }
    
    struct Card: Equatable, Identifiable, CustomDebugStringConvertible {
        var isFaceUp = false
        var isMatched = false
        let content: CardContent
        
        var id: String
        var debugDescription: String {
            "\(id): \(content) \(isFaceUp ? "up" : "down")\(isMatched ? "matched" : "")"
        }
    }
}

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
