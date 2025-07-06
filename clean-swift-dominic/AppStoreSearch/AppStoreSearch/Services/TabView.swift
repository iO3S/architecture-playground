//
//  TabView.swift
//  AppStoreSearch
//
//  Created by 도미닉 on 7/6/25.
//

import UIKit

enum TabView: Int, CaseIterable {
    case Today
    case Game
    case App
    case Arcade
    case Search
    
    var viewController: UIViewController {
        switch self {
        case .Today:
            return TodayViewController()
        case .Game:
            return GameViewController(nibName: nil, bundle: nil)
        case .App:
            return AppViewController(nibName: nil, bundle: nil)
        case .Arcade:
            return ArcadeViewController(nibName: nil, bundle: nil)
        case .Search:
            return SearchViewController()
        }
    }
    
    var title: String {
        switch self {
        case .Today: return "투데이"
        case .Game: return "게임"
        case .App: return "앱"
        case .Arcade: return "Arcade"
        case .Search: return "검색"
        }
    }

    // 탭 바 아이템의 이미지 (선택 사항)
    var icon: UIImage? {
        switch self {
        case .Today: return UIImage(systemName: "newspaper.fill")
        case .Game: return UIImage(systemName: "gamecontroller.fill")
        case .App: return UIImage(systemName: "app.fill")
        case .Arcade: return UIImage(systemName: "arcade.stick.console.fill")
        case .Search: return UIImage(systemName: "magnifyingglass")
        }
    }
    
    func makeNavigationViewController() -> UINavigationController {
        viewController.title = title
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.tabBarItem = UITabBarItem(title: title, image: icon, tag: rawValue)
        return navigationController
    }
}
