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
    
    func configure() {
        let appIconListinfo = AppIconListView.Info(
            artworkUrl512: "https://littledeep.com/wp-content/uploads/2020/09/naver-icon-style.png",
            sellerName: "네이버 - NAVER",
            trackName: "NAVER Corp."
        )
        appIconListView.configure(with: appIconListinfo)
        
        let width = UIScreen.main.bounds.width/3 - 20
        let height = width * 2
        let screenshotsPreviewInfo = ScreenshotsPreviewView.Info(
            images: ["https://is1-ssl.mzstatic.com/image/thumb/PurpleSource221/v4/1d/f4/87/1df48778-4b7b-3c26-e1b4-40c917d61283/Appstore_Preview_Plus_01.png/392x696bb.png", "https://is1-ssl.mzstatic.com/image/thumb/PurpleSource221/v4/73/a0/da/73a0daa5-51b4-69bd-58ed-bdfd91a96ed4/Appstore_Preview_Plus_02.png/392x696bb.png", "https://is1-ssl.mzstatic.com/image/thumb/PurpleSource211/v4/a0/83/16/a08316f7-b841-2ecc-c97c-49a1a5a2ec8e/Appstore_Preview_Plus_03.png/392x696bb.png"],
            imageSize: CGSize(width: width, height: height),
            type: .iphone
        )
        screenshotsPreviewView.configure(with: screenshotsPreviewInfo)
    }
}
