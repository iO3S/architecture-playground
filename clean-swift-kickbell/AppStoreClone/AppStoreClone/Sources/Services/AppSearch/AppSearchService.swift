//
//  AppSearchService.swift
//  AppStoreClone
//
//  Created by jc.kim on 9/20/23.
//

import Foundation
import RxSwift

// 앱 검색 서비스 프로토콜 - async/await 기반
protocol AppSearchServiceProtocol {
    func search(country: String, entity: String, limit: String, term: String) async throws -> [ListSearch.AppSearchResultDTO]
}

// 앱 검색 서비스 구현체
final class AppSearchServiceImp: AppSearchServiceProtocol {
    
    private let network: Network
    
    init(network: Network) {
        self.network = network
    }
    
    // 앱 검색 실행 메서드 - async/await 기반
    func search(country: String, entity: String, limit: String, term: String) async throws -> [ListSearch.AppSearchResultDTO] {
        // 기존 네트워크 인프라를 사용하여 비동기 요청 생성
        let request = AppSearchRequest()
        let endpoint = AppSearchEndpoint.apps(country: country, entity: entity, limit: limit, term: term)
        
        // 비동기 요청을 async/await로 변환
        return try await withCheckedThrowingContinuation { continuation in
            _ = network.send(request, endpoint)
                .subscribe(onNext: { response in
                    // 검색 결과를 DTO로 변환
                    let dtoResults = response.results.map { model -> ListSearch.AppSearchResultDTO in
                        return ListSearch.AppSearchResultDTO(
                            screenshotImages: model.screenshotUrls,
                            ipadScreenshotUrls: model.ipadScreenshotUrls,
                            artworkUrl512: model.artworkUrl512,
                            languageCodesISO2A: model.languageCodesISO2A,
                            contentAdvisoryRating: model.contentAdvisoryRating,
                            trackContentRating: model.trackContentRating,
                            sellerName: model.sellerName,
                            trackName: model.trackName,
                            currentVersionReleaseDate: model.trackName,
                            releaseNotes: model.releaseNotes,
                            version: model.version,
                            description:model.description,
                            artistName: model.artistName,
                            genres: model.genres,
                            averageUserRating: model.averageUserRating,
                            userRatingCount: "\(model.userRatingCount)"
                        )
                    }
                    continuation.resume(returning: dtoResults)
                }, onError: { error in
                    continuation.resume(throwing: error)
                })
        }
    }
}
