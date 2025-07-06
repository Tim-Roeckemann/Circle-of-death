//
//  ContentView.swift
//  Circle of death
//
//  Created by Tim Röckemann on 06.07.25.
//

import SwiftUI

struct ContentView: View {
    @State private var deck = Card.deck
    @State private var selectedCard: Card? = nil
    @State private var discards: [Card] = []

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ForEach(deck.indices, id: \.self) { index in
                    let card = deck[index]
                    CardView(card: card)
                        .frame(width: 40, height: 60)
                        .position(position(for: index, in: geometry.size))
                        .onTapGesture {
                            withAnimation(.spring()) {
                                selectedCard = card
                                deck.removeAll { $0.id == card.id }
                            }
                        }
                }

                if let card = selectedCard {
                    CardView(card: card, faceUp: true)
                        .frame(width: 200, height: 300)
                        .zIndex(1)
                        .transition(.asymmetric(insertion: .scale, removal: .opacity))
                        .onTapGesture {
                            withAnimation(.spring()) {
                                discards.append(card)
                                selectedCard = nil
                            }
                        }
                }

                ForEach(discards.indices, id: \.self) { index in
                    let card = discards[index]
                    CardView(card: card, faceUp: true)
                        .frame(width: 40, height: 60)
                        .position(x: geometry.size.width - 30,
                                  y: geometry.size.height - CGFloat(index * 15 + 50))
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.green.opacity(0.2))
        }
    }

    private func position(for index: Int, in size: CGSize) -> CGPoint {
        let angle = 2 * Double.pi * Double(index) / Double(deck.count)
        let radius = min(size.width, size.height) / 2 - 50
        let x = size.width / 2 + CGFloat(cos(angle)) * radius
        let y = size.height / 2 + CGFloat(sin(angle)) * radius
        return CGPoint(x: x, y: y)
    }
}

#Preview {
    ContentView()
}
