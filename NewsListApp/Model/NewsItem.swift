//
//  NewsItem.swift
//  NewsListApp
//
//  Created by Alexander Berezovsky on 08.08.2023.
//

import Foundation

public struct NewsItem: Decodable, Identifiable {
    public var id: UUID?
    public var sourceName: String?
    public var author: String?
    public var title: String?
    public var description: String
    public var url: String?
    public var urlToImage: String?
    public var publishedAt: Date?
    public var content: String?
//    public var source: SourceMaterial?

    public init(from decoder: Decoder) throws {

        let values = try decoder.container(keyedBy: CodingKeys.self)

        author = try? values.decode(String.self, forKey: .author)
        title = try? values.decode(String.self, forKey: .title)
        description = try values.decode(String.self, forKey: .description)
        url = try? values.decode(String.self, forKey: .url)
        urlToImage = try? values.decode(String.self, forKey: .urlToImage)
        publishedAt = converDate(from: try? values.decode(String.self, forKey: .publishedAt))
        content = try? values.decode(String.self, forKey: .content)
        let source = try values.decode(SourceMaterial.self, forKey: .source)
        sourceName = source.name
//        let sourceContainer = try values.nestedUnkeyedContainer(forKey: .source)
        
//        sourceName = try? sourceContainer.decode(String.self, forKey: .name)
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
