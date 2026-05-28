import SwiftUI

public struct SmartMarkdownTheme {
    public let textFont: Font
    public let textColor: Color
    public let cardBackground: Color
    public let cardBorderColor: Color
    public let cardCornerRadius: CGFloat
    public let titleFont: Font
    public let titleColor: Color
    public let badgeBackground: Color
    public let badgeForeground: Color
    public let fieldKeyFont: Font
    public let fieldValueFont: Font
    public let fieldKeyColor: Color
    public let fieldValueColor: Color
    public let buttonFont: Font
    public let buttonColor: Color
    public let buttonBackground: Color
    public let tipBackground: Color
    public let tipTextColor: Color
    public let blockSpacing: CGFloat
    public let fieldKeyWidth: CGFloat

    public init(
        textFont: Font = .system(size: 15),
        textColor: Color = .primary,
        cardBackground: Color = Color(.secondarySystemBackground),
        cardBorderColor: Color = Color(.separator).opacity(0.25),
        cardCornerRadius: CGFloat = 14,
        titleFont: Font = .system(size: 15, weight: .semibold),
        titleColor: Color = .primary,
        badgeBackground: Color = .blue,
        badgeForeground: Color = .white,
        fieldKeyFont: Font = .system(size: 13, weight: .semibold),
        fieldValueFont: Font = .system(size: 13),
        fieldKeyColor: Color = .secondary,
        fieldValueColor: Color = .primary,
        buttonFont: Font = .system(size: 14, weight: .semibold),
        buttonColor: Color = .blue,
        buttonBackground: Color = Color.blue.opacity(0.12),
        tipBackground: Color = Color.yellow.opacity(0.18),
        tipTextColor: Color = .primary,
        blockSpacing: CGFloat = 16,
        fieldKeyWidth: CGFloat = 130
    ) {
        self.textFont = textFont
        self.textColor = textColor
        self.cardBackground = cardBackground
        self.cardBorderColor = cardBorderColor
        self.cardCornerRadius = cardCornerRadius
        self.titleFont = titleFont
        self.titleColor = titleColor
        self.badgeBackground = badgeBackground
        self.badgeForeground = badgeForeground
        self.fieldKeyFont = fieldKeyFont
        self.fieldValueFont = fieldValueFont
        self.fieldKeyColor = fieldKeyColor
        self.fieldValueColor = fieldValueColor
        self.buttonFont = buttonFont
        self.buttonColor = buttonColor
        self.buttonBackground = buttonBackground
        self.tipBackground = tipBackground
        self.tipTextColor = tipTextColor
        self.blockSpacing = blockSpacing
        self.fieldKeyWidth = fieldKeyWidth
    }
}

public extension SmartMarkdownTheme {
    static let `default` = SmartMarkdownTheme()

    static let compact = SmartMarkdownTheme(
        textFont: .system(size: 14),
        cardCornerRadius: 12,
        fieldKeyWidth: 110,
        blockSpacing: 10
    )
}
