//
//  ListSearchDetailInteractor.swift
//  AppStoreClone
//
//  Created by jc.kim on 6/25/25.
//

import UIKit

protocol ListSearchDetailBusinessLogic {
    func showAppDetail(request: ListSearchDetail.ShowAppDetail.Request)
}

protocol ListSearchDetailDataStore {
    var appData: ListSearch.AppSearchResultDTO { get set }
}

class ListSearchDetailInteractor: ListSearchDetailBusinessLogic, ListSearchDetailDataStore {
    var presenter: ListSearchDetailPresentationLogic?
    
    // DataStore
    var appData: ListSearch.AppSearchResultDTO = ListSearch.AppSearchResultDTO()
    
    // MARK: Business Logic
    
    func showAppDetail(request: ListSearchDetail.ShowAppDetail.Request) {
        let response = ListSearchDetail.ShowAppDetail.Response(appData: appData)
        presenter?.presentAppDetail(response: response)
    }
}
