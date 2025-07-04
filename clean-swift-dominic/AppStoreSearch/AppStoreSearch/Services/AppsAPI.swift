//
//  AppsAPI.swift
//  AppStoreSearch
//
//  Created by 도미닉 on 7/4/25.
//

import Foundation

class AppsAPI: AppStoreProtocol
{
    func fetchOrders(completionHandler: @escaping (() throws -> [SearchModel]) -> Void) {
        if let url = URL(string: "https://itunes.apple.com/search?term=네이버&country=kr&entity=software") {
            let task = loadAppsInfo(url: url) { searchModels in
                completionHandler { return searchModels }
            }
            task.resume()
        }
    }
    
    func loadAppsInfo(url: URL, completion: @escaping ([SearchModel]) -> Void) -> URLSessionDataTask {
        let task = URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else {
                completion([])
                return
            }
            if let json = try? JSONDecoder().decode(SearchResult.self, from: data) {
                completion(json.results)
            }
        }
        return task
    }
}
