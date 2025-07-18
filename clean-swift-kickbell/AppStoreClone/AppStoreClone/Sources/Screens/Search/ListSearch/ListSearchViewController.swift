//
//  ListSearchViewController.swift
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

protocol ListSearchDisplayLogic: AnyObject
{
  func displayUpdatedSearchQuery(viewModel: ListSearch.UpdateSearchQuery.ViewModel)
  func displaySearchResults(viewModel: ListSearch.PerformSearch.ViewModel)
}

class ListSearchViewController: UIViewController, ListSearchDisplayLogic, UISearchBarDelegate
{
  var interactor: ListSearchBusinessLogic?
  var router: (NSObjectProtocol & ListSearchRoutingLogic & ListSearchDataPassing)?

  // MARK: Object lifecycle
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
  {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    setup()
  }
  
  required init?(coder aDecoder: NSCoder)
  {
    super.init(coder: aDecoder)
    setup()
  }
  
  // MARK: Setup
  
  private func setup()
  {
    let viewController = self
    let interactor = ListSearchInteractor()
    let presenter = ListSearchPresenter()
    let router = ListSearchRouter()
    viewController.interactor = interactor
    viewController.router = router
    interactor.presenter = presenter
    presenter.viewController = viewController
    router.viewController = viewController
    router.dataStore = interactor
  }
  
  // MARK: Routing
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?)
  {
    if let scene = segue.identifier {
      let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
      if let router = router, router.responds(to: selector) {
        router.perform(selector, with: segue)
      }
    }
  }
  
  // MARK: Views
  
  private let searchController: UISearchController = {
    let searchControler = UISearchController(searchResultsController: nil)
    searchControler.searchBar.placeholder = "게임, 앱, 스토리 등"
    return searchControler
  }()
  
  let tableView: UITableView = {
    let tableView = UITableView()
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.separatorInset.right = 20
    tableView.register(headerFooterType: RecentSearchHeaderView.self)
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.reuseIdentifier)
    tableView.register(SearchedTableViewCell.self, forCellReuseIdentifier: SearchedTableViewCell.reuseIdentifier)
    return tableView
  }()
  
  private let activityIndicatorView: UIActivityIndicatorView = {
    let activityIndicatorView = UIActivityIndicatorView()
    activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
    activityIndicatorView.style = .large
    activityIndicatorView.hidesWhenStopped = true
    return activityIndicatorView
  }()
  
  // MARK: View lifecycle
  
  override func viewDidLoad()
  {
    super.viewDidLoad()
    setupUI()
    setupSubviews()
    setupConstraints()
  }
  
  // MARK: UI Setup
  
  private func setupUI() {
    navigationController?.navigationBar.prefersLargeTitles = true
    navigationItem.searchController = searchController
    navigationItem.hidesSearchBarWhenScrolling = false
    view.backgroundColor = .systemBackground
    title = "검색"
    
    // 테이블뷰 설정
    tableView.dataSource = self
    tableView.delegate = self
    searchController.searchBar.delegate = self
  }
  
  private func setupSubviews() {
    view.addSubview(tableView)
    view.addSubview(activityIndicatorView)
  }
  
  private func setupConstraints() {
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
      tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
      
      activityIndicatorView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      activityIndicatorView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
      activityIndicatorView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
      activityIndicatorView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
    ])
  }
  
  // MARK: Do something
  
  // 검색 관련 데이터 저장을 위한 변수
  private var recentSearchItems: [ListSearch.SearchDisplayItemDTO] = []
  private var searchResultItems: [ListSearch.SearchDisplayItemDTO] = []
  private var currentQuery: String = ""
  
  func displayUpdatedSearchQuery(viewModel: ListSearch.UpdateSearchQuery.ViewModel)
  {
    // 임시 구현 - 최근 검색어 표시
    self.recentSearchItems = viewModel.recentSearchItems
    self.searchResultItems = []
    
    // 테이블뷰 새로고침
    tableView.reloadData()
  }
  
  func displaySearchResults(viewModel: ListSearch.PerformSearch.ViewModel)
  {
    // 검색 결과 표시
    self.searchResultItems = viewModel.searchResultItems
    self.currentQuery = viewModel.query
    self.recentSearchItems = []
    
    // 검색 중 표시자 숨기기
    activityIndicatorView.stopAnimating()
    
    // 테이블뷰 새로고침
    tableView.reloadData()
  }
  
  // MARK: - UISearchBarDelegate
  
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    guard let searchText = searchBar.text else { return }
    let request = ListSearch.PerformSearch.Request(query: searchText)
    interactor?.performSearch(request: request)
  }
  
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    let request = ListSearch.UpdateSearchQuery.Request(query: searchText)
    interactor?.updateSearchQuery(request: request)
  }
}

extension ListSearchViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 검색 결과 또는 최근 검색어 중 표시할 항목 수 반환
        if !searchResultItems.isEmpty {
            return searchResultItems.count
        } else {
            return recentSearchItems.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 검색 결과가 있으면 검색 결과 표시, 없으면 최근 검색어 표시
        let item = !searchResultItems.isEmpty ? searchResultItems[indexPath.row] : recentSearchItems[indexPath.row]
        
        switch item.type {
        case let .app(data):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchedTableViewCell.reuseIdentifier) as? SearchedTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(with: data)
            cell.tapClosure = { [weak self] in
//                self?.router?.routeToAppDetail(segue: nil)
            }
            return cell
            
        case let .recent(text):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.reuseIdentifier) else {
                return UITableViewCell()
            }
            let searchText = self.searchController.searchBar.text ?? ""
            
            if searchText.isEmpty {
                cell.textLabel?.textColor = .systemBlue
                cell.imageView?.tintColor = .systemBlue
                cell.imageView?.image = nil
            } else {
                cell.textLabel?.textColor = .label
                cell.imageView?.tintColor = .label
                cell.imageView?.image = UIImage(systemName: "magnifyingglass")
            }
            
            cell.textLabel?.text = text
            return cell
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if !searchResultItems.isEmpty {
            return "검색 결과"
        } else if !recentSearchItems.isEmpty {
            return "최근 검색어"
        } else {
            return nil
        }
    }
    
    // 접근성 지원 추가
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if !searchResultItems.isEmpty, indexPath.row == 0 {
            UIAccessibility.post(
                notification: .announcement,
                argument: "\(currentQuery)에 대한 \(searchResultItems.count)개의 데이터가 로딩되었습니다."
            )
        }
    }
}

extension ListSearchViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        router?.routeToAppDetail(segue: nil)
    }
}


