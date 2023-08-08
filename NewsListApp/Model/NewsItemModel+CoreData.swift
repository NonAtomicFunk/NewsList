//
//  NewsItemModel+CoreData.swift
//  NewsListApp
//
//  Created by Alexander Berezovsky on 08.08.2023.
//

import Foundation
//import CoreData

//@objc(NewsItem)
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

public struct NewsItem: Decodable {//NSManagedObject, Codable {
    public var id: UUID?
    public var name: String?
    public var author: String?
    public var title: String?
    public var description: String
    public var url: String?
    public var urlToImage: String?
    public var publishedAt: String?
    public var content: String?

    public init(from decoder: Decoder) throws {

        let values = try decoder.container(keyedBy: CodingKeys.self)

        author = try? values.decode(String.self, forKey: .author)
        title = try? values.decode(String.self, forKey: .title)
        description = try values.decode(String.self, forKey: .description)
        url = try? values.decode(String.self, forKey: .url)
        urlToImage = try? values.decode(String.self, forKey: .urlToImage)
        publishedAt = try? values.decode(String.self, forKey: .publishedAt)
        content = try? values.decode(String.self, forKey: .content)
    }
    
    enum CodingKeys: String, CodingKey {
        case source, id, name, author, title, description, url, urlToImage, publishedAt, content
    }
}

enum ContextError: Error {
    case NoContextFound
}

struct MetaData: Decodable {
    var id: UUID?
    var name: String
}
