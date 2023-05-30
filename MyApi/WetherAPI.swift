//
//  WetherAPI.swift
//  MyApi
//
//  Created by Mohammed on 09/11/1444 AH.
//

import SwiftUI


// MARK: - WelcomeElement
struct WelcomeElement: Codable , Identifiable {
    var id: String
    let date, localName, name: String
    let countryCode: CountryCode
    let fixed, global: Bool
    let counties: [String]?
    let launchYear: Int?
    let type: TypeEnum
}

enum CountryCode: String, Codable {
    case us = "US"
}

enum TypeEnum: String, Codable {
    case typeOptional = "Optional"
    case typePublic = "Public"
}

typealias Welcome = [WelcomeElement]


struct WetherAPI: View {
    @State var welcome = [WelcomeElement]()
    var body: some View {
        List{
            ForEach(welcome) { welcome in
                Text("\(welcome.date)")
                    .foregroundColor(.red)
                
            }
            
        }.task {
            await loadData()
        }
        
        
    }
    func loadData() async {
        guard let url = URL(string: "https://date.nager.at/api/v2/publicholidays/2020/US") else {
            print("Invalid URL")
            return
        }
        
        do{
            let (data, _) = try await URLSession.shared.data(from: url)
            
            if let decoderLocation = try? JSONDecoder().decode([WelcomeElement].self, from: data){
                welcome = decoderLocation
            }
            
        } catch{
            print("did not feach the data")
            
        }
    }
}
struct WetherAPI_Previews: PreviewProvider {
    static var previews: some View {
        WetherAPI()
    }
}
