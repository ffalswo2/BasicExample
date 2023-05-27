//
//  AddEditViewController.swift
//  DiffableExample
//
//  Created by 김민재 on 2023/05/15.
//

import UIKit
import Then

class AddEditViewController: UIViewController {

    @frozen
    enum Section: Int, CaseIterable {
        case titleAndDescription = 0
        case photoInput
    }

    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.createLayout()).then {
        $0.isScrollEnabled = false
    }

    private var dataSource: UICollectionViewDiffableDataSource<Section, Int>?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setLayout()
        configureDataSource()
        collectionView.dataSource = dataSource
    }

    private func setLayout() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }




}


extension AddEditViewController {
    func createLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment -> NSCollectionLayoutSection? in

            guard let section = Section(rawValue: sectionIndex) else { return nil }

            switch section {
            case .titleAndDescription:
                return self.createTitleSectionLayout(section: section)
            case .photoInput:
                return self.createPhotoInputSectionLayout(section: section)
            }
        }

        return layout
    }

    func createTitleSectionLayout(section: Section) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(300))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 1)

        let section = NSCollectionLayoutSection(group: group)
        return section
    }

    func createPhotoInputSectionLayout(section: Section) -> NSCollectionLayoutSection {
        let badgeAnchor = NSCollectionLayoutAnchor(edges: [.top, .trailing], fractionalOffset: CGPoint(x: 0.3, y: -0.3))
        let badgeSize = NSCollectionLayoutSize(widthDimension: .absolute(24), heightDimension: .absolute(24))

        let badge = NSCollectionLayoutSupplementaryItem(layoutSize: badgeSize, elementKind: DeletePhotoCollectionReusableView.identifier, containerAnchor: badgeAnchor)


        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize, supplementaryItems: [badge])
        item.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 12)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.45), heightDimension: .fractionalWidth(0.45))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 0, leading: 24, bottom: 0, trailing: 24)

        section.orthogonalScrollingBehavior = .continuous

        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .estimated(50)),
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .topLeading)
        section.boundarySupplementaryItems = [sectionHeader]
        return section
    }
}


extension AddEditViewController {
    func configureDataSource() {
        let titleCellRegistration = UICollectionView.CellRegistration<TitleDetailCollectionViewCell, Int> {cell,indexPath,itemIdentifier in }
        let photoCellRegistration = UICollectionView.CellRegistration<PhotoCollectionViewCell, Int> {
            cell, indexPath, itemIdentifier in

        }

        let supplementaryRegistration = UICollectionView.SupplementaryRegistration
        <HeaderCollectionReusableView>(elementKind: UICollectionView.elementKindSectionHeader) {
            (supplementaryView, string, indexPath) in
            supplementaryView.plusButtonClousre = {
                guard let dataSource = self.dataSource else { return }
                var snapshot = dataSource.snapshot()
//                snapshot.appendSections([.photoInput])
                snapshot.appendItems([10
                                     ])

                dataSource.apply(snapshot, animatingDifferences: true)
            }
        }

        let badgeRegistration = UICollectionView.SupplementaryRegistration
        <DeletePhotoCollectionReusableView>(elementKind: DeletePhotoCollectionReusableView.identifier) {
            (badgeView, string, indexPath) in
            badgeView.buttonTappedClosure = {
                guard let dataSource = self.dataSource else { return }
                var snapshot = dataSource.snapshot()
                print(indexPath.item)
//                snapshot.appendSections([.photoInput])
                snapshot.deleteItems([indexPath.item + 5])
                dataSource.apply(snapshot, animatingDifferences: true)
            }
        }

        dataSource = UICollectionViewDiffableDataSource<Section, Int>(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier -> UICollectionViewCell? in
            guard let section = Section(rawValue: indexPath.section) else { return nil}
            switch section {
            case .titleAndDescription:
                return collectionView.dequeueConfiguredReusableCell(using: titleCellRegistration, for: indexPath, item: itemIdentifier)
            case .photoInput:
                return collectionView.dequeueConfiguredReusableCell(using: photoCellRegistration, for: indexPath, item: itemIdentifier)
            }
        })

        dataSource?.supplementaryViewProvider = { (collectionView, kind, indexPath) -> UICollectionReusableView? in

            if kind == UICollectionView.elementKindSectionHeader {
                return collectionView.dequeueConfiguredReusableSupplementary(using: supplementaryRegistration, for: indexPath)
            } else if kind == DeletePhotoCollectionReusableView.identifier {
                return collectionView.dequeueConfiguredReusableSupplementary(using: badgeRegistration, for: indexPath)
            }
            return nil
        }

        var snapshot = NSDiffableDataSourceSnapshot<Section, Int>()


        Section.allCases.forEach {
            snapshot.appendSections([$0])
            let itemsPerSection = $0 == .titleAndDescription ? 1 : 1
            let itemOffset = $0.rawValue * itemsPerSection
            let itemUpperbound = itemOffset + itemsPerSection
            let arr = Array(itemOffset..<itemUpperbound)
            print($0.rawValue, "section")
            print(arr)
            snapshot.appendItems(arr)
//            if $0 == .photoInput {
//                snapshot.appendItems([5,2,3,4,1])
//            } else {
//                snapshot.appendItems([9])
//            }

        }

        dataSource?.apply(snapshot,animatingDifferences: true)
    }
}
