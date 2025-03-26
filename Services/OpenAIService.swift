import Foundation

class OpenAIService {
    private let apiKey = Config.openAIKey
    private let endpoint = "https://api.openai.com/v1/chat/completions"
    
    func generateGameSpec(from idea: GameIdea, completion: @escaping (Result<GameSpec, Error>) -> Void) {
        let prompt = PromptBuilder.buildPrompt(from: idea)
        
        let requestBody: [String: Any] = [
            "model": "gpt-3.5-turbo",
            "messages": [
                ["role": "user", "content": prompt]
            ],
            "temperature": 0.7
        ]
        
        var request = URLRequest(url: URL(string: endpoint)!)
        request.httpMethod = "POST"
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: requestBody)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "EmptyResponse", code: -1)))
                return
            }
            
            do {
                let decoded = try JSONDecoder().decode(OpenAIResponse.self, from: data)
                guard let content = decoded.choices.first?.message.content else {
                    throw NSError(domain: "No content in response", code: -1)
                }
                
                if let jsonData = content.data(using: .utf8) {
                    let spec = try JSONDecoder().decode(GameSpec.self, from: jsonData)
                    completion(.success(spec))
                } else {
                    throw NSError(domain: "Invalid JSON encoding", code: -1)
                }
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}

struct OpenAIResponse: Codable {
    struct Choice: Codable {
        struct Message: Codable {
            let role: String
            let content: String
        }
        let message: Message
    }
    
    let choices: [Choice]
}
