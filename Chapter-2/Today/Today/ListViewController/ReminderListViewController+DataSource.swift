//
//  ReminderListViewController+DataSource.swift
//  Today
//  
//  Created by TakashiUshikoshi on 2023/06/02
//  
//

import UIKit

extension ReminderListViewController {
    typealias DataSource = UICollectionViewDiffableDataSource<Int, String>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, String>
    
    func cellRegistrationHandler(cell: UICollectionViewListCell, indexPath: IndexPath, id: String) {
        let reminder: Reminder = .sampleData[indexPath.item]
        
        var contentConfiguration: UIListContentConfiguration = cell.defaultContentConfiguration()
        
        contentConfiguration.text = reminder.title

        contentConfiguration.secondaryText = reminder.dueDate.dayAndTimeText
        contentConfiguration.secondaryTextProperties.font = .preferredFont(forTextStyle: .caption1)
        
        cell.contentConfiguration = contentConfiguration
        
        var backgroundConfiguration: UIBackgroundConfiguration = .listGroupedCell()
        
        backgroundConfiguration.backgroundColor = .todayListCellBackground
        
        cell.backgroundConfiguration = backgroundConfiguration
    }
}
