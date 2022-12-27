//
//  ContentCollectionMainCell.swift
//  NetflixUI
//
//  Created by WalterCho on 2022/12/27.
//

import UIKit
import SnapKit

class ContentCollectionMainCell: UICollectionViewCell {
    let baseStackView = UIStackView()
    let menuStackView = UIStackView()
    
    let tvBtn = UIButton()
    let movieBtn = UIButton()
    let categoryBtn = UIButton()
    
    let imageView = UIImageView()
    let descriptionLabel = UILabel()
    let contentStackView = UIStackView()
    
    let plusBtn = UIButton()
    let playBtn = UIButton()
    let infoBtn = UIButton()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        [baseStackView, menuStackView].forEach {
            contentView.addSubview($0)
        }
        
        //baseStackView
        baseStackView.axis = .vertical
        baseStackView.alignment = .center
        baseStackView.distribution = .fillProportionally
        baseStackView.spacing = 5
        
        baseStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        //BaseStackView의 요소들 정의
        //imageView, descriptionLabel, contentStackView
        [imageView, descriptionLabel, contentStackView].forEach {
            baseStackView.addArrangedSubview($0)
        }
        
        imageView.contentMode = .scaleAspectFit
        imageView.snp.makeConstraints {
            $0.width.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(imageView.snp.width)
        }
        
        descriptionLabel.font = .systemFont(ofSize: 13)
        descriptionLabel.textColor = .white
        descriptionLabel.sizeToFit()
        
        contentStackView.axis = .horizontal
        contentStackView.alignment = .center
        contentStackView.distribution = .equalCentering
        contentStackView.spacing = 20
        
        //ContentStackView의 요소를 정의
        //plusBtn, playBtn, infoBtn
        [plusBtn, infoBtn].forEach {
            $0.titleLabel?.font = .systemFont(ofSize: 13)
            $0.setTitleColor(.white, for: .normal)
            $0.imageView?.tintColor = .white
            $0.adjustVerticalLayout(5)
        }
        
        plusBtn.setTitle("내가 찜한 컨텐츠", for: .normal)
        plusBtn.setImage(UIImage(systemName: "plus"), for: .normal)
        
        infoBtn.setTitle("정보", for: .normal)
        infoBtn.setImage(UIImage(systemName: "info.circle"), for: .normal)
        
        playBtn.setTitle("재생", for: .normal)
        playBtn.setImage(UIImage(systemName: "play"), for: .normal)
        playBtn.setTitleColor(.black, for: .normal)
        playBtn.backgroundColor = .white
        playBtn.layer.cornerRadius = 3
        playBtn.snp.makeConstraints {
            $0.width.equalTo(90)
            $0.height.equalTo(30)
        }
        
        [plusBtn, playBtn, infoBtn].forEach {
            contentStackView.addArrangedSubview($0)
        }
        
        contentStackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(30)
            $0.height.equalTo(60)
        }
        
        //menuStackView
        menuStackView.axis = .horizontal
        menuStackView.alignment = .center
        menuStackView.distribution = .equalSpacing
        menuStackView.spacing = 20
        
        menuStackView.snp.makeConstraints {
            $0.top.equalTo(baseStackView)
            $0.leading.trailing.equalToSuperview().inset(30)
        }
        
        //MemuStackView의 요소들 정의
        //tvBtn, movieBtn, categoryBtn
        [tvBtn, movieBtn, categoryBtn].forEach {
            menuStackView.addArrangedSubview($0)
            $0.setTitleColor(.white, for: .normal)
            $0.layer.shadowColor = UIColor.black.cgColor
            $0.layer.shadowOpacity = 1
            $0.layer.shadowRadius = 3
        }
        
        tvBtn.setTitle("TV프로그램", for: .normal)
        movieBtn.setTitle("영화", for: .normal)
        categoryBtn.setTitle("카테고리", for: .normal)
        
        tvBtn.addTarget(self, action: #selector(tvBtnTapped), for: .touchUpInside)
        movieBtn.addTarget(self, action: #selector(movieBtnTapped), for: .touchUpInside)
        categoryBtn.addTarget(self, action: #selector(categoryBtnTapped), for: .touchUpInside)
    }
    
    @objc
    private func tvBtnTapped(sender: UIButton!) {
        print("TV 버튼 Tapped!!")
    }
    
    @objc
    private func movieBtnTapped(sender: UIButton!) {
        print("MOVIE 버튼 Tapped!!")
    }
    
    @objc
    private func categoryBtnTapped(sender: UIButton!) {
        print("CATEGORY 버튼 Tapped!!")
    }
    
    func setData(image: UIImage, description: String) {
        self.imageView.image = image
        self.descriptionLabel.text = description
    }
}
