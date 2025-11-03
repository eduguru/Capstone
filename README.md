# Capstone


---

# 📱 SwiftUI Capstone – Quote Generator App

### 🌟 “Getting Started with SwiftUI for iOS – A Beginner’s Guide to Building a Simple Quotes App”

---

## 🧭 Overview

This project is part of the **AI Capstone Project** — a guided learning journey using **Generative AI** to explore new technologies.

The app demonstrates:
- How to set up a **SwiftUI iOS app** from scratch.
- How to fetch and display **random motivational quotes** from a free public API.
- How to implement **auto-refreshing quotes** using a timer.
- How to use **AI prompts** effectively for learning, debugging, and iteration.

---

## 🎯 Project Objective

> Build and present a simple SwiftUI-based iOS app that displays random motivational quotes using the [DummyJSON Quotes API](https://dummyjson.com/quotes), with automatic quote refresh every 10 seconds.

---

## ⚙️ System Requirements

| Requirement | Description |
|--------------|--------------|
| **Operating System** | macOS (Ventura or newer recommended) |
| **IDE** | Xcode 15 or later |
| **Language** | Swift 5.9+ |
| **Framework** | SwiftUI |
| **Device Target** | iPhone Simulator or physical iOS device |
| **Internet** | Required for fetching API data |

---

## 🧰 Setup Instructions

### Step 1 – Install Xcode

Download Xcode from the [Mac App Store](https://apps.apple.com/us/app/xcode/id497799835).

Verify installation by running:

```bash
xcode-select --install
## Step 2 – Create a New SwiftUI Project
Open Xcode → File → New → Project → iOS → App

Name it: QuoteGen

Interface: SwiftUI

Language: Swift

Save and open the project.

Run it once to verify it displays “Hello, world!” in the simulator.

## Step 3 – Replace Code with the App Logic
Replace everything in your ContentView.swift file with the following:

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
                    .padding(.bottom)
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

## Step 4 – Run the App
Press ⌘ + R or click Run in Xcode.
Once the app launches, it will:

Fetch a random motivational quote.

Automatically refresh with a new quote every 10 seconds.

🧩 Project Structure
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
🧠 Learning with AI Prompts
During the build, AI assistance was used to:

Learn SwiftUI’s state-driven design system.

Fix async/await and networking errors.

Implement auto-refresh using timers.

Refine UI layout and text styling.

Example Prompts
Prompt    Purpose
“Give me a step-by-step guide to build a SwiftUI Hello World app.”    Understand SwiftUI basics
“How to fetch JSON data from an API using async/await in SwiftUI?”    Learn networking in Swift
“How do I use Timer in SwiftUI to auto-refresh data?”    Implement timed updates
“Why isn’t my SwiftUI view updating after fetching data?”    Debug state refresh issues

⚠️ Common Issues & Fixes
Issue    Cause    Fix
❌ No such module 'SwiftUI'    Chose UIKit template    Recreate project with SwiftUI interface
❌ API not loading    Missing https:// in URL    Use https://dummyjson.com/quotes
❌ UI not updating    Missing @State wrapper    Use @State to trigger re-renders
❌ JSON decoding failed    Model mismatch    Match API keys: quote, author, id
❌ Timer not working    Timer not retained    Store Timer in @State variable

📸 Screenshot Example
Add a screenshot of your running app here:

markdown
Copy code
![App Screenshot](docs/screenshot.png)
(Place your image in a /docs/ folder inside your repo.)

📚 References
Apple Developer – SwiftUI Documentation

Hacking with Swift – SwiftUI Quick Start

DummyJSON – Quotes API

Swift.org

Stack Overflow – SwiftUI Networking Tips

🧾 License
This project is open-source and available under the MIT License.

👤 Author
Name: Edwin Weru
Institution: Moringa School
Capstone: AI Learning Toolkit – SwiftUI
GitHub: @eduguru
