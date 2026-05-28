import Foundation

public enum MarkdownBlock: Identifiable, Equatable {
    case text(String)
    case details(DetailItem)
    case tip(String)
    case divider

    public var id: String {
        switch self {
        case .text(let value):
            return "text-\(value.hashValue)"
        case .details(let item):
            return item.id
        case .tip(let value):
            return "tip-\(value.hashValue)"
        case .divider:
            return "divider-\(UUID().uuidString)"
        }
    }
}
