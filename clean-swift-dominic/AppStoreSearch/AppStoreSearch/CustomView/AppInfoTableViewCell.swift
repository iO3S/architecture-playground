//
//  AppInfoTableViewCell.swift
//  AppStoreSearch
//
//  Created by 도미닉 on 6/29/25.
//

import UIKit

class AppInfoTableViewCell: UITableViewCell {
    let data = ["https://is1-ssl.mzstatic.com/image/thumb/PurpleSource221/v4/1d/f4/87/1df48778-4b7b-3c26-e1b4-40c917d61283/Appstore_Preview_Plus_01.png/392x696bb.png", "https://is1-ssl.mzstatic.com/image/thumb/PurpleSource221/v4/73/a0/da/73a0daa5-51b4-69bd-58ed-bdfd91a96ed4/Appstore_Preview_Plus_02.png/392x696bb.png", "https://is1-ssl.mzstatic.com/image/thumb/PurpleSource211/v4/a0/83/16/a08316f7-b841-2ecc-c97c-49a1a5a2ec8e/Appstore_Preview_Plus_03.png/392x696bb.png", "https://is1-ssl.mzstatic.com/image/thumb/PurpleSource211/v4/e7/aa/1b/e7aa1b32-9f65-c3a8-cb69-a59a2774bee3/Appstore_Preview_Plus_03.png/392x696bb.png", "https://is1-ssl.mzstatic.com/image/thumb/PurpleSource211/v4/96/bc/1c/96bc1c3a-874b-189d-7c87-dc8844b64364/Appstore_Preview_Plus_05.png/392x696bb.png", "https://is1-ssl.mzstatic.com/image/thumb/PurpleSource221/v4/2d/d6/6a/2dd66a95-5521-62e1-9ba9-25d65cc0f47f/Appstore_Preview_Plus_06.png/392x696bb.png", "https://is1-ssl.mzstatic.com/image/thumb/PurpleSource221/v4/be/39/c7/be39c74e-6cae-4bea-3247-d17b56cb9475/Appstore_iPhone_8.png/392x696bb.png", "https://is1-ssl.mzstatic.com/image/thumb/PurpleSource221/v4/d8/db/39/d8db3930-dd45-31f3-c176-a91d1d396a84/Appstore_Preview_Plus_08.png/392x696bb.png"]
    let appIconListView = AppIconListView()
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical // 스크롤 방향 설정 (수직)
        layout.minimumLineSpacing = 10 // 셀 간의 최소 줄 간격
        layout.minimumInteritemSpacing = 10 // 같은 줄 내 셀 간의 최소 항목 간격
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10) // 섹션 여백
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground // 배경색 설정
        collectionView.register(ScreenshotCollectionViewCell.self, forCellWithReuseIdentifier: ScreenshotCollectionViewCell.identifier) // 셀 등록
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(appIconListView)
        addSubview(collectionView)
        appIconListView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
        }
        collectionView.snp.makeConstraints { make in
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

extension AppInfoTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ScreenshotCollectionViewCell.identifier, for: indexPath) as? ScreenshotCollectionViewCell else {
            return UICollectionViewCell()
        }
        let item = data[indexPath.item]
        let url = URL(string: data[indexPath.item])
        cell.imageView.kf.setImage(with: url)
        cell.backgroundColor = .systemTeal.withAlphaComponent(0.2)
        cell.layer.cornerRadius = 8
        return cell
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else {
            return .zero // 또는 적절한 기본 크기를 반환합니다.
        }
        // 이제 'flowLayout' 변수를 통해 sectionInset에 안전하게 접근할 수 있습니다.
        let horizontalInsets = flowLayout.sectionInset.left + flowLayout.sectionInset.right
        let totalInteritemSpacing = flowLayout.minimumInteritemSpacing * CGFloat(data.count - 1)
        
        let cellWidth = (collectionView.bounds.width - horizontalInsets - totalInteritemSpacing) / 2.5 // 예시 너비 계산
        
        let item = data[indexPath.item]
        let dummyCell = ScreenshotCollectionViewCell(frame: CGRect(x: 0, y: 0, width: cellWidth, height: 50))
        let url = URL(string: data[indexPath.item])
        dummyCell.imageView.kf.setImage(with: url)
        
        dummyCell.setNeedsLayout()
        dummyCell.layoutIfNeeded()
        
        let fittingSize = CGSize(width: cellWidth, height: UIView.layoutFittingCompressedSize.height)
        let targetSize = dummyCell.contentView.systemLayoutSizeFitting(fittingSize, withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel)
        
        return CGSize(width: cellWidth, height: targetSize.height)
    }
}
