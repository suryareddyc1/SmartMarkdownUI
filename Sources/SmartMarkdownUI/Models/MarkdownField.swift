import Foundation

public struct MarkdownField: Identifiable, Equatable {
    public let id: String
    public let key: String
    public let value: String

    public init(id: String = UUID().uuidString, key: String, value: String) {
        self.id = id
        self.key = key
        self.value = value
    }
}
