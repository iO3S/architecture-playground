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
    let userRatingCount: Int
    let averageUserRating: Double
    let contentAdvisoryRating: String
    let trackContentRating: String
    let genres: [String]
    let artistName: String
    let languageCodesISO2A: [String]
    let version: String
    let currentVersionReleaseDate: String

    enum CodingKeys: String, CodingKey {
        case artistViewURL = "artistViewUrl"
        case artworkUrl60, artworkUrl100, isGameCenterEnabled, screenshotUrls, ipadScreenshotUrls, artworkUrl512, sellerName, trackName, userRatingCount, averageUserRating, contentAdvisoryRating, trackContentRating, genres, artistName, languageCodesISO2A, version, currentVersionReleaseDate
    }
}
