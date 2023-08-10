//
//  NewsItemArray.swift
//  NewsListApp
//
//  Created by Alexander Berezovsky on 08.08.2023.
//

import Foundation

public struct NewsItemArray: Decodable {
    var totalResults: Int
    var status: String
    var newsItems: [NewsItem]
    
    public init(from decoder: Decoder) throws {
        let rootContainer = try decoder.container(keyedBy: MetaCodingKeys.self)
        
        totalResults = try rootContainer.decode(Int.self, forKey: .totalResults)
        status = try rootContainer.decode(String.self, forKey: .status)

        newsItems = try rootContainer.decode([NewsItem].self, forKey: .articles)
        
        enum MetaCodingKeys: String, CodingKey {
            case status, totalResults, articles
        }
    }
}
