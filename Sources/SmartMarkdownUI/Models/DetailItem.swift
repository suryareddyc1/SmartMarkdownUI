import Foundation

public struct DetailItem: Identifiable, Equatable {
    public let id: String
    public let index: Int
    public let title: String
    public let fields: [MarkdownField]
    public let actionTitle: String?
    public let actionURL: URL?
    public let isInitiallyExpanded: Bool

    public init(
        id: String = UUID().uuidString,
        index: Int,
        title: String,
        fields: [MarkdownField],
        actionTitle: String? = nil,
        actionURL: URL? = nil,
        isInitiallyExpanded: Bool = true
    ) {
        self.id = id
        self.index = index
        self.title = title
        self.fields = fields
        self.actionTitle = actionTitle
        self.actionURL = actionURL
        self.isInitiallyExpanded = isInitiallyExpanded
    }
}
