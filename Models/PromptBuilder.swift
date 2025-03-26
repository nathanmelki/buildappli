import Foundation

struct PromptBuilder {
    static func buildPrompt(from idea: GameIdea) -> String {
        return """
        Je veux créer un jeu basé sur cette idée : "\(idea.description)".
        Pose-moi les bonnes questions pour créer un jeu jouable 2D.
        Retourne-moi une réponse finale uniquement sous la forme d’un JSON structuré comme ceci :

        {
          "title": "Nom du jeu",
          "type": "platformer",
          "player": "dragon",
          "enemies": ["obstacle1", "obstacle2"],
          "levels": 3,
          "theme": "forêt"
        }
        """
    }
}
