//
//  ContentCollecionCell.swift
//  NetflixUI
//
//  Created by Walter J on 2022/10/23.
//

import UIKit
import SnapKit

class ContentCollecionCell: UICollectionViewCell {
    let imageView: UIImageView = UIImageView()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 5
        contentView.clipsToBounds = true
        
        self.imageView.contentMode = .scaleAspectFill
        
        contentView.addSubview(self.imageView)
        self.imageView.snp.makeConstraints { view in
            view.edges.equalToSuperview()
        }
    }
    
    func setUpImageAtView(image: UIImage) {
        self.imageView.image = image
    }
}
