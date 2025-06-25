//
//  ListSearchDetailRouter.swift
//  AppStoreClone
//
//  Created by jc.kim on 6/25/25.
//

import UIKit

@objc protocol ListSearchDetailRoutingLogic {
    // 필요한 라우팅 메서드가 있다면 여기에 추가
}

protocol ListSearchDetailDataPassing {
    var dataStore: ListSearchDetailDataStore? { get }
}

class ListSearchDetailRouter: NSObject, ListSearchDetailRoutingLogic, ListSearchDetailDataPassing {
    weak var viewController: ListSearchDetailViewControler?
    var dataStore: ListSearchDetailDataStore?
    
    // MARK: Routing
    
    // 필요한 라우팅 메서드가 있다면 여기에 구현
    
    // MARK: Navigation
    
    // 필요한 네비게이션 메서드가 있다면 여기에 구현
    
    // MARK: Passing data
    
    // 필요한 데이터 전달 메서드가 있다면 여기에 구현
}
