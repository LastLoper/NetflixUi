//
//  ContentCollectionRankCell.swift
//  NetflixUI
//
//  Created by WalterCho on 2022/12/27.
//

import UIKit
import SnapKit

class ContentCollectionRankCell: UICollectionViewCell {
    let imageView = UIImageView()
    let rankLabel = UILabel()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //contentView
        contentView.layer.cornerRadius = 5
        contentView.clipsToBounds = true
        
        //ImageView
        imageView.contentMode = .scaleToFill
        
        //RankLabel
        rankLabel.font = .systemFont(ofSize: 100, weight: .black)
        rankLabel.textColor = .white
        
        [imageView, rankLabel].forEach {
            contentView.addSubview($0)
        }
        
        imageView.snp.makeConstraints {
            $0.top.trailing.bottom.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.8)
        }
        
        rankLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.bottom.equalToSuperview().offset(25)
        }
    }
    
    func setData(image: UIImage, rank: Int) {
        self.imageView.image = image
        self.rankLabel.text = String(describing: rank)
    }
}
