//
//  YoutubeResponse.swift
//  SCBios
//
//  Created by Attapon Peungsook on 9/7/2562 BE.
//  Copyright © 2562 SCB. All rights reserved.
//

import Foundation

// MARK: - YoutubeResponse
struct YoutubeResponse: Codable {
    let youtubes: [Youtube]
    let error: Bool
    let errorMsg: String
    
    enum CodingKeys: String, CodingKey {
        case youtubes, error
        case errorMsg = "error_msg"
    }
}

// MARK: - Youtube
struct Youtube: Codable {
    let id, title, subtitle: String
    let avatarImage: String
    let youtubeImage: String
    
    enum CodingKeys: String, CodingKey {
        case id, title, subtitle
        case avatarImage = "avatar_image"
        case youtubeImage = "youtube_image"
    }
}
