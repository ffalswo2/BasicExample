//
//  ViewController.swift
//  DiffableExample
//
//  Created by 김민재 on 2023/05/11.
//

import UIKit

import SnapKit

class ViewController: UIViewController {

    enum Section: CaseIterable {
        case main
    }

    private let searchBar = UISearchBar()
    private let ruleController = RulesController()

    lazy var rulesCollectionView = UICollectionView(frame: .zero, collectionViewLayout: self.createLayout())
    var dataSource: UICollectionViewDiffableDataSource<Section, HousRule>?
    var nameFilter: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        setStyle()
        setLayout()
        configureDataSource()
        performQuery(with: nil)
    }

    private func setStyle() {
        view.backgroundColor = .white
        navigationItem.title = "Rules Search"
        searchBar.delegate = self
        rulesCollectionView.delegate = self
    }

    private func setLayout() {
        view.addSubview(searchBar)
        view.addSubview(rulesCollectionView)
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(48)
        }
        rulesCollectionView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

extension ViewController {
    /// Rules datasource
    func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<HousRuleCollectionViewCell, HousRule> { (cell, indexPath, item) in
            cell.configureCell(rule: item)
        }

        dataSource = UICollectionViewDiffableDataSource<Section, HousRule>(collectionView: rulesCollectionView, cellProvider: { collectionView, indexPath, itemIdentifier -> UICollectionViewCell? in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
        })
    }

    /// 검색창에 입력하면 실행되는 메서드
    func performQuery(with filter: String?) {
        let rules = ruleController.filteredRules(with: filter)
            .sorted { $0.name < $1.name }
        print("룰즈 : ", rules)
        var snapshot = NSDiffableDataSourceSnapshot<Section, HousRule>()
        snapshot.appendSections([.main])
        snapshot.appendItems(rules)
        dataSource?.apply(snapshot, animatingDifferences: true)
    }
}

extension ViewController {
    func createLayout() -> UICollectionViewLayout {
        let config = UICollectionLayoutListConfiguration(appearance: .plain)
        return UICollectionViewCompositionalLayout.list(using: config)
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        performQuery(with: searchText)
    }
}
