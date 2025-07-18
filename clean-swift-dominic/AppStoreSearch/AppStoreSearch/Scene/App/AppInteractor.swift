//
//  AppInteractor.swift
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

protocol AppBusinessLogic
{
  func doSomething(request: App.Something.Request)
}

protocol AppDataStore
{
  //var name: String { get set }
}

class AppInteractor: AppBusinessLogic, AppDataStore
{
  var presenter: AppPresentationLogic?
  var worker: AppWorker?
  //var name: String = ""
  
  // MARK: Do something
  
  func doSomething(request: App.Something.Request)
  {
    worker = AppWorker()
    worker?.doSomeWork()
    
    let response = App.Something.Response()
    presenter?.presentSomething(response: response)
  }
}
