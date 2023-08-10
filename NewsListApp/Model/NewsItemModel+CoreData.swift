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

public struct NewsItem: Decodable, Identifiable {//NSManagedObject, Codable {
    public var id: UUID?
    public var name: String?
    public var author: String?
    public var title: String?
    public var description: String
    public var url: String?
    public var urlToImage: String?
    public var publishedAt: Date?
    public var content: String?

    public init(from decoder: Decoder) throws {

        let values = try decoder.container(keyedBy: CodingKeys.self)

        author = try? values.decode(String.self, forKey: .author)
        title = try? values.decode(String.self, forKey: .title)
        description = try values.decode(String.self, forKey: .description)
        url = try? values.decode(String.self, forKey: .url)
        urlToImage = try? values.decode(String.self, forKey: .urlToImage)
        publishedAt = converDate(from: try? values.decode(String.self, forKey: .publishedAt))
        content = try? values.decode(String.self, forKey: .content)
        id = UUID()
    }
    
    enum CodingKeys: String, CodingKey {
        case source, id, name, author, title, description, url, urlToImage, publishedAt, content
    }
    
    private func converDate(from string: String? ) -> Date {
        var date = Date()
        guard string != nil else {
            return date
        }
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        date = dateFormatter.date(from: string!)!
        return date
    }
}

enum ContextError: Error {
    case NoContextFound
}

struct MetaData: Decodable {
    var id: UUID?
    var name: String
}
