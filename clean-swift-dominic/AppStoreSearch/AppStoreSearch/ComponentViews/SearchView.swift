//
//  SearchView.swift
//  AppStoreSearch
//
//  Created by 도미닉 on 6/21/25.
//

import UIKit
import SnapKit
import Then

class SearchView: UIView {
    let totalHorizontalStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 10
        $0.alignment = .fill
    }
    let textFieldContainerView = UIView().then {
        $0.backgroundColor = .darkGray
        $0.layer.cornerRadius = 10
        $0.layer.masksToBounds = true
    }
    let searchHorizontalStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.alignment = .center
        $0.spacing = 10
    }
    let searchIconImageView = UIImageView().then {
        $0.image = UIImage(systemName: "magnifyingglass")
        $0.tintColor = .lightGray
    }
    let textField = UITextField().then {
        $0.backgroundColor = .clear
        $0.textColor = .white
        $0.font = .systemFont(ofSize: 22)
        $0.clearButtonMode = .whileEditing 
    }
    let cancleButton = UIButton().then {
        $0.setTitle("취소", for: .normal)
        $0.setTitleColor(.systemBlue, for: .normal)
        $0.setTitleColor(.blue, for: .highlighted)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = .black
        addSubviews()
    }
    
    private func addSubviews() {
        addSubview(totalHorizontalStackView)
        totalHorizontalStackView.addArrangedSubview(textFieldContainerView)
        totalHorizontalStackView.addArrangedSubview(cancleButton)
        textFieldContainerView.addSubview(searchHorizontalStackView)
        searchHorizontalStackView.addArrangedSubview(searchIconImageView)
        searchHorizontalStackView.addArrangedSubview(textField)
        
        totalHorizontalStackView.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.horizontalEdges.equalToSuperview()
        }
        textField.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        searchHorizontalStackView.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(10)
        }
        searchIconImageView.snp.makeConstraints { make in
            make.size.equalTo(25)
        }
        cancleButton.snp.makeConstraints { make in
            make.width.equalTo(40)
        }
    }
}
