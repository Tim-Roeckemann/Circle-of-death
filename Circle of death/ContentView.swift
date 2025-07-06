//
//  ContentView.swift
//  Circle of death
//
//  Created by Tim Röckemann on 06.07.25.
//

import SwiftUI

struct ContentView: View {
    private let cards = Card.deck

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ForEach(cards.indices, id: \.self) { index in
                    CardView(card: cards[index])
                        .frame(width: 40, height: 60)
                        .position(position(for: index, in: geometry.size))
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.green.opacity(0.2))
        }
    }

    private func position(for index: Int, in size: CGSize) -> CGPoint {
        let angle = 2 * Double.pi * Double(index) / Double(cards.count)
        let radius = min(size.width, size.height) / 2 - 50
        let x = size.width / 2 + CGFloat(cos(angle)) * radius
        let y = size.height / 2 + CGFloat(sin(angle)) * radius
        return CGPoint(x: x, y: y)
    }
}

#Preview {
    ContentView()
}
