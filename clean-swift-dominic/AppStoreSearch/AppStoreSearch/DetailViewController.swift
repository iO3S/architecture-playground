//
//  DetailViewController.swift
//  AppStoreSearch
//
//  Created by 도미닉 on 7/5/25.
//  Copyright (c) 2025 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol DetailDisplayLogic: class
{
    func displaySomething(viewModel: Detail.Something.ViewModel)
}

class DetailViewController: UIViewController, DetailDisplayLogic
{
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let appIconDetailView = AppIconDetailView()
    private let appInfoDetailView = AppInfoDetailView()
    private let newFeatureView = NewFeatureView()
    private let releaseNoteView = ShowMoreView()
    private let screenshotsPreviewView = ScreenshotsPreviewView()
    private let descriptionView = ShowMoreView()
    private let subtitleView = SubtitleView()
    private lazy var stackView = UIStackView(arrangedSubviews: [
        appIconDetailView,
        ViewFactory.create(SeparatorView.self, direction: .horizontal),
        appInfoDetailView,
        ViewFactory.create(SeparatorView.self, direction: .horizontal),
        newFeatureView,
        releaseNoteView,
        ViewFactory.create(SeparatorView.self, direction: .horizontal),
        screenshotsPreviewView,
        ViewFactory.create(SeparatorView.self, direction: .horizontal),
        descriptionView,
        SpacerView(),
        subtitleView,
    ]).then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .vertical
        $0.distribution = .fill
        $0.spacing = 10
        $0.alignment = .fill
    }
    
    var interactor: DetailBusinessLogic?
    var router: (NSObjectProtocol & DetailRoutingLogic & DetailDataPassing)?
    
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
        let interactor = DetailInteractor()
        let presenter = DetailPresenter()
        let router = DetailRouter()
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
    
    // MARK: View lifecycle
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setAutoLayout()
        doSomething()
        view.backgroundColor = .black
    }
    
    private func setAutoLayout() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(stackView)
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        contentView.snp.makeConstraints { make in
            make.edges.width.equalToSuperview()
        }
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(20)
        }
        appIconDetailView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
        }
    }
    
    // MARK: Do something
    
    //@IBOutlet weak var nameTextField: UITextField!
    
    func doSomething()
    {
        let request = Detail.Something.Request()
        interactor?.doSomething(request: request)
        let appInfoContainerInfo = AppInfoDetailView.Info(
            userRatingCount: "3억5천",
            averageUserRating: 4.5,
            contentAdvisoryRating: "5세 이상",
            trackContentRating: "5위",
            genres: ["게임", "성인"],
            artistName: "도미닉",
            languageCodesISO2A: ["한국어", "영어"]
        )
        appInfoDetailView.info = appInfoContainerInfo
        
        let appIconContainerInfo = AppIconDetailView.Info(
            artworkUrl512: "https://littledeep.com/wp-content/uploads/2020/09/naver-icon-style.png",
            sellerName: "네이버 - NAVER",
            trackName: "NAVER Corp."
        )
        appIconDetailView.info = appIconContainerInfo
        
        let screenshotsPreviewInfo = ScreenshotsPreviewView.Info(
            images: ["https://is1-ssl.mzstatic.com/image/thumb/PurpleSource221/v4/1d/f4/87/1df48778-4b7b-3c26-e1b4-40c917d61283/Appstore_Preview_Plus_01.png/392x696bb.png", "https://is1-ssl.mzstatic.com/image/thumb/PurpleSource221/v4/73/a0/da/73a0daa5-51b4-69bd-58ed-bdfd91a96ed4/Appstore_Preview_Plus_02.png/392x696bb.png", "https://is1-ssl.mzstatic.com/image/thumb/PurpleSource211/v4/a0/83/16/a08316f7-b841-2ecc-c97c-49a1a5a2ec8e/Appstore_Preview_Plus_03.png/392x696bb.png", "https://is1-ssl.mzstatic.com/image/thumb/PurpleSource211/v4/e7/aa/1b/e7aa1b32-9f65-c3a8-cb69-a59a2774bee3/Appstore_Preview_Plus_03.png/392x696bb.png"],
            imageSize: CGSize(width: 250, height: 500),
            type: .iphone
        )
        screenshotsPreviewView.configure(with: screenshotsPreviewInfo)
        
        let subtitleInfo = SubtitleView.Info(title: "도미닉", subtitle: "개발자")
        subtitleView.info = subtitleInfo
    }
    
    func displaySomething(viewModel: Detail.Something.ViewModel)
    {
        //nameTextField.text = viewModel.name
    }
}

#Preview {
    DetailViewController()
}
