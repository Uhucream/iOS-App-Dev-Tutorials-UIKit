//
//  ReminderListViewController+DataSource.swift
//  Today
//  
//  Created by TakashiUshikoshi on 2023/06/02
//  
//

import UIKit

extension ReminderListViewController {
    typealias DataSource = UICollectionViewDiffableDataSource<Int, Reminder.ID>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, Reminder.ID>
    
    func cellRegistrationHandler(cell: UICollectionViewListCell, indexPath: IndexPath, id: Reminder.ID) {
        let reminder: Reminder = reminder(withId: id)
        
        var contentConfiguration: UIListContentConfiguration = cell.defaultContentConfiguration()
        
        contentConfiguration.text = reminder.title

        contentConfiguration.secondaryText = reminder.dueDate.dayAndTimeText
        contentConfiguration.secondaryTextProperties.font = .preferredFont(forTextStyle: .caption1)
        
        cell.contentConfiguration = contentConfiguration
        
        var doneButtonConfiguration = doneButtonConfiguration(for: reminder)
        
        doneButtonConfiguration.tintColor = .todayListCellDoneButtonTint
        
        cell.accessories = [
            .customView(configuration: doneButtonConfiguration),
            .disclosureIndicator(displayed: .always)
        ]
        
        var backgroundConfiguration: UIBackgroundConfiguration = .listGroupedCell()
        
        backgroundConfiguration.backgroundColor = .todayListCellBackground
        
        cell.backgroundConfiguration = backgroundConfiguration
    }
    
    func reminder(withId id: Reminder.ID) -> Reminder {
        let index = reminders.indexOfReminder(withId: id)
        
        return reminders[index]
    }
    
    func updateReminder(_ reminder: Reminder) {
        let index = reminders.indexOfReminder(withId: reminder.id)
        
        reminders[index] = reminder
    }
    
    func doneButtonConfiguration(for reminder: Reminder) -> UICellAccessory.CustomViewConfiguration {
        let symbolName: String = reminder.isComplete ? "circle.fill" : "circle"
        
        let symbolConfiguration: UIImage.SymbolConfiguration = .init(textStyle: .title1)
        
        let image: UIImage? = .init(systemName: symbolName, withConfiguration: symbolConfiguration)
        
        let button: UIButton = .init()
        
        button.setImage(image, for: .normal)
        
        return .init(customView: button, placement: .leading(displayed: .always))
    }
}
