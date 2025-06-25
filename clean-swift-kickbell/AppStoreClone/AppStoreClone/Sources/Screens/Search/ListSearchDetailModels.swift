//
//  ListSearchDetailModels.swift
//  AppStoreClone
//
//  Created by jc.kim on 6/25/25.
//

import UIKit

enum ListSearchDetail {
    // MARK: Use cases
    
    enum ShowAppDetail {
        struct Request {
            // 요청 파라미터가 필요한 경우 여기에 추가
        }
        
        struct Response {
            let appData: ListSearch.AppSearchResultDTO
        }
        
        struct ViewModel {
            let appData: ListSearch.AppSearchResultDTO
            // 필요한 경우 추가 표시 데이터를 여기에 추가
        }
    }
}
