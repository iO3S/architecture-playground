//
//  ListSearchRouter.swift
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

@objc protocol ListSearchRoutingLogic
{
  func routeToAppDetail(segue: UIStoryboardSegue?)
}

protocol ListSearchDataPassing
{
  var dataStore: ListSearchDataStore? { get }
}

class ListSearchRouter: NSObject, ListSearchRoutingLogic, ListSearchDataPassing
{
  weak var viewController: ListSearchViewController?
  var dataStore: ListSearchDataStore?
  
  // MARK: Routing
  
  func routeToAppDetail(segue: UIStoryboardSegue?)
  {
      let destinationVC = ListSearchDetailViewControler()
      var destinationDS = destinationVC.router!.dataStore!
      passDataToAppDetail(source: dataStore!, destination: &destinationDS)
      navigateToAppDetail(source: viewController!, destination: destinationVC)
  }

  // MARK: Navigation
  
  func navigateToAppDetail(source: ListSearchViewController, destination: ListSearchDetailViewControler)
  {
      source.navigationController?.pushViewController(destination, animated: true)
  }
  
  // MARK: Passing data
  
  func passDataToAppDetail(source: ListSearchDataStore, destination: inout ListSearchDetailDataStore)
  {
      let selectedRow = viewController?.tableView.indexPathForSelectedRow?.row
      destination.searchResults = source.searchResults[selectedRow!]
  }
}
