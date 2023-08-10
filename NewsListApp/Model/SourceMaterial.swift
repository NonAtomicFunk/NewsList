//
//  SourceMaterial.swift
//  NewsListApp
//
//  Created by Alexander Berezovsky on 10.08.2023.
//

import Foundation

public struct SourceMaterial: Decodable {
//    var id: String?
    var name: String?
    
    public init(from decoder: Decoder) throws {
        let rootContainer = try decoder.container(keyedBy: CodingKeys.self)

//        id = try rootContainer.decode(String.self, forKey: .id)
        name = try rootContainer.decode(String.self, forKey: .name)

        enum CodingKeys: String, CodingKey {
            case id, name
        }
    }
}
