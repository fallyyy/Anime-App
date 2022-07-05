//
//  Brawlers.swift
//  CharactersList
//
//  Created by  dollyally on 09.06.2022.
//

import Foundation

struct Anime: Decodable {
    let list: [Titles]
}

struct Titles: Decodable {
    let name: String
    let russian: String
    let preview: String
    let status : String
    let episodes: Int
}

//struct Rarity: Decodable {
//    enum CodingKeys: String, CodingKey {
//        case id, name
//        case hexColorString = "color"
//    }
//
//    let id: Int
//    let name: String
//    let hexColorString: String
//}


// JSON EXAMPLE:
//{
//    "name": "Blablabla",
//    "age": 20
//}

//struct Example: Decodable {
//    enum CodingKeys: String, CodingKey {
//        case someName = "name"
//        case age
//    }
//
//    let someName: String
//    let age: Int
//
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        someName = try container.decode(String.self, forKey: .someName)
//        age = try container.decode(Int.self, forKey: .age)
//    }
//}
