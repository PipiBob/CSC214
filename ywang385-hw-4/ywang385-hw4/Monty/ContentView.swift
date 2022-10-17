//
//  ContentView.swift
//  Monty
//
//  Created by pipiBob on 10/17/22.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var model = Games()
    @Environment(\.verticalSizeClass) var verticalSizeClass
    
    var body: some View {
        
        if verticalSizeClass == .compact {
            GeometryReader { geo in
                ZStack {
                    VStack {
                        HStack(alignment: .center) {
                            GameView(model: model)
                        }
                    }
                    WinView(gameOver: model.gameOver, height: geo.size.height, win: model.win)
                }
            }
        } else {
            GeometryReader { geo in
                ZStack {
                    VStack {
                        VStack { GameView(model: model) }
                    }
                    WinView(gameOver: model.gameOver, height: geo.size.height,win: model.win)
                }
            }
        }
    }
}

struct WinView: View {
    
    var gameOver: Bool
    var height: CGFloat
    var win : Bool
    var body: some View {
        if(win){
        Text("Winner")
            .font(.custom("Times", size: 98))
            .foregroundColor(.blue)
            //.background(.brown)
            .padding()
            .offset(y: gameOver ? 0.0 : -height)
            .animation(.interpolatingSpring(stiffness: 200, damping: 12), value: gameOver)
        }else{
            Text("Loser")
                .font(.custom("Times", size: 98))
                .foregroundColor(.red)
                //.background(.brown)
                .padding()
                .offset(y: gameOver ? 0.0 : -height)
                .animation(.interpolatingSpring(stiffness: 200, damping: 12), value: gameOver)
        }
    }
}

struct GameView: View {
    
    @StateObject var model: Games
    
    var tileRow = Array(repeating: GridItem(.flexible()), count: 3)
    let duration = 0.7
    let columns = [
        GridItem(.adaptive(minimum: 80))
    ]
    
    var body: some View {
        
        VStack{
            ZStack{
                Color.black	
            
                LazyVGrid(columns: tileRow) {
        //LazyVGrid(columns: columns,spacing: 20){
            ForEach(model.cards) { card in
                CardView(card: $model.cards[card.ID])
                    .aspectRatio(1, contentMode: .fit)
                    .cornerRadius(8)
                    .clipShape(Rectangle())
                    .onTapGesture {
                        if !card.faceup {
                            model.toggleFaceUp(card.ID)
                        }
                    }
                   // .animation(card.hidden ? nil : .easeIn(duration: 0.25), value: card.faceUp)
            }
        }
        	.padding()
        }
        //Spacer()
        
        ZStack {
            //Color("CardBackground")
            Color.gray
                //.ignoresSafeArea()
            
            HStack {
                Spacer()
                VStack{
                    Text("Player: " + String(model.player))
                        .font(.custom("Times", size: 15))
                    Text("Score: " + String(model.score))
                        .font(.custom("Times", size: 15))
                }
                .foregroundColor(.orange)
                .padding()
                
                Spacer()
                
                Button("new Game") {
                    model.newGame()
                }
                .font(.custom("Times", size: 18))
                .foregroundColor(.white)
                //.background(Color.gray.opacity(0.5))
                .padding()
                //.opacity(model.gameOver ? 1 : 0)
                
                Spacer()
            }
        }
        //.cornerRadius(8)
        //.padding()
    }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
