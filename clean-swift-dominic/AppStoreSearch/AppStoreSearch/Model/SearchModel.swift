//
//  SearchModel.swift
//  AppStoreSearch
//
//  Created by 도미닉 on 7/3/25.
//

import Foundation

// MARK: - SearchModel
struct SearchModel: Codable {
    let resultCount: Int
    let results: [Result]
}

// MARK: - Result
struct Result: Codable {
    let artistViewURL: String
    let artworkUrl60, artworkUrl100: String
    let isGameCenterEnabled: Bool
    let screenshotUrls, ipadScreenshotUrls: [String]
    let artworkUrl512: String
    let supportedDevices: [String]

    enum CodingKeys: String, CodingKey {
        case artistViewURL = "artistViewUrl"
        case artworkUrl60, artworkUrl100, isGameCenterEnabled, screenshotUrls, ipadScreenshotUrls, artworkUrl512, supportedDevices
    }
}
