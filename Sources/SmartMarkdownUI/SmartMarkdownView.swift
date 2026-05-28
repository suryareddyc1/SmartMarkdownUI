import SwiftUI

public struct SmartMarkdownView: View {
    private let blocks: [MarkdownBlock]
    private let theme: SmartMarkdownTheme
    private let onActionTap: ((DetailItem) -> Void)?

    public init(
        _ markdown: String,
        theme: SmartMarkdownTheme = .default,
        onActionTap: ((DetailItem) -> Void)? = nil
    ) {
        self.blocks = SmartMarkdownParser.parse(markdown)
        self.theme = theme
        self.onActionTap = onActionTap
    }

    public init(
        blocks: [MarkdownBlock],
        theme: SmartMarkdownTheme = .default,
        onActionTap: ((DetailItem) -> Void)? = nil
    ) {
        self.blocks = blocks
        self.theme = theme
        self.onActionTap = onActionTap
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: theme.blockSpacing) {
            ForEach(blocks) { block in
                MarkdownBlockRenderer(
                    block: block,
                    theme: theme,
                    onActionTap: onActionTap
                )
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
