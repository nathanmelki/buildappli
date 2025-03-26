import Foundation

struct GameSpec: Codable {
    var title: String
    var type: String // ex: "platformer", "quiz", etc.
    var player: String
    var enemies: [String]
    var levels: Int
    var theme: String
}
