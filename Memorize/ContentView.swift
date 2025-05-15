//
//  ContentView.swift
//  Memorize
//
//  Created by Danut Popa on 26.10.2024.
//

import SwiftUI

struct ContentView: View {
    @State var emojis: [String] = []
    @State var colorTheme = Color.clear
    
    var body: some View {
        VStack {
            Text("Memorize!")
                .font(.largeTitle)
                .fontWeight(.medium)
            
            ScrollView {
                cards
            }
            Spacer()
            HStack(alignment: .lastTextBaseline, spacing: 50) {
                vehiclesButtonTheme
                animalsButtonTheme
                natureButtonTheme
            }
        }
        .padding()
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: widthThatBestFits(cardCount: emojis.count)))]) {
            ForEach(emojis.indices, id: \.self) { index in
                CardView(content: emojis[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
      .foregroundStyle(colorTheme)
    }
        
    var vehiclesButtonTheme: some View {
        changeTheme(with: "Vehicles", label: "car", color: .blue, contents: Constants.vehicles)
    }
    
    var animalsButtonTheme: some View {
        changeTheme(with: "Animals", label: "dog", color: .red, contents: Constants.animals)
    }
    
    var natureButtonTheme: some View {
        changeTheme(with: "Nature", label: "leaf", color: .green, contents: Constants.nature)
    }
    
    func changeTheme(with name: String, label: String, color: Color, contents: [String]) -> some View {
        Button(action: {
            updateEmojis(with: contents)
            colorTheme = color
        }, label: {
            VStack {
                Image(systemName: label)
                    .imageScale(.large)
                    .font(.title)
                
                Text(name)
                    .font(.subheadline)
            }
        })
    }
    
    func updateEmojis(with contents: [String]) {
        if emojis.isEmpty == false {
            emojis.removeAll()
        }
        let upperLimit = Int.random(in: 3..<contents.count)
        emojis.append(contentsOf: contents[0...upperLimit])
        emojis = emojis.shuffled()
    }
    
    func widthThatBestFits(cardCount: Int) -> CGFloat {
//        var multiplier = 10
//        if cardCount <= 5 {
//            multiplier = 20
//        } else if cardCount >= 10 {
//            multiplier = 5
//        }
//        return CGFloat(cardCount * multiplier)
        let multiplier = switch cardCount {
        case 1...5: 20.0
        case 6..<10: 10.0
        case 10...16: 5.0
        case 17...21: 3.0
        case 22...25: 2.5
        default: 1.0
        }
        return CGFloat(Double(cardCount) * multiplier)
    }
}

struct CardView: View {
    let content: String
    @State var isFaceUp = false
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            }
            .opacity(isFaceUp ? 1 : 0)
            base.fill().opacity(isFaceUp ? 0 : 1)
        }
        .onTapGesture {
            isFaceUp.toggle()
        }
    }
}

#Preview {
    ContentView()
}
