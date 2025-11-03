//
//  ContentView.swift
//  Capstone
//
//  Created by Edwin Weru on 03/11/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var quote: Quote?
    @State private var isLoading = false
    @State private var timer: Timer? // 👈 store reference to timer

    var body: some View {
        VStack(spacing: 20) {
            if let quote = quote {
                Text("“\(quote.quote)”")
                    .font(.headline)
                    .multilineTextAlignment(.center)
                    .padding()
                    .transition(.opacity)
                Text("- \(quote.author)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            } else {
                ProgressView("Fetching Quote...")
            }

            Button(action: {
                Task {
                    await fetchQuote()
                }
            }) {
                HStack {
                    Image(systemName: "arrow.triangle.2.circlepath")
                    Text("New Quote")
                }
            }
            .buttonStyle(.borderedProminent)
            .disabled(isLoading)

            Text("Quotes auto-refresh every 10 seconds ⏱️")
                .font(.footnote)
                .foregroundColor(.secondary)
                .padding(.top, 8)
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
        isLoading = true
        defer { isLoading = false }

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
        // Invalidate any existing timer first
        timer?.invalidate()

        // Schedule new timer to refresh every 10 seconds
        timer = Timer.scheduledTimer(withTimeInterval: 10, repeats: true) { _ in
            Task {
                await fetchQuote()
            }
        }
    }
}

#Preview {
    ContentView()
}
