
# 📱 Getting Started with SwiftUI for iOS – A Beginner’s Guide to Building an Auto-Refreshing Quotes App

---

## 🧭 1. Title & Objective

**Title:** Getting Started with SwiftUI for iOS – Building an Auto-Refreshing Quotes App  
**Chosen Technology:** SwiftUI  
**Why SwiftUI?**  
SwiftUI is Apple’s modern, declarative UI framework for building apps across iOS, macOS, watchOS, and tvOS. It’s beginner-friendly, intuitive, and provides real-time feedback through Xcode Previews — making it perfect for learning app development.

**End Goal:**  
To build and run a simple iOS app that fetches and displays random motivational quotes from a free public API, automatically refreshing every 10 seconds.

---

## 📘 2. Quick Summary of the Technology

**What is SwiftUI?**  
SwiftUI is a UI framework introduced by Apple in 2019 that allows developers to design user interfaces declaratively using Swift. It integrates state management directly into the UI layer, simplifying data-driven app development.

**Where It’s Used:**  
- iOS, macOS, watchOS, and tvOS app interfaces  
- Rapid prototyping and production apps  
- Educational and beginner projects  

**Real-world Example:**  
Many Apple native apps like **Weather** and **Reminders** use SwiftUI elements for their dynamic and responsive interfaces.

---

## ⚙️ 3. System Requirements

| Requirement | Description |
|--------------|--------------|
| **Operating System** | macOS (Ventura or newer recommended) |
| **IDE** | Xcode 15 or later |
| **Programming Language** | Swift 5.9+ |
| **Framework** | SwiftUI |
| **Device Target** | iPhone Simulator or Physical iOS Device |
| **Internet Connection** | Required for fetching quotes from API |

---

## 🧰 4. Installation & Setup Instructions

Follow these steps to create and run your first SwiftUI app.

### Step 1 – Install Xcode
- Download **Xcode** from the [Mac App Store](https://apps.apple.com/us/app/xcode/id497799835).  
- Ensure command line tools are installed:
  ```bash
  xcode-select --install
Step 2 – Create a New SwiftUI Project
Open Xcode → File → New → Project.

Choose iOS → App.

Name it: QuoteGen.

Interface: SwiftUI, Language: Swift.

Save the project and open it.

Press Run (⌘R) to verify that “Hello, world!” appears in the simulator.

🧪 5. Minimal Working Example
We’ll start with a “Hello World” example, then evolve it into an Auto-Refreshing Quote App.

🧱 Step 1: Hello World Example
swift
Copy code
import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Hello, SwiftUI!")
            .font(.title)
            .padding()
    }
}
✅ Expected Output:
A simple text label saying “Hello, SwiftUI!” appears in the center of the screen.

🧱 Step 2: Auto-Refreshing Random Quote App
Now let’s extend this into a motivational quotes app using the DummyJSON Quotes API.

API Response Example
json
Copy code
{
  "quotes": [
    {
      "id": 1,
      "quote": "Life isn't about getting and having, it's about giving and being.",
      "author": "Kevin Kruse"
    },
    {
      "id": 2,
      "quote": "Whatever the mind of man can conceive and believe, it can achieve.",
      "author": "Napoleon Hill"
    },
    {
      "id": 3,
      "quote": "Strive not to be a success, but rather to be of value.",
      "author": "Albert Einstein"
    }
  ],
  "total": 100,
  "skip": 0,
  "limit": 30
}
Full SwiftUI Code
swift
Copy code
import SwiftUI

struct Quote: Codable, Identifiable {
    let id: Int
    let quote: String
    let author: String
}

struct QuoteResponse: Codable {
    let quotes: [Quote]
}

struct ContentView: View {
    @State private var quote: Quote?
    @State private var timer: Timer?

    var body: some View {
        VStack(spacing: 20) {
            if let quote = quote {
                Text("“\(quote.quote)”")
                    .font(.title2)
                    .multilineTextAlignment(.center)
                    .padding()
                Text("- \(quote.author)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            } else {
                ProgressView("Fetching Quote...")
            }

            Text("Quotes refresh every 10 seconds ⏱️")
                .font(.footnote)
                .foregroundColor(.secondary)
        }
        .padding()
        .task {
            await fetchQuote()
            startAutoRefresh()
        }
        .onDisappear {
            timer?.invalidate()
        }
    }

    func fetchQuote() async {
        guard let url = URL(string: "https://dummyjson.com/quotes") else { return }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let response = try JSONDecoder().decode(QuoteResponse.self, from: data)
            withAnimation {
                quote = response.quotes.randomElement()
            }
        } catch {
            print("Error fetching quote: \(error)")
        }
    }

    func startAutoRefresh() {
        timer = Timer.scheduledTimer(withTimeInterval: 10, repeats: true) { _ in
            Task {
                await fetchQuote()
            }
        }
    }
}
✅ Expected Output:

The app loads a random quote when launched.

Every 10 seconds, a new quote automatically fades in.

Displays the author and note below the quote.

🤖 6. AI Prompt Journal
#    Prompt Used    AI Response Summary    Reflection
1    “Give me a step-by-step guide to build a SwiftUI Hello World app.”    Provided initial setup, Xcode instructions, and a SwiftUI example.    Helped me understand SwiftUI structure and previews.
2    “How to fetch JSON data from an API in SwiftUI using async/await.”    Explained URLSession and Codable with code example.    Simplified data handling using modern async/await syntax.
3    “How do I use Timer in SwiftUI to auto-refresh data?”    Demonstrated use of Timer.scheduledTimer and async tasks.    Enabled real-time quote refresh without manual reload.
4    “Why isn’t my SwiftUI view updating after data load?”    Pointed out missing @State and explained view reactivity.    Solved my issue with UI not refreshing after fetch.
5    “How can I animate content updates in SwiftUI?”    Introduced withAnimation for smooth transitions.    Improved UX with fade animations when quotes change.

⚠️ 7. Common Issues & Fixes
Issue    Description    Resolution
❌ No such module 'SwiftUI'    Created a UIKit app by mistake.    Recreate project with SwiftUI interface.
❌ API not loading    URL missing https://.    Use full endpoint: https://dummyjson.com/quotes.
❌ UI not updating    @State not used for reactive variables.    Added @State to track current quote.
❌ JSON decoding failed    Model didn’t match JSON keys.    Matched property names (quote, author, id).
❌ Timer stopped working    Timer deallocated too soon.    Retained Timer as a @State variable.

📚 8. References
Apple Developer – SwiftUI Documentation

Hacking with Swift – SwiftUI Quick Start

DummyJSON – Free Quotes API

Swift.org

Stack Overflow – SwiftUI Networking Examples

💾 9. Working Codebase Example
Example GitHub Repository:
https://github.com/yourusername/swiftui-capstone-quote-app

css
Copy code
swiftui-capstone-quote-app/
│
├── QuoteGen.xcodeproj
├── QuoteGen/
│   ├── ContentView.swift
│   ├── Quote.swift
│   └── Assets.xcassets/
├── README.md
└── capstone-swiftui-guide.md
🧠 10. Reflection on Using AI
Working with AI throughout this project provided clarity, instant feedback, and reduced learning friction.

Key Takeaways:
AI helped scaffold SwiftUI views and explain declarative UI design.

Debugging network and async issues became faster.

Using AI as a coding companion taught how to learn by asking — not just copying code.

However, I also learned that AI-generated responses must always be verified using official Apple documentation for correctness and best practices.

👤 Author
Name: Edwin Weru
Institution: Moringa School
Capstone: AI Learning Toolkit – SwiftUI
GitHub: @eduguru
