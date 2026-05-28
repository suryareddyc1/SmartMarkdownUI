import SwiftUI

struct MarkdownBlockRenderer: View {
    let block: MarkdownBlock
    let theme: SmartMarkdownTheme
    let onActionTap: ((DetailItem) -> Void)?

    var body: some View {
        switch block {
        case .text(let text):
            TextBlockView(text: text, theme: theme)
        case .details(let item):
            DetailsBlockView(item: item, theme: theme, onActionTap: onActionTap)
        case .tip(let text):
            TipBlockView(text: text, theme: theme)
        case .divider:
            Divider()
        }
    }
}
