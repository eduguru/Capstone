# Capstone


---

## 🧾 **File 2: `README.md`**

```markdown
# 📱 SwiftUI Capstone – Quote Generator App

### 🌟 “Getting Started with SwiftUI for iOS – A Beginner’s Guide to Building a Simple Quotes App”

---

## 🧭 Overview

This project is part of the **AI Capstone Project** — a learning exercise on how to use **Generative AI** to explore and build with a new technology.

The project demonstrates:
- How to set up a **SwiftUI iOS app** from scratch.
- How to fetch and display **random motivational quotes** from a free public API.
- How to use **AI prompts** effectively for learning and debugging.

---

## 🎯 Project Objective

> Build and present a simple SwiftUI-based iOS app that displays random motivational quotes using the [DummyJSON Quotes API](https://dummyjson.com/quotes).

---

## ⚙️ System Requirements

| Requirement | Description |
|--------------|--------------|
| **Operating System** | macOS (Ventura or newer recommended) |
| **IDE** | Xcode 15 or later |
| **Language** | Swift 5.9+ |
| **Framework** | SwiftUI |
| **Device Target** | iPhone Simulator or physical device |
| **Internet** | Required for fetching API data |

---

## 🧰 Setup Instructions

1. **Install Xcode**
   - Download from the [Mac App Store](https://apps.apple.com/us/app/xcode/id497799835).
   - Verify installation with:
     ```bash
     xcode-select --install
     ```

2. **Create Project**
   - Open **Xcode** → **File** → **New Project** → **iOS → App**
   - Name it: `QuoteGen`
   - Interface: **SwiftUI**, Language: **Swift**

3. **Add the App Code**
   Replace your `ContentView.swift` with the following:

   ```swift
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

       var body: some View {
           VStack {
               if let quote = quote {
                   Text("“\(quote.quote)”")
                       .font(.headline)
                       .padding()
                   Text("- \(quote.author)")
                       .font(.subheadline)
                       .foregroundColor(.gray)
               } else {
                   ProgressView("Fetching Quote...")
               }
           }
           .padding()
           .task {
               await fetchQuote()
           }
       }

       func fetchQuote() async {
           guard let url = URL(string: "https://dummyjson.com/quotes") else { return }
           do {
               let (data, _) = try await URLSession.shared.data(from: url)
               let response = try JSONDecoder().decode(QuoteResponse.self, from: data)
               quote = response.quotes.randomElement()
           } catch {
               print("Error fetching quote: \(error)")
           }
       }
   }


Run the App

Press ⌘ + R or click the Run button in Xcode.

The app should display a random quote once loaded.

🧩 Project Structure
swiftui-capstone-quote-app/
│
├── QuoteGen.xcodeproj
├── QuoteGen/
│   ├── ContentView.swift
│   ├── Quote.swift
│   └── Assets.xcassets/
├── README.md
└── capstone-swiftui-guide.md

🧠 Learning with AI Prompts

During the project, AI was used to:

Learn SwiftUI’s layout and reactive state system.

Troubleshoot common build errors.

Simplify the process of decoding JSON using Codable.

Explore async/await for Swift concurrency.

Example Prompts:
Prompt    Purpose
“Give me a step-by-step guide to build a SwiftUI Hello World app.”    Understand SwiftUI basics
“How to fetch JSON data from an API using async/await in SwiftUI?”    Learn networking and data handling
“Explain why my SwiftUI view isn’t updating after data load.”    Fix state management issues
“How do I parse nested JSON in Swift Codable?”    Handle API responses like DummyJSON
⚠️ Common Issues & Fixes
Issue    Cause    Fix
No such module 'SwiftUI'    Selected UIKit template    Recreate project with Interface = SwiftUI
API not loading    URL missing https://    Added full API endpoint
UI doesn’t refresh    @State missing    Added @State property wrapper
Decoding failed    Wrong model fields    Matched JSON structure to quotes array
📸 Screenshot Example

You can add a screenshot here after running the app:

![App Screenshot](docs/screenshot.png)


(Place your image under a /docs/ folder or drag it into your repo.)

📚 References

Apple Developer – SwiftUI Docs

Hacking with Swift – SwiftUI Quick Start

DummyJSON – Quotes API

Swift.org

Stack Overflow – SwiftUI Networking Tips

🧾 License

This project is open source and available under the MIT License
.

👤 Author

Name: Edwin Weru
Institution: Moringa School
Capstone: AI Learning Toolkit – SwiftUI
GitHub: @eduguru
