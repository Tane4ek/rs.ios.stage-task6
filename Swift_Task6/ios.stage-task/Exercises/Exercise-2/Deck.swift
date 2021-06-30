import Foundation

protocol DeckBaseCompatible: Codable {
    var cards: [Card] {get set}
    var type: DeckType {get}
    var total: Int {get}
    var trump: Suit? {get}
}

enum DeckType:Int, CaseIterable, Codable {
    case deck36 = 36
}

struct Deck: DeckBaseCompatible {

    //MARK: - Properties

    var cards = [Card]()
    var type: DeckType
    var trump: Suit?

    var total:Int {
        return type.rawValue
    }
}

extension Deck {

    init(with type: DeckType) {
        self.type = type
        cards = createDeck(suits: Suit.allCases, values: Value.allCases)
    }

    public func createDeck(suits:[Suit], values:[Value]) -> [Card] {
        var deck: [Card] = []
        for i in suits {
            for j in values {
                deck.append(Card(suit: i, value: j))
            }
        }
        return deck
    }

    public mutating func shuffle() {
        cards.shuffle()
    }

    public mutating func defineTrump() {
        if let cardOfTop = cards.first {
            trump = cardOfTop.suit
            setTrumpCards(for: cardOfTop.suit)
        }
    }

    public mutating func initialCardsDealForPlayers(players: [Player]) {
        if players.count < 7 {
            for player in players {
                player.hand = Array(cards[0..<6])
                cards.removeFirst(6)
            }
        }
    }

    public mutating func setTrumpCards(for suit:Suit) {
        for i in 0..<cards.count - 1 {
            if cards[i].suit == suit {
                cards[i].isTrump = true
            }
        }
    }
}

