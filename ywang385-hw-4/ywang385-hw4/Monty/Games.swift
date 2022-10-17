//
//  Card.swift
//  Monty
//
//  Created by pipiBob on 10/17/22.
//

import Foundation

struct Card: Identifiable {
    let id = UUID()
    let emoji : String
    let imageBack: String
    var faceup : Bool
    let ID : Int
}

final class Games: ObservableObject{
    
    private let kNumCards = 3
    @Published var cards = [Card]()
    @Published var score = 0
    @Published var player = 0
    @Published var gameOver = false
    @Published var win = false
    
    @Published var CardArray = [Card(emoji: "A", imageBack: "Back", faceup: false, ID: 0),
                                Card(emoji: "J", imageBack: "Back", faceup: false, ID: 1),
                                Card(emoji: "K", imageBack: "Back", faceup: false, ID: 2)]

    init() {
        newGame()
    }
                                    
    private func faceUpCards() -> [Card] {
            return cards.filter { $0.faceup == true }
    }
    private func findMatch() {
        let faceUpCards = faceUpCards()
            if strcmp(faceUpCards[0].emoji, "A") == 0 {
                win = true
                self.gameOver = true
                score += 3
            }else {
                win = false
                self.gameOver = true
            }
    }
        
        func newGame() {
            
            player += 1
            cards.removeAll()
            CardArray.shuffle()
            for i in stride(from: 0, to: kNumCards, by: 1) {
                cards.append(CardArray[i])
            }
            gameOver = false
        }
    
    
    func toggleFaceUp(_ ID: Int){
        //if(faceUpCards().count==1){
        cards[ID].faceup.toggle()
            findMatch()
    }
}
