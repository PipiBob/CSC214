//
//  CardView.swift
//  Monty
//
//  Created by pipiBob on 10/17/22.
//
//import Foundation
import SwiftUI

struct CardView: View {
    
    @Binding var card: Card

    var body: some View {
        
        ZStack {
            Color("CardBackground")
            
            Image(card.emoji)
                .resizable()
                .scaledToFill()
                .frame(width: 130, height: 200, alignment: .center)
                .opacity(card.faceup ? 1 : 0)
            
            Image(card.imageBack)
                //.font(.custom("Helvetica Neue", fixedSize: 56))
                .resizable()
                .scaledToFill()
                .frame(width: 130, height: 200, alignment: .center)
                .opacity(card.faceup ? 0 : 1)

        }
        //.opacity(card.hidden ? 0 : 1)
        .rotation3DEffect(Angle(degrees: card.faceup ? 180 : 0), axis: (x: 0, y: 10, z: 0))
    }
}


struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        let card = Card(emoji: "A", imageBack: "Back",faceup: true, ID: 0)
        CardView(card: .constant(card))
    }
}
