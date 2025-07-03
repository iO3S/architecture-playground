//
//  AppInfoTableViewCell.swift
//  AppStoreSearch
//
//  Created by 도미닉 on 6/29/25.
//

import UIKit

class AppInfoTableViewCell: UITableViewCell {
    let appIconListView = AppIconListView()
    let screenshotPreviewView = ScreenshotsPreviewView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(appIconListView)
        addSubview(screenshotPreviewView)
        appIconListView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
        }
        screenshotPreviewView.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalToSuperview()
            make.top.equalTo(appIconListView)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
