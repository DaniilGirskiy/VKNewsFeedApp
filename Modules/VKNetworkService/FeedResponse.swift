//
//  FeedResponse.swift
//  Pods-VKNewsFeed
//
//  Created by Danya on 20.03.2020.
//

import Foundation

struct FeedResponseWrapped: Decodable {
    let response: FeedResponse
}

public struct FeedResponse: Decodable {
    public var items: [FeedItem]
    public var profiles: [Profile]
    public var groups: [Group]
}

// MARK: - FeedItem

public struct FeedItem: Decodable {
    public let sourceId: Int?
    public let postId: Int?
    public let text: String?
    public let date: Double?
    public let comments: CountableItem?
    public let likes: CountableItem?
    public let reposts: CountableItem?
    public let views: CountableItem?
    
    public let attachments: [Attachment]?
}

public struct Attachment: Decodable {
    public let photo: Photo?
}

public struct Photo: Decodable {
    private let sizes: [PhotoSize]
    
    public var height: Int {
        return getPropperSize().height
    }
    
    public var width: Int {
        return getPropperSize().width
    }
    
    public var url: String {
        return getPropperSize().url
    }
    
    private func getPropperSize() -> PhotoSize {
        if let sizeX = sizes.first(where: { $0.type == "x" }) {
            return sizeX
        } else if let maxSize = sizes.last{
             return maxSize
        } else {
            // никогда не сработает
            return PhotoSize(type: "wrong image", url: "wrong image", width: 0, height: 0)
        }
    }
}

public struct PhotoSize: Decodable {
    public let type: String
    public let url: String
    public let width: Int
    public let height: Int
}

extension FeedItem {
    enum CodingKeys: String, CodingKey {
        case source_id
        case post_id
        case text
        case date
        case comments
        case likes
        case reposts
        case views
        case attachments
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        sourceId = try values.decodeIfPresent(Int.self, forKey: .source_id)
        postId = try values.decodeIfPresent(Int.self, forKey: .post_id)
        text = try values.decodeIfPresent(String.self, forKey: .text)
        date = try values.decodeIfPresent(Double.self, forKey: .date)
        comments = try values.decodeIfPresent(CountableItem.self, forKey: .comments)
        likes = try values.decodeIfPresent(CountableItem.self, forKey: .likes)
        reposts = try values.decodeIfPresent(CountableItem.self, forKey: .reposts)
        views = try values.decodeIfPresent(CountableItem.self, forKey: .views)
        attachments = try values.decodeIfPresent([Attachment].self, forKey: .attachments)
    }
}

public struct CountableItem: Decodable {
    public let count: Int
}

// MARK: - Profile

public struct Profile: Decodable, SourceRepresentable {
    public let id: Int
    let firstName: String
    let lastName: String
    let photo100: String
    
    public var name: String { return firstName + " " + lastName }
    public var photo: String { return photo100 }
}

extension Profile {
    enum CodingKeys: String, CodingKey {
        case id
        case first_name
        case last_name
        case photo_100
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try values.decode(Int.self, forKey: .id)
        firstName = try values.decode(String.self, forKey: .first_name)
        lastName = try values.decode(String.self, forKey: .last_name)
        photo100 = try values.decode(String.self, forKey: .photo_100)
    }
}


// MARK: - Group

public struct Group: Decodable, SourceRepresentable {
    public let id: Int
    public let name: String
    let photo100: String
    
    public var photo: String { return photo100 }
}

extension Group {
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case photo_100
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try values.decode(Int.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
        photo100 = try values.decode(String.self, forKey: .photo_100)
    }
}


//MARK: - Protocols

public protocol SourceRepresentable {
    var id: Int { get }
    var name: String { get }
    var photo: String { get }
}
