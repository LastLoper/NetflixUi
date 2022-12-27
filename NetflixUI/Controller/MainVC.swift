//
//  ViewController.swift
//  NetflixUI
//
//  Created by Walter J on 2022/10/23.
//

import UIKit
import SwiftUI

class MainVC: UICollectionViewController {
    var contents:[Content] = []
    var mainItem: Item?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .black
        
        //네비게이션 설정
        self.setUpNavigationBar()
        
        //content.plist 값 가져오기
        self.contents = self.getContent()
        self.mainItem = contents.first?.contentItem.randomElement()
        
        //CollectionView에 Custom Cell등록
        collectionView.register(ContentCollecionCell.self, forCellWithReuseIdentifier: "ContentCollecionCell")
        collectionView.register(ContentCollectionRankCell.self, forCellWithReuseIdentifier: "ContentCollecionRankCell")
        collectionView.register(ContentCollectionMainCell.self, forCellWithReuseIdentifier: "ContentCollecionMainCell")
        
        collectionView.register(ContentCollectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "ContentCollectionHeader")
        
        //위에서 데이터가 CollectionView에 삽입된 후, 해당 데이터에 맞게 레이아웃이 적용된다.
        collectionView.collectionViewLayout = layout()
    }
    
    //네비게이션 설정
    private func setUpNavigationBar() {
        navigationController?.navigationBar.backgroundColor = .clear
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()     //기본 이미지로 그림자 주기
        navigationController?.hidesBarsOnSwipe = true       //스크롤 스와이프 동작시 네비게이션바 감추기
        
        //NavigationBar의 왼/오른쪽 버튼 생성
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
    
    //각각의 SectionType에 대한 UICollectionViewLayout 생성
    private func layout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { [weak self] sectionNumber, environment -> NSCollectionLayoutSection? in
            guard let self = self else { return nil }
            
            switch self.contents[sectionNumber].sectionType {
            case .basic:
                return self.createBasicTypeSection()
            case .large:
                return self.createLargeTypeSection()
            case .rank:
                return self.createRankTypeSection()
            case .main:
                return self.createMainTypeSection()
            }

        }
    }
    
    //배너형태의 BasicType인 Section 설정
    private func createBasicTypeSection() -> NSCollectionLayoutSection {
        //item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3), heightDimension: .fractionalHeight(0.75))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 10, leading: 5, bottom: 0, trailing: 5)
        
        //group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .estimated(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 3)
        
        //Section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous   //스크롤 행동
        section.contentInsets = .init(top: 0, leading: 5, bottom: 0, trailing: 5)
        
        let sectionHeader = self.createSectionHeader()
        section.boundarySupplementaryItems = [sectionHeader]
        
        return section
    }
    
    //배너형태의 LargeType인 Section 설정
    private func createLargeTypeSection() -> NSCollectionLayoutSection {
        //item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3), heightDimension: .fractionalHeight(0.75))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 10, leading: 5, bottom: 0, trailing: 5)
        
        //group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .estimated(400))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 2)
        
        //Section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous   //스크롤 행동
        section.contentInsets = .init(top: 0, leading: 5, bottom: 0, trailing: 5)
        
        let sectionHeader = self.createSectionHeader()
        section.boundarySupplementaryItems = [sectionHeader]
        
        return section
    }
    
    //배너형태의 RankType인 Section 설정
    private func createRankTypeSection() -> NSCollectionLayoutSection {
        //item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3), heightDimension: .fractionalHeight(0.9))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 10, leading: 5, bottom: 0, trailing: 5)
        
        //group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .estimated(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 2)
        
        //Section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous   //스크롤 행동
        section.contentInsets = .init(top: 0, leading: 5, bottom: 0, trailing: 5)
        
        let sectionHeader = self.createSectionHeader()
        section.boundarySupplementaryItems = [sectionHeader]
        
        return section
    }
    
    //배너형태의 RankType인 Section 설정
    private func createMainTypeSection() -> NSCollectionLayoutSection {
        //item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
//        item.contentInsets = .init(top: 10, leading: 5, bottom: 0, trailing: 5)
        
        //group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(450))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        //Section
        let section = NSCollectionLayoutSection(group: group)
//        section.orthogonalScrollingBehavior = .continuous   //스크롤 행동
        section.contentInsets = .init(top: 0, leading: 0, bottom: 20, trailing: 0)
        
        return section
    }
    
    //SectionHeader Layout설정
    private func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        //section Header 사이즈
        let layoutSectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(30))
        
        //.fractionWidht/Height => 비율로 크기 지정 (0.0 ~ 1.0)
        //.estimated => 예상치
        //.absolute => 무조건
        
        //Section Header Layout
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: layoutSectionHeaderSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        
        return sectionHeader
    }
}

//MARK: - UICollectionViewDataSource, Delegate
extension MainVC {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return contents[section].contentItem.count
        }
    }
    
    //셀에 데이터 삽입
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch contents[indexPath.section].sectionType {
        case .basic, .large:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContentCollecionCell", for: indexPath) as! ContentCollecionCell
            let image = contents[indexPath.section].contentItem[indexPath.row].image
            cell.setUpImageAtView(image: image)
            return cell
        case .rank:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContentCollecionRankCell", for: indexPath) as! ContentCollectionRankCell
            let image = contents[indexPath.section].contentItem[indexPath.row].image
            cell.setData(image: image, rank: indexPath.row + 1)
            return cell
        case .main:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContentCollecionMainCell", for: indexPath) as! ContentCollectionMainCell
            
            if let mainItem = self.mainItem {
                cell.setData(image: mainItem.image, description: mainItem.description)
            }
            return cell
        }
    }
    
    //헤더에 데이터 삽입
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "ContentCollectionHeader", for: indexPath) as! ContentCollectionHeader
            let name = contents[indexPath.section].sectionName
            header.setUpNameAtLabel(sectionName: name)
            return header
        } else {
            return UICollectionReusableView()
        }
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return contents.count
    }
    
    //셀 선택
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sectionName = self.contents[indexPath.section].sectionName
        print("\(sectionName)의 \(indexPath.row + 1)번째 컨텐츠")
    }
}

//SwiftUI를 활용한 미리보기
//struct MainVC_Previews: PreviewProvider {
//    static var previews: some View {
//        Container().edgesIgnoringSafeArea(.all)
//    }
//
//    struct Container: UIViewControllerRepresentable {
//        func makeUIViewController(context: Context) -> UIViewController {
//            let layout = UICollectionViewLayout()
//            let mainVC = MainVC(collectionViewLayout: layout)
//
//            return UINavigationController(rootViewController: mainVC)
//        }
//
//        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) { }
//
//        typealias UIViewControllerType = UIViewController
//    }
//}
