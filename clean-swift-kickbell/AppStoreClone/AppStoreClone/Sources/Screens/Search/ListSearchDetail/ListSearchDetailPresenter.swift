//
//  ListSearchDetailPresenter.swift
//  AppStoreClone
//
//  Created by jc.kim on 6/25/25.
//

import UIKit

protocol ListSearchDetailPresentationLogic {
    func presentAppDetail(response: ListSearchDetail.ShowAppDetail.Response)
}

class ListSearchDetailPresenter: ListSearchDetailPresentationLogic {
    weak var viewController: ListSearchDetailDisplayLogic?
    
    // MARK: Presentation Logic
    
    func presentAppDetail(response: ListSearchDetail.ShowAppDetail.Response) {
        let viewModel = ListSearchDetail.ShowAppDetail.ViewModel(appData: response.appData)
        viewController?.displayAppDetail(viewModel: viewModel)
    }
}
