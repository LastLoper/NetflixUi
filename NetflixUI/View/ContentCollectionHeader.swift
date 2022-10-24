//
//  ContentCollectionHeader.swift
//  NetflixUI
//
//  Created by Walter J on 2022/10/23.
//

import UIKit
import SnapKit

class ContentCollectionHeader: UICollectionReusableView {
    let sectionName = UILabel()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.sectionName.font = .systemFont(ofSize: 17, weight: .bold)
        self.sectionName.textColor = .white
        self.sectionName.sizeToFit()
        
        addSubview(self.sectionName)
        
        self.sectionName.snp.makeConstraints { view in
            view.centerY.equalToSuperview()
            view.top.bottom.leading.equalToSuperview().offset(10)
        }
    }
    
    func setUpNameAtLabel(sectionName: String) {
        self.sectionName.text = sectionName
    }
}
