//
//  GitPeople.swift
//  MyApi
//
//  Created by Mohammed on 10/11/1444 AH.
//

import SwiftUI


struct Response: Codable {
    var results: [People]
}
struct People: Codable {
    let count: Int
    let gender, name: String
    let probability: Double
}


struct GitPeople: View {
    @State var get = [People]()
    var body: some View {
        List(get , id: \.count){ g in
            Text(g.name)
            
        }.task {
            await loadData()
        }
    }
    
    
    func loadData() async {
        guard let url = URL(string: "https://api.genderize.io/?name[]=peter&name[]=lois&name[]=stevie") else {
            print("Invalid URL")
            return
        }
        
        do{
            let (data, _) = try await URLSession.shared.data(from: url)
            
            if let decoderLocation = try? JSONDecoder().decode(Response.self, from: data){
                get = decoderLocation.results
            }
            
        } catch{
            print("did not feach the data")
            
        }
    }
    
}

struct GitPeople_Previews: PreviewProvider {
    static var previews: some View {
        GitPeople()
    }
}
