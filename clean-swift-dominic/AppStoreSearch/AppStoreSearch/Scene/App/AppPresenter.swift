//
//  AppPresenter.swift
//  AppStoreSearch
//
//  Created by 도미닉 on 7/6/25.
//  Copyright (c) 2025 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol AppPresentationLogic
{
  func presentSomething(response: App.Something.Response)
}

class AppPresenter: AppPresentationLogic
{
  weak var viewController: AppDisplayLogic?
  
  // MARK: Do something
  
  func presentSomething(response: App.Something.Response)
  {
    let viewModel = App.Something.ViewModel()
    viewController?.displaySomething(viewModel: viewModel)
  }
}
