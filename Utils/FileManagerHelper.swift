import Foundation

class FileManagerHelper {
    
    static func saveHTMLFile(content: String, fileName: String) -> URL? {
        let fileManager = FileManager.default
        guard let docsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return nil
        }
        
        let fileURL = docsURL.appendingPathComponent("\(fileName).html")
        
        do {
            try content.write(to: fileURL, atomically: true, encoding: .utf8)
            return fileURL
        } catch {
            print("❌ Erreur d'écriture du fichier HTML : \(error)")
            return nil
        }
    }
    
    static func getHTMLFileURL(fileName: String) -> URL? {
        let fileManager = FileManager.default
        guard let docsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return nil
        }
        let fileURL = docsURL.appendingPathComponent("\(fileName).html")
        return fileManager.fileExists(atPath: fileURL.path) ? fileURL : nil
    }
}
