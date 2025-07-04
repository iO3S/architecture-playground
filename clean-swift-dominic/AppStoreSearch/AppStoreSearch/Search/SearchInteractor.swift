//
//  SearchInteractor.swift
//  AppStoreSearch
//
//  Created by 도미닉 on 6/21/25.
//  Copyright (c) 2025 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol SearchBusinessLogic
{
    func fetchAppInfos(request: Search.FetchAppInfos.Request)
}

protocol SearchDataStore
{
    var searchModels: [SearchModel]? { get }
}

class SearchInteractor: SearchBusinessLogic, SearchDataStore
{
    var presenter: SearchPresentationLogic?
    var worker: SearchWorker = SearchWorker(appStore: AppsAPI())
    var searchModels: [SearchModel]?
    
    // MARK: Do something
    
    func fetchAppInfos(request: Search.FetchAppInfos.Request)
    {
        worker.fetchOrders(keyword: request.keyword) { searchModels in
            self.searchModels = searchModels
            let response = Search.FetchAppInfos.Response(apps: searchModels)
            self.presenter?.presentSomething(response: response)
        }
    }
}
