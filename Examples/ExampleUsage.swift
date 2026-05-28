import SwiftUI
import SmartMarkdownUI

struct ExampleUsageView: View {
    let backendResponse: String

    var body: some View {
        ScrollView {
            SmartMarkdownView(backendResponse, theme: .default) { selectedItem in
                print("Open details tapped for: \(selectedItem.title)")
                print("URL: \(selectedItem.actionURL?.absoluteString ?? "No URL")")
            }
            .padding()
        }
    }
}
