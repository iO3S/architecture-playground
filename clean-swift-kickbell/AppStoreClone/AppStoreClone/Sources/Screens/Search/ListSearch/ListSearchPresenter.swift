//
//  ListSearchPresenter.swift
//  AppStoreClone
//
//  Created by jc.kim on 6/25/25.
//  Copyright (c) 2025 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol ListSearchPresentationLogic
{
  func presentUpdatedSearchQuery(response: ListSearch.UpdateSearchQuery.Response)
  func presentSearchResults(response: ListSearch.PerformSearch.Response)
}

class ListSearchPresenter: ListSearchPresentationLogic
{
  weak var viewController: ListSearchDisplayLogic?
  
  // MARK: Do something
  
  // MARK: Search Query
  
  func presentUpdatedSearchQuery(response: ListSearch.UpdateSearchQuery.Response)
  {
    // 임시 구현 - 다음 단계에서 구현 예정
    let displayItems = response.filteredRecentSearches.map { recentSearch in
      ListSearch.SearchDisplayItemDTO(type: .recent(recentSearch))
    }
    
    let viewModel = ListSearch.UpdateSearchQuery.ViewModel(
      recentSearchItems: displayItems
    )
    
    viewController?.displayUpdatedSearchQuery(viewModel: viewModel)
  }
  
  // MARK: Search Results
  
  func presentSearchResults(response: ListSearch.PerformSearch.Response)
  {
    // 검색 결과를 SearchDisplayItemDTO로 변환
    let displayItems = response.searchResults.map { appSearchResultDTO in
      ListSearch.SearchDisplayItemDTO(type: .app(appSearchResultDTO))
    }
    
    // 검색 결과가 없는 경우 안내 메시지 추가 가능
    // 현재는 비어있는 배열만 전달
    
    let viewModel = ListSearch.PerformSearch.ViewModel(
      searchResultItems: displayItems,
      query: response.query
    )
    
    viewController?.displaySearchResults(viewModel: viewModel)
  }
}
