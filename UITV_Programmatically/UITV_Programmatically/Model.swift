//
//  Model.swift
//  UITV_Programmatically
//  https://youtu.be/t8sYKkST1gs - App Transport Security
//  Created by Uri on 5/12/22.
//

import Foundation

// MARK: - RemoteDataManager

class AmiiboAPI {
    
    static let shared = AmiiboAPI()
    
    func fetchAmiiboList(onCompletion: @escaping ([Amiibo]) -> ()) {
        let urlString = "https://www.amiiboapi.com/api/amiibo"
        let url = URL(string: urlString)!
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                print("data was nil")
                return
            }
            
            guard let amiiboList = try? JSONDecoder().decode(AmiiboList.self, from: data) else {
                print("Couldn't decode json")
                return
            }
            
            onCompletion(amiiboList.amiibo)
        }
        task.resume()
    }
}

// MARK: - Model
struct AmiiboList: Codable {
    let amiibo: [Amiibo]
}

struct Amiibo: Codable {
    let amiiboSeries: String
    let character: String
    let gameSeries: String
    let head: String
    let image: String
    let name: String
    let release: AmiiboRelease
    let tail: String
    let type: String
}

struct AmiiboRelease: Codable {
    let au: String?
    let eu: String?
    let jp: String?
    let na: String?
}
