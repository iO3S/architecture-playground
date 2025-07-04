//
//  SearchModel.swift
//  AppStoreSearch
//
//  Created by 도미닉 on 7/3/25.
//

import Foundation

// MARK: - SearchModel
struct SearchResult: Codable {
    let resultCount: Int
    let results: [SearchModel]
}

// MARK: - Result
struct SearchModel: Codable {
    let artistViewURL: String
    let artworkUrl60, artworkUrl100: String
    let isGameCenterEnabled: Bool
    let screenshotUrls, ipadScreenshotUrls: [String]
    let artworkUrl512: String
    let sellerName: String
    let trackName: String

    enum CodingKeys: String, CodingKey {
        case artistViewURL = "artistViewUrl"
        case artworkUrl60, artworkUrl100, isGameCenterEnabled, screenshotUrls, ipadScreenshotUrls, artworkUrl512, sellerName, trackName
    }
}
