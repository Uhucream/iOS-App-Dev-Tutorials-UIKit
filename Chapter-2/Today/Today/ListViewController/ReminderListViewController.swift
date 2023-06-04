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
    var reminders: [Reminder] = Reminder.sampleData

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let listLayout = listLayout()
        
        self.collectionView.collectionViewLayout = listLayout
        
        let cellRegistration: UICollectionView.CellRegistration = .init(handler: cellRegistrationHandler)
        
        dataSource = DataSource(collectionView: self.collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, itemIdentifier: Reminder.ID) in
            return collectionView.dequeueConfiguredReusableCell(
                using: cellRegistration,
                for: indexPath,
                item: itemIdentifier
            )
        }
        
        updateSnapshot()
        
        collectionView.dataSource = dataSource
    }
    
    override func collectionView(
        _ collectionView: UICollectionView,
        shouldSelectItemAt indexPath: IndexPath
    ) -> Bool {
        let id: Reminder.ID = reminders[indexPath.item].id
        
        pushDetailViewForReminder(withId: id)
        
        return false
    }
    
    func pushDetailViewForReminder(withId id: Reminder.ID) {
        let reminder = reminder(withId: id)
        
        let reminderViewController: ReminderViewController = .init(reminder: reminder)
        
        navigationController?.pushViewController(reminderViewController, animated: true)
    }

    private func listLayout() -> UICollectionViewCompositionalLayout {
        var listConfiguration = UICollectionLayoutListConfiguration(appearance: .grouped)
        
        listConfiguration.showsSeparators = false
        listConfiguration.backgroundColor = .clear
        
        return .list(using: listConfiguration)
    }
}

