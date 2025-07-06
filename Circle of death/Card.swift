import SwiftUI

enum Suit: String, CaseIterable, Identifiable {
    case hearts = "♥"
    case diamonds = "♦"
    case clubs = "♣"
    case spades = "♠"

    var id: String { rawValue }

    var color: Color {
        switch self {
        case .hearts, .diamonds:
            return .red
        case .clubs, .spades:
            return .black
        }
    }
}

struct Card: Identifiable {
    let id = UUID()
    let rank: String
    let suit: Suit

    static let ranks = ["2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K", "A"]

    static var deck: [Card] {
        Suit.allCases.flatMap { suit in
            ranks.map { rank in
                Card(rank: rank, suit: suit)
            }
        }
    }
}

struct CardView: View {
    let card: Card
    var faceUp: Bool = false

    var body: some View {
        ZStack {
            if faceUp {
                RoundedRectangle(cornerRadius: 5)
                    .fill(Color.white)
                    .shadow(radius: 1)
                VStack(spacing: 2) {
                    Text(card.rank)
                        .font(.caption)
                        .bold()
                    Text(card.suit.rawValue)
                        .font(.caption2)
                }
                .foregroundColor(card.suit.color)
            } else {
                RoundedRectangle(cornerRadius: 5)
                    .fill(Color.blue)
                    .shadow(radius: 1)
                Image(systemName: "questionmark")
                    .foregroundColor(.white)
            }
        }
        .overlay(
            RoundedRectangle(cornerRadius: 5)
                .stroke(Color.black, lineWidth: 1)
        )
    }
}
