import Foundation

public enum SmartMarkdownParser {

    public static func parse(_ rawText: String) -> [MarkdownBlock] {
        let text = normalize(rawText)
        var blocks: [MarkdownBlock] = []

        let intro = extractIntro(from: text)
        if !intro.isEmpty {
            blocks.append(.text(intro))
        }

        let details = extractDetails(from: text)
        blocks.append(contentsOf: details.map { .details($0) })

        let footer = extractFooter(from: text)
        if !footer.isEmpty {
            blocks.append(.text(footer))
        }

        let tip = extractTip(from: text)
        if !tip.isEmpty {
            blocks.append(.tip(tip))
        }

        if blocks.isEmpty, !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            blocks.append(.text(text.trimmingCharacters(in: .whitespacesAndNewlines)))
        }

        return blocks
    }

    public static func normalize(_ text: String) -> String {
        text
            .replacingOccurrences(of: "\\n", with: "\n")
            .replacingOccurrences(of: "\\\"", with: "\"")
            .replacingOccurrences(of: "\r\n", with: "\n")
    }

    private static func extractIntro(from text: String) -> String {
        guard let firstDetailsRange = text.range(of: "<details", options: [.caseInsensitive]) else {
            return removeTip(from: text).trimmingCharacters(in: .whitespacesAndNewlines)
        }

        return String(text[..<firstDetailsRange.lowerBound])
            .trimmingCharacters(in: .whitespacesAndNewlines)
    }

    private static func extractDetails(from text: String) -> [DetailItem] {
        let pattern = #"<details([^>]*)>[\s\S]*?<summary([^>]*)>(.*?)</summary>([\s\S]*?)</details>"#
        guard let regex = try? NSRegularExpression(pattern: pattern, options: [.caseInsensitive]) else {
            return []
        }

        let nsText = text as NSString
        let matches = regex.matches(in: text, range: NSRange(location: 0, length: nsText.length))

        return matches.enumerated().compactMap { offset, match in
            guard match.numberOfRanges >= 5 else { return nil }

            let detailsAttributes = nsText.substring(with: match.range(at: 1))
            let summaryAttributes = nsText.substring(with: match.range(at: 2))
            let summaryText = nsText.substring(with: match.range(at: 3))
            let bodyText = nsText.substring(with: match.range(at: 4))

            let index = extractIndex(from: summaryAttributes) ?? extractLeadingIndex(from: summaryText) ?? offset + 1
            let title = cleanTitle(summaryText)
            let fields = extractFields(from: bodyText)
            let action = extractAction(from: bodyText)
            let isOpen = detailsAttributes.localizedCaseInsensitiveContains("open")

            return DetailItem(
                id: "details-\(index)-\(title.hashValue)",
                index: index,
                title: title,
                fields: fields,
                actionTitle: action.title,
                actionURL: action.url,
                isInitiallyExpanded: isOpen
            )
        }
    }

    private static func extractFields(from text: String) -> [MarkdownField] {
        let pattern = #"`([^`]+)`\s*([^\n]+)"#
        guard let regex = try? NSRegularExpression(pattern: pattern) else {
            return []
        }

        let nsText = text as NSString
        let matches = regex.matches(in: text, range: NSRange(location: 0, length: nsText.length))

        return matches.compactMap { match in
            guard match.numberOfRanges >= 3 else { return nil }

            let key = nsText.substring(with: match.range(at: 1))
                .trimmingCharacters(in: .whitespacesAndNewlines)
                .trimmingCharacters(in: CharacterSet(charactersIn: ":"))

            let value = nsText.substring(with: match.range(at: 2))
                .trimmingCharacters(in: .whitespacesAndNewlines)

            guard !key.isEmpty, !value.isEmpty else { return nil }

            return MarkdownField(id: "field-\(key)-\(value.hashValue)", key: key, value: value)
        }
    }

    private static func extractAction(from text: String) -> (title: String?, url: URL?) {
        let linkedPattern = #"\[([^\]]+)\]\(([^\)]+)\)"#
        if let match = firstMatch(pattern: linkedPattern, in: text), match.count >= 3 {
            return (match[1], URL(string: match[2]))
        }

        let plainPattern = #"\[([^\]]+)\]"#
        if let match = firstMatch(pattern: plainPattern, in: text), match.count >= 2 {
            return (match[1], nil)
        }

        return (nil, nil)
    }

    private static func extractFooter(from text: String) -> String {
        guard let lastDetailsRange = text.range(of: "</details>", options: [.backwards, .caseInsensitive]) else {
            return ""
        }

        let afterDetails = String(text[lastDetailsRange.upperBound...])
        let lines = afterDetails
            .components(separatedBy: .newlines)
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .filter { !$0.isEmpty && !$0.hasPrefix("💡") }

        return lines.first ?? ""
    }

    private static func extractTip(from text: String) -> String {
        text
            .components(separatedBy: .newlines)
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .first(where: { $0.hasPrefix("💡") }) ?? ""
    }

    private static func removeTip(from text: String) -> String {
        text
            .components(separatedBy: .newlines)
            .filter { !$0.trimmingCharacters(in: .whitespacesAndNewlines).hasPrefix("💡") }
            .joined(separator: "\n")
    }

    private static func extractIndex(from summaryAttributes: String) -> Int? {
        let pattern = #"index\s*=\s*['\"]?(\d+)['\"]?"#
        guard let match = firstMatch(pattern: pattern, in: summaryAttributes), match.count >= 2 else {
            return nil
        }
        return Int(match[1])
    }

    private static func extractLeadingIndex(from summary: String) -> Int? {
        let pattern = #"^\s*(\d+)\."#
        guard let match = firstMatch(pattern: pattern, in: summary), match.count >= 2 else {
            return nil
        }
        return Int(match[1])
    }

    private static func cleanTitle(_ title: String) -> String {
        title
            .replacingOccurrences(of: #"^\s*\d+\.\s*"#, with: "", options: .regularExpression)
            .replacingOccurrences(of: "&amp;", with: "&")
            .replacingOccurrences(of: "&lt;", with: "<")
            .replacingOccurrences(of: "&gt;", with: ">")
            .trimmingCharacters(in: .whitespacesAndNewlines)
    }

    private static func firstMatch(pattern: String, in text: String) -> [String]? {
        guard let regex = try? NSRegularExpression(pattern: pattern, options: [.caseInsensitive]) else {
            return nil
        }

        let nsText = text as NSString
        guard let match = regex.firstMatch(in: text, range: NSRange(location: 0, length: nsText.length)) else {
            return nil
        }

        var values: [String] = []
        for index in 0..<match.numberOfRanges {
            let range = match.range(at: index)
            if range.location != NSNotFound {
                values.append(nsText.substring(with: range))
            } else {
                values.append("")
            }
        }
        return values
    }
}
