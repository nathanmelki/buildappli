import SwiftUI

struct HomeView: View {
    @State private var ideaText: String = ""
    @State private var navigateToChat = false

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("🧠 Générateur de Jeu")
                    .font(.largeTitle)
                    .bold()

                TextField("Décris ton idée de jeu ici...", text: $ideaText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                NavigationLink(destination: ChatView(gameIdea: GameIdea(description: ideaText)), isActive: $navigateToChat) {
                    Button("Créer mon jeu") {
                        navigateToChat = true
                    }
                    .disabled(ideaText.isEmpty)
                    .padding()
                    .background(ideaText.isEmpty ? Color.gray : Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }

                Spacer()
            }
            .padding()
        }
    }
}
