import SwiftUI

struct TextBlockView: View {
    let text: String
    let theme: SmartMarkdownTheme

    var body: some View {
        Text(attributedText)
            .font(theme.textFont)
            .foregroundStyle(theme.textColor)
            .lineSpacing(4)
            .textSelection(.enabled)
            .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var attributedText: AttributedString {
        if let value = try? AttributedString(
            markdown: text,
            options: AttributedString.MarkdownParsingOptions(interpretedSyntax: .inlineOnlyPreservingWhitespace)
        ) {
            return value
        }
        return AttributedString(text)
    }
}
