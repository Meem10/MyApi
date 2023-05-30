//
//  Warlock.swift
//  MyApi
//
//  Created by Mohammed on 10/11/1444 AH.
//

import SwiftUI

struct Warlock: View {
    @State var results = [Rick]()
    var body: some View {
        List(results, id: \.id) { item in
                    VStack(alignment: .leading) {
                        AsyncImage(url: URL(string:item.image))
                            .font(.headline)
                        Text(item.gender)
                    }
        }.task {
            await loadData()
        }
    }
    func loadData() async {
        guard let url = URL(string: "https://rickandmortyapi.com/api/character/") else {
            print("Invalid URL")
            return
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)

            if let decodedResponse = try? JSONDecoder().decode(Responsee.self, from: data) {
                results = decodedResponse.results
            }
        } catch {
            print("Invalid data")
        }
    }
}

struct Warlock_Previews: PreviewProvider {
    static var previews: some View {
        Warlock()
    }
}
