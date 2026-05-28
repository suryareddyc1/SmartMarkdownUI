import SwiftUI

struct DetailsBlockView: View {
    let item: DetailItem
    let theme: SmartMarkdownTheme
    let onActionTap: ((DetailItem) -> Void)?

    @State private var isExpanded: Bool

    init(item: DetailItem, theme: SmartMarkdownTheme, onActionTap: ((DetailItem) -> Void)?) {
        self.item = item
        self.theme = theme
        self.onActionTap = onActionTap
        self._isExpanded = State(initialValue: item.isInitiallyExpanded)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Button {
                withAnimation(.spring(response: 0.25, dampingFraction: 0.9)) {
                    isExpanded.toggle()
                }
            } label: {
                HStack(spacing: 10) {
                    Text("\(item.index)")
                        .font(.system(size: 13, weight: .bold))
                        .foregroundStyle(theme.badgeForeground)
                        .frame(width: 26, height: 26)
                        .background(theme.badgeBackground)
                        .clipShape(Circle())

                    Text(item.title)
                        .font(theme.titleFont)
                        .foregroundStyle(theme.titleColor)
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    Image(systemName: "chevron.down")
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundStyle(.secondary)
                        .rotationEffect(.degrees(isExpanded ? 180 : 0))
                }
                .contentShape(Rectangle())
            }
            .buttonStyle(.plain)

            if isExpanded {
                VStack(alignment: .leading, spacing: 10) {
                    ForEach(item.fields) { field in
                        HStack(alignment: .top, spacing: 8) {
                            Text(field.key)
                                .font(theme.fieldKeyFont)
                                .foregroundStyle(theme.fieldKeyColor)
                                .frame(width: theme.fieldKeyWidth, alignment: .leading)

                            Text(field.value)
                                .font(theme.fieldValueFont)
                                .foregroundStyle(theme.fieldValueColor)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .textSelection(.enabled)
                        }
                    }

                    if let actionTitle = item.actionTitle {
                        Button {
                            onActionTap?(item)
                        } label: {
                            Text(actionTitle)
                                .font(theme.buttonFont)
                                .foregroundStyle(theme.buttonColor)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 10)
                                .background(theme.buttonBackground)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                        .padding(.top, 6)
                    }
                }
                .transition(.opacity.combined(with: .move(edge: .top)))
            }
        }
        .padding()
        .background(theme.cardBackground)
        .overlay(
            RoundedRectangle(cornerRadius: theme.cardCornerRadius)
                .stroke(theme.cardBorderColor, lineWidth: 1)
        )
        .clipShape(RoundedRectangle(cornerRadius: theme.cardCornerRadius))
    }
}
