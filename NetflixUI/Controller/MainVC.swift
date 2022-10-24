//
//  ViewController.swift
//  NetflixUI
//
//  Created by Walter J on 2022/10/23.
//

import UIKit

class MainVC: UICollectionViewController {
    var contents:[Content] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //네비게이션 설정
        self.setUpNavigationBar()
        
        //content.plist 값 가져오기
        self.contents = self.getContent()
        
        //CollectionView에 Custom Cell등록
        collectionView.register(ContentCollecionCell.self, forCellWithReuseIdentifier: "ContentCollecionCell")
        collectionView.register(ContentCollectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "ContentCollectionHeader")
    }
    
    //네비게이션 설정
    private func setUpNavigationBar() {
        navigationController?.navigationBar.backgroundColor = .clear
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()     //기본 이미지로 그림자 주기
        navigationController?.hidesBarsOnSwipe = true       //스크롤 스와이프 동작시 네비게이션바 감추기
        
        let leftIcon = #imageLiteral(resourceName: "netflix_icon")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: leftIcon, style: .plain, target: nil, action: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person.crop.circle"), style: .plain, target: nil, action: nil)
    }
    
    //content.plist 값 가져오기
    private func getContent() -> [Content] {
        guard let path = Bundle.main.path(forResource: "Content", ofType: "plist"),
              let data = FileManager.default.contents(atPath: path),
              let list = try? PropertyListDecoder().decode([Content].self, from: data) else { return [] }
        
        return list
    }
}

//MARK: - UICollectionViewDataSource, Delegate
extension MainVC {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return contents.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "ContentCollectionHeader", for: indexPath) as! ContentCollectionHeader
            let name = contents[indexPath.section].contentName
            header.setUpNameAtLabel(sectionName: name)
            return header
        } else {
            return UICollectionReusableView()
        }
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return contents[section].contentItems.count
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch contents[indexPath.section].sectionType {
        case .basic, .large:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContentCollecionCell", for: indexPath) as! ContentCollecionCell
            let image = contents[indexPath.section].contentItems[indexPath.row].image
            cell.setUpImageAtView(image: image)
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sectionName = self.contents[indexPath.section].contentName
        print("\(sectionName)의 \(indexPath.row + 1)번째 컨텐츠")
    }
}
