//
//  ContentView.swift
//  Capstone
//
//  Created by Edwin Weru on 03/11/2025.
//

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


#Preview {
    ContentView()
}
