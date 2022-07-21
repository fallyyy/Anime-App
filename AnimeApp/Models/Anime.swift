
//  AnimeApp
//
//  Created by  dollyally on 09.06.2022.
//

import Foundation

struct Constants {
    static let domain: String = "https://shikimori.one"
}

struct Title: Decodable {
    let name: String
    let russian: String
    let image: Image
    let status : String
    let episodes: Int
}

struct Image: Decodable {
    enum CodingKeys: String, CodingKey {
        case preview, original
    }
    
    let preview: String
    let original: String

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let previewAsset = try container.decode(String.self, forKey: .preview)
        let originalAsset = try container.decode(String.self, forKey: .original)
        preview = Constants.domain + previewAsset
        original = Constants.domain + originalAsset
    }
}
