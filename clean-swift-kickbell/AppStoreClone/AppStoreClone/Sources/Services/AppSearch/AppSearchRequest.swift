//
//  AppSearchRequest.swift
//  AppStoreClone
//
//  Created by jc.kim on 9/20/23.
//

import Foundation

// 앱 검색 API 응답 모델
struct AppSearchResponseModel: Decodable {
    let resultCount: Int
    let results: [AppSearchResultModel]
}

// 앱 검색 결과 모델
struct AppSearchResultModel: Decodable {
    let screenshotUrls: [String]
    let ipadScreenshotUrls: [String]
    let artworkUrl512: String
    let languageCodesISO2A: [String]
    let contentAdvisoryRating: String
    let trackContentRating: String
    let sellerName: String
    let trackName: String
    let currentVersionReleaseDate: String
    let releaseNotes: String
    let version: String
    let description: String
    let artistName: String
    let genres: [String]
    let averageUserRating: Double
    let userRatingCount: Int64
}

// 앱 검색 요청 구현
struct AppSearchRequest: Request {
    typealias RequestDataType = AppSearchEndpoint
    typealias ResponseDataType = AppSearchResponseModel
    
    func makeRequest(from endpoint: AppSearchEndpoint) throws -> URLRequest {
        var urlComponents = URLComponents()
        urlComponents.scheme = endpoint.scheme
        urlComponents.host = endpoint.host
        urlComponents.path = endpoint.path
        urlComponents.queryItems = endpoint.queryItems
        
        guard let url = urlComponents.url else {
            throw NetworkError.invalidURL(url: urlComponents.url?.absoluteString)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.allHTTPHeaderFields = endpoint.header
        
        if let body = endpoint.body {
            request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
        }
        
        return request
    }
    
    func parseResponse(data: Data) throws -> AppSearchResponseModel {
        return try JSONDecoder().decode(AppSearchResponseModel.self, from: data)
    }
}
