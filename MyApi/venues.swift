//
//  venues.swift
//  MyApi
//
//  Created by Mohammed on 10/11/1444 AH.
//

import SwiftUI

struct Hola: Codable , Identifiable {
    var id: String
    let venues: [Venue]
}

// MARK: - Venue
struct Venue: Codable {
    let id: Int
    let lat, lon: Double
    let category: Category
    let name: String
    let createdOn: Int
    let geolocationDegrees: String
    let promoted: Bool?

    enum CodingKeys: String, CodingKey {
        case id, lat, lon, category, name
        case createdOn = "created_on"
        case geolocationDegrees = "geolocation_degrees"
        case promoted
    }
}

enum Category: String, Codable {
    case atm = "atm"
    case attraction = "attraction"
    case cafe = "cafe"
    case categoriaPadrão = "Categoria: padrão"
    case categoryATM = "ATM"
    case categoryCategoryDefault = "Category: default"
    case categoryDefault = "default"
    case categoryGrocery = "Grocery"
    case educationalBusiness = "Educational Business"
    case food = "food"
    case grocery = "grocery"
    case lodging = "lodging"
    case nightlife = "nightlife"
    case retail = "retail"
    case services = "services"
    case shopping = "shopping"
    case sports = "sports"
    case transport = "transport"
    case travelAgency = "Travel Agency"
    case trezorRetailer = "trezor retailer"
}
    struct venues: View {
        @State private var a = [Hola]()
        var body: some View {
            VStack{
                List{
                    ForEach(a , id: \.id) { a in
                        
                    }
                }.task {
                    await loadData()
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
                
                if let decoderLocation = try? JSONDecoder().decode([Hola].self, from: data){
                    a = decoderLocation
                }
                
            } catch{
                print("did not feach the data")
                
            }
        }
    }
struct venues_Previews: PreviewProvider {
    static var previews: some View {
        venues()
    }
}
