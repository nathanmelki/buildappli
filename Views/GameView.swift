import SwiftUI
import WebKit

struct GameView: View {
    let htmlFileURL: URL
    
    var body: some View {
        WebView(url: htmlFileURL)
            .edgesIgnoringSafeArea(.all)
    }
}

struct WebView: UIViewRepresentable {
    let url: URL

    func makeUIView(context: Context) -> WKWebView {
        let webview = WKWebView()
        webview.scrollView.isScrollEnabled = false
        webview.configuration.preferences.javaScriptEnabled = true
        return webview
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.loadFileURL(url, allowingReadAccessTo: url.deletingLastPathComponent())
    }
}
