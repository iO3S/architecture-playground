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
    let trackId: Int
    let trackName: String
    let description: String
    let artistName: String
    let averageUserRating: Float
    let screenshotUrls: [String]
    let artworkUrl100: String
    let formattedPrice: String
    let genres: [String]
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
