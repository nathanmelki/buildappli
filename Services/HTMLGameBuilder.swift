import Foundation

class HTMLGameBuilder {
    
    static func generateHTML(for spec: GameSpec) -> String {
        let enemiesJSArray = spec.enemies.map { "\"\($0)\"" }.joined(separator: ", ")

        let script = """
        <script>
        const config = {
            type: Phaser.AUTO,
            width: 800,
            height: 600,
            scene: {
                preload: preload,
                create: create
            }
        };
        const game = new Phaser.Game(config);

        function preload() {
            // Placeholder: add images later
        }

        function create() {
            this.add.text(100, 100, '🎮 \(spec.title)', { fontSize: '32px', fill: '#fff' });
            this.add.text(100, 150, '👤 Joueur : \(spec.player)', { fontSize: '24px', fill: '#ccc' });
            this.add.text(100, 200, '🌳 Thème : \(spec.theme)', { fontSize: '24px', fill: '#ccc' });
            this.add.text(100, 250, '🧱 Ennemis : \(spec.enemies.joined(separator: ", "))', { fontSize: '24px', fill: '#ccc' });
            this.add.text(100, 300, '🗺️ Niveaux : \(spec.levels)', { fontSize: '24px', fill: '#ccc' });
        }
        </script>
        """

        let html = """
        <!DOCTYPE html>
        <html>
        <head>
            <meta charset="UTF-8">
            <title>\(spec.title)</title>
            <script src="https://cdn.jsdelivr.net/npm/phaser@3/dist/phaser.js"></script>
        </head>
        <body style="margin:0;padding:0;background-color:black;color:white;">
            \(script)
        </body>
        </html>
        """

        return html
    }
}
