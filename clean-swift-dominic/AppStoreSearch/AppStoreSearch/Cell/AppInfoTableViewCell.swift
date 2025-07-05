//
//  AppInfoTableViewCell.swift
//  AppStoreSearch
//
//  Created by 도미닉 on 6/29/25.
//

import UIKit

class AppInfoTableViewCell: UITableViewCell {
    let appIconListView = AppIconListView()
    let screenshotsPreviewView = ScreenshotsPreviewView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .black
        addSubview(appIconListView)
        addSubview(screenshotsPreviewView)
        appIconListView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview().inset(10)
            make.height.equalTo(80)
        }
        screenshotsPreviewView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(10)
            make.top.equalTo(appIconListView.snp.bottom)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        let appIconListinfo = AppIconListView.Info(
            artworkUrl512: "",
            sellerName: "",
            trackName: ""
        )
        appIconListView.configure(with: appIconListinfo)
        
        
    }
    
    func configure(model: Search.FetchAppInfos.ViewModel.DisplayedApp) {
        let appIconListinfo = AppIconListView.Info(
            artworkUrl512: model.artworkUrl512,
            sellerName: model.sellerName,
            trackName: model.trackName
        )
        appIconListView.configure(with: appIconListinfo)
        
        let width = UIScreen.main.bounds.width/3 - 20
        let height = width * 2
        let screenshotsPreviewInfo = ScreenshotsPreviewView.Info(
            images: model.screenshotUrls,
            imageSize: CGSize(width: width, height: height),
            type: .iphone
        )
        screenshotsPreviewView.configure(with: screenshotsPreviewInfo)
    }
}
