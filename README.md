# SmartMarkdownUI

A reusable Swift Package for rendering AI/backend markdown-like responses as native SwiftUI views.

It is designed for responses that contain normal markdown plus HTML-style expandable blocks like:

```html
<details open>
  <summary index='1'>1. Wadsworth Magnet School</summary>
  `OPP:` 111043
  `Status:` Lost
  [Open Details ↗️]
</details>
```

## Features

- SwiftUI native rendering
- iOS 17 compatible
- Parses markdown text with bold support
- Parses `<details>` and `<summary>` blocks
- Converts backtick key/value lines into rows
- Supports tip blocks starting with `💡`
- Supports custom styling through `SmartMarkdownTheme`
- Supports action callbacks for buttons like `[Open Details ↗️]`

## Installation

In Xcode:

1. File → Add Package Dependencies
2. Add your GitHub repo URL
3. Select the package product: `SmartMarkdownUI`

## Usage

```swift
import SwiftUI
import SmartMarkdownUI

struct ContentView: View {
    let response: String

    var body: some View {
        ScrollView {
            SmartMarkdownView(response) { item in
                print("Tapped: \(item.title)")
            }
            .padding()
        }
    }
}
```

## Custom Theme

```swift
let theme = SmartMarkdownTheme(
    cardCornerRadius: 20,
    badgeBackground: .purple,
    buttonColor: .purple,
    buttonBackground: .purple.opacity(0.12),
    blockSpacing: 12
)

SmartMarkdownView(response, theme: theme)
```

## Supported Blocks

| Input | Rendered As |
|---|---|
| Normal text | SwiftUI `Text` |
| `**bold**` | Attributed SwiftUI text |
| `<details>` | Expandable card |
| `<summary>` | Card title |
| `` `Key:` Value `` | Key-value row |
| `[Open Details ↗️]` | Button |
| `💡 text` | Tip callout |

## Suggested Backend Format

```markdown
I found **17 matching opportunity(s)** for Wadsworth.

<details searchresult="true" open>
<summary searchresult="true" index='1'>1. Wadsworth Magnet School</summary>

`OPP:` 111043
`Start Date:` 03/28/2025
`Status:` Lost

[Open Details ↗️]

</details>

You can refine by sales phase, owner, close date, or account.

💡 This opportunity has no expected revenue set.
```

Then add this package in another iOS app using the GitHub repo URL.

SmartMarkdownUI is available under the MIT license. See the LICENSE file for more info.
