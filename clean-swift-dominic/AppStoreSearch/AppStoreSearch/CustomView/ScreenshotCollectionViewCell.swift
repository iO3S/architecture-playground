//
//  ScreenshotCollectionViewCell.swift
//  AppStoreSearch
//
//  Created by 도미닉 on 7/2/25.
//

import UIKit

class ScreenshotCollectionViewCell: UICollectionViewCell {
    static let identifier = "ScreenshotCollectionViewCell"
    
    let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
