//
//  SearchCoordinator.swift
//  ApoStoreClone
//
//  Created by ksmartech on 2023/09/19.
//

import UIKit

class SearchCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = ListSearchViewController()
        vc.tabBarItem = UITabBarItem(
            title: "검색",
            image: UIImage(systemName: "magnifyingglass"),
            tag: 4
        )
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let container = appDelegate.container
        
        // Clean Swift VIP 사이클 설정
        let interactor = ListSearchInteractor()
        let presenter = ListSearchPresenter()
        let router = ListSearchRouter()
        
        vc.interactor = interactor
        vc.router = router
        interactor.presenter = presenter
        presenter.viewController = vc
        router.viewController = vc
        
        navigationController.pushViewController(vc, animated: true)
    }


    
//    func start() {
//        let vc = SearchViewController()
//        vc.tabBarItem = UITabBarItem(
//            title: "검색",
//            image: UIImage(systemName: "magnifyingglass"),
//            tag: 4
//        )
//        vc.coordinator = self
//        vc.reactor = SearchReactor(
//            recentService: RecentSearchServiceImp(repository: UserDefaultService()),
//            appService: AppSearchServiceImp(network: NetworkImp())
//        )
//        navigationController.pushViewController(vc, animated: true)
//    }
    
    func didSelected(with target: SearchViewModel) {
        // 임시로 상세 화면 이동을 비활성화합니다.
        // 나중에 SearchDetailViewControler 주석 해제 후 다시 활성화할 예정
        print("Selected item: \(target)")
        // let searchDetailViewControler = SearchDetailViewControler()
        // searchDetailViewControler.configure(with: target)
        // navigationController.pushViewController(searchDetailViewControler, animated: true)
    }
}
