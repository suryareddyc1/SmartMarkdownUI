import XCTest
@testable import SmartMarkdownUI

final class SmartMarkdownParserTests: XCTestCase {

    func testParsesDetailsBlocks() {
        let markdown = """
        I found **17 matching opportunity(s)** for Wadsworth.

        <details searchresult=\"true\" open><summary searchresult=\"true\" index='1'>1. Wadsworth Magnet School</summary>

        `OPP:` 111043

        `Start Date:` 03/28/2025

        `Status:` Lost

        [Open Details ↗️]

        </details>

        You can refine by sales phase, owner, close date, or account.

        💡 This opportunity has no expected revenue set.
        """

        let blocks = SmartMarkdownParser.parse(markdown)
        XCTAssertEqual(blocks.count, 4)

        guard case .details(let item) = blocks[1] else {
            XCTFail("Expected details block")
            return
        }

        XCTAssertEqual(item.index, 1)
        XCTAssertEqual(item.title, "Wadsworth Magnet School")
        XCTAssertEqual(item.fields.count, 3)
        XCTAssertEqual(item.fields[0].key, "OPP")
        XCTAssertEqual(item.fields[0].value, "111043")
        XCTAssertEqual(item.actionTitle, "Open Details ↗️")
        XCTAssertTrue(item.isInitiallyExpanded)
    }

    func testNormalizesEscapedNewLines() {
        let markdown = "Hello\\nWorld"
        let blocks = SmartMarkdownParser.parse(markdown)

        guard case .text(let text) = blocks.first else {
            XCTFail("Expected text block")
            return
        }

        XCTAssertEqual(text, "Hello\nWorld")
    }
}
