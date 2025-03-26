import SwiftUI

struct ChatView: View {
    let gameIdea: GameIdea
    @State private var isLoading = true
    @State private var gameSpec: GameSpec?
    @State private var errorMessage: String?

    var body: some View {
        VStack {
            if isLoading {
                ProgressView("Génération du jeu...")
                    .onAppear {
                        generateGame()
                    }
            } else if let spec = gameSpec {
                Text("✅ Jeu généré : \(spec.title)")
                    .font(.title2)
                    .padding()

                if let html = HTMLGameBuilder.generateHTML(for: spec),
                   let fileURL = FileManagerHelper.saveHTMLFile(content: html, fileName: "generatedGame") {
                    NavigationLink("Jouer", destination: GameView(htmlFileURL: fileURL))
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            } else if let error = errorMessage {
                Text("❌ Erreur : \(error)")
            }

            Spacer()
        }
        .padding()
        .navigationTitle("Création IA")
    }

    func generateGame() {
        OpenAIService().generateGameSpec(from: gameIdea) { result in
            DispatchQueue.main.async {
                isLoading = false
                switch result {
                case .success(let spec):
                    self.gameSpec = spec
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
