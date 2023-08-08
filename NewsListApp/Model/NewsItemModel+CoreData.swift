//
//  NewsItemModel+CoreData.swift
//  NewsListApp
//
//  Created by Alexander Berezovsky on 08.08.2023.
//

import Foundation
import CoreData

@objc(NewsItem)
public class NewsItem: NSManagedObject, Codable {
    required convenience public init(from decoder: Decoder) throws {

        guard let context = decoder.userInfo[.context] as? NSManagedObjectContext else {
            throw ContextError.NoContextFound
        }
        self.init(context: context)

        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(UUID.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
        author = try values.decode(String.self, forKey: .author)
        title = try values.decode(String.self, forKey: .title)
        description = try values.decode(String.self, forKey: .description)
        url = try values.decode(String.self, forKey: .url)
        urlToImage = try values.decode(String.self, forKey: .urlToImage)
        publishedAt = try values.decode(Date.self, forKey: .publishedAt)
        content = try values.decode(String.self, forKey: .content)
    }
    
    public func encode(to encoder: Encoder) throws {
        var values = encoder.container(keyedBy: CodingKeys.self)

        try values.encode(id, forKey: .id)
        try values.encode(name, forKey: .name)
        try values.encode(author, forKey: .author)
        try values.encode(title, forKey: .title)
        try values.encode(description, forKey: .description)
        try values.encode(url, forKey: .url)
        try values.encode(urlToImage, forKey: .urlToImage)
        try values.encode(publishedAt, forKey: .publishedAt)
        try values.encode(content, forKey: .content)
    }
    
    enum CodingKeys: CodingKey {
        case id, name, author, title, description, url, urlToImage, publishedAt, content
    }
}

extension CodingUserInfoKey {
    static let context = CodingUserInfoKey(rawValue: "managedObjectContext")!
}

enum ContextError: Error {
    case NoContextFound
}
