//
//  ContentView.swift
//  MyApi
//
//  Created by Mohammed on 09/11/1444 AH.
//

import SwiftUI



struct Post: Codable, Identifiable {
    let id: Int
    let title: String
    let body: String
}

struct ContentView: View {
    @State var mydata = [Post]()
    var body: some View{
        VStack{
         //   TinyRick()
            VStack{
                ForEach(mydata) { post in
                    Text(post.title)
                }
                
            }
            
        }
    }
    func loadData() async {
        guard let url = URL(string: "https://coinmap.org/api/v1/venues/") else {
            print("Invalid URL")
            return
        }
        
        do{
            let (data, _) = try await URLSession.shared.data(from: url)
            
            if let decoderLocation = try? JSONDecoder().decode([Post].self, from: data){
                mydata = decoderLocation
            }
            
        } catch{
            print("did not feach the data")
            
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
