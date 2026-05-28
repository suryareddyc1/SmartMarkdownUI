import SwiftUI

struct TipBlockView: View {
    let text: String
    let theme: SmartMarkdownTheme

    var body: some View {
        HStack(alignment: .top, spacing: 8) {
            Text("💡")
            Text(cleanText)
                .font(theme.textFont.weight(.medium))
                .foregroundStyle(theme.tipTextColor)
                .textSelection(.enabled)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(theme.tipBackground)
        .clipShape(RoundedRectangle(cornerRadius: theme.cardCornerRadius))
    }

    private var cleanText: String {
        text
            .replacingOccurrences(of: "💡", with: "")
            .trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
