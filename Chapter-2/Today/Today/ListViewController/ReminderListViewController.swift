//
//  ReminderListViewController.swift
//
//
//  Created by TakashiUshikoshi on 2023/06/02
//
//

import UIKit

class ReminderListViewController: UICollectionViewController {
    
    var dataSource: DataSource!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let listLayout = listLayout()
        
        self.collectionView.collectionViewLayout = listLayout
        
        let cellRegistration: UICollectionView.CellRegistration = .init(handler: cellRegistrationHandler)
        
        dataSource = DataSource(collectionView: self.collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, itemIdentifier: String) in
            return collectionView.dequeueConfiguredReusableCell(
                using: cellRegistration,
                for: indexPath,
                item: itemIdentifier
            )
        }
        
        var snapshot: Snapshot = .init()
        
        snapshot.appendSections([0])
        
        let reminderTitles: [String] = Reminder.sampleData.map { $0.title }
        
        snapshot.appendItems(reminderTitles)
        
        dataSource.apply(snapshot)
        
        collectionView.dataSource = dataSource
    }

    private func listLayout() -> UICollectionViewCompositionalLayout {
        var listConfiguration = UICollectionLayoutListConfiguration(appearance: .grouped)
        
        listConfiguration.showsSeparators = false
        listConfiguration.backgroundColor = .clear
        
        return .list(using: listConfiguration)
    }
}

