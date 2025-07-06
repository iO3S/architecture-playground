//
//  AppInfoVStackView.swift
//  TESTAPP
//
//  Created by jc.kim on 9/18/23.
//

import UIKit
import Cosmos

class AppInfoVStackView: UIView {
    
    //MARK: - Models
    
    struct Info {
        let userRatingCount: String //평가수
        let averageUserRating: Double //평균 평점
        let contentAdvisoryRating: String //연령
        let trackContentRating: String //장르에서의 랭킹순위
        let genres: [String] //장르
        let artistName: String //개발자
        let languageCodesISO2A: [String] //지원언어
    }
    
    //MARK: - Enums
    
    enum Style {
        case star
        case age
        case genre
        case artist
        case language
    }
    
    //MARK: - Properties
    
    private var style: Style
    
    var handleTapClosure: () -> () = {}
    
    var info: Info?
    
    //MARK: - LifeCycles
    
    init(info: Info, style: Style) {
        self.info = info
        self.style = style
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        self.info = nil
        self.style = .star
        super.init(coder: coder)
        setup()
    }
    
    //MARK: - Views
    
    private let topLabel: UILabel = {
        let label = UILabel()
        label.accessibilityLabel = label.text
        label.font = UIFont.dynamicSystemFont(for: .caption2)
        label.textColor = .lightGray
        label.textAlignment = .center
        return label
    }()
    
    private let middleLabel: UILabel = {
        let label = UILabel()
        label.accessibilityLabel = label.text
        label.font = UIFont.dynamicSystemFont(for: .bodyb)
        label.textColor = .lightGray
        label.textAlignment = .center
        return label
    }()
    
    private let bottomLabel: UILabel = {
        let label = UILabel()
        label.accessibilityLabel = label.text
        label.font = UIFont.dynamicSystemFont(for: .caption2)
        label.textColor = .lightGray
        label.textAlignment = .center
        return label
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .lightGray
        return imageView
    }()
    
    private let starRatingView: CosmosView = {
        let starRatingView = CosmosView()
        starRatingView.settings.starSize = 15
        starRatingView.settings.starMargin = 5
        starRatingView.settings.filledColor = UIColor.lightGray
        starRatingView.settings.emptyBorderColor = UIColor.lightGray
        starRatingView.settings.filledBorderColor = UIColor.lightGray
        return starRatingView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [topLabel,
                                                       middleLabel,
                                                       imageView,
                                                       bottomLabel,
                                                       starRatingView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 0
        stackView.alignment = .fill
        return stackView
    }()
}

//MARK: - Methods

extension AppInfoVStackView {
    @objc
    private func handleTap() {
        print(#function)
        handleTapClosure()
    }
}

//MARK: - Setups

extension AppInfoVStackView {
    private func setup() {
        setupUI()
        setupViews()
        setupConstraints()
        setupDelegates()
        setupGestures()
    }
    
    private func setupUI() {
        guard let info = self.info else { return }
        
        switch style {
        case .star:
            topLabel.text = "\(info.userRatingCount)개의 평가"
            middleLabel.text = "\(info.averageUserRating)"
            starRatingView.rating = 3.0
            imageView.isHidden = true
            bottomLabel.isHidden = true
        case .age:
            topLabel.text = "연령"
            middleLabel.text = "\(info.contentAdvisoryRating)"
            bottomLabel.text = "\(info.contentAdvisoryRating.dropLast())세 이상"
            imageView.isHidden = true
            starRatingView.isHidden = true
        case .genre:
            topLabel.text = "장르"
            middleLabel.text = "\(info.genres.first ?? "")"
            bottomLabel.text = info.genres.dropFirst().joined(separator: ",") == "" ? " " : info.genres.dropFirst().joined(separator: ",")
            imageView.isHidden = true
            starRatingView.isHidden = true
        case .artist:
            topLabel.text = "개발자"
            imageView.image = UIImage(
                systemName: "person.crop.square",
                withConfiguration: UIImage.SymbolConfiguration(pointSize: 30)
            )
            bottomLabel.text = "\(info.artistName)"
            middleLabel.isHidden = true
            starRatingView.isHidden = true
        case .language:
            topLabel.text = "언어"
            middleLabel.text = "\(info.languageCodesISO2A.first ?? "")"
            bottomLabel.text = "\(info.languageCodesISO2A.first ?? "")"
            imageView.isHidden = true
            starRatingView.isHidden = true
        }
    }
    
    private func setupViews() {
        addSubview(stackView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    private func setupDelegates() {
    }
    
    private func setupGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        stackView.addGestureRecognizer(tapGesture)
    }
}

#Preview {
    ViewFactory.create(AppInfoVStackView.self, info: .init(userRatingCount: "50000", averageUserRating: 4.5, contentAdvisoryRating: "4.5", trackContentRating: "15", genres: ["코메디"], artistName: "도미닉", languageCodesISO2A: ["korea"]), style: .star)
}

#Preview {
    ViewFactory.create(AppInfoVStackView.self, info: .init(userRatingCount: "50000", averageUserRating: 4.5, contentAdvisoryRating: "4.5", trackContentRating: "15", genres: ["코메디"], artistName: "도미닉", languageCodesISO2A: ["korea"]), style: .age)
}

#Preview {
    ViewFactory.create(AppInfoVStackView.self, info: .init(userRatingCount: "50000", averageUserRating: 4.5, contentAdvisoryRating: "4.5", trackContentRating: "15", genres: ["코메디"], artistName: "도미닉", languageCodesISO2A: ["korea"]), style: .genre)
}

#Preview {
    ViewFactory.create(AppInfoVStackView.self, info: .init(userRatingCount: "50000", averageUserRating: 4.5, contentAdvisoryRating: "4.5", trackContentRating: "15", genres: ["코메디"], artistName: "도미닉", languageCodesISO2A: ["korea"]), style: .artist)
}

#Preview {
    ViewFactory.create(AppInfoVStackView.self, info: .init(userRatingCount: "50000", averageUserRating: 4.5, contentAdvisoryRating: "4.5", trackContentRating: "15", genres: ["코메디"], artistName: "도미닉", languageCodesISO2A: ["korea"]), style: .language)
}
