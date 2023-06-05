//
//  ReminderViewController.swift
//  Today
//  
//  Created by TakashiUshikoshi on 2023/06/04
//  
//

import UIKit

class ReminderViewController: UICollectionViewController {
    private typealias DataSource = UICollectionViewDiffableDataSource<Section, Row>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Row>
    
    var reminder: Reminder
    
    private var dataSource: DataSource!
    
    init(reminder: Reminder) {
        self.reminder = reminder
        
        var listConfiguration: UICollectionLayoutListConfiguration = .init(appearance: .insetGrouped)
        
        listConfiguration.showsSeparators = false
        listConfiguration.headerMode = .firstItemInSection
        
        let listLayout: UICollectionViewCompositionalLayout = .list(using: listConfiguration)
        
        super.init(collectionViewLayout: listLayout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Always initialize ReminderViewController using init(reminder:)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cellRegistration: UICollectionView.CellRegistration = .init(handler: self.cellRegistrationHandler)
        
        self.dataSource = DataSource(collectionView: self.collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, itemIdentifier: Row) in
            return collectionView.dequeueConfiguredReusableCell(
                using: cellRegistration,
                for: indexPath,
                item: itemIdentifier
            )
        }
        
        if #available(iOS 16, *) {
            self.navigationItem.style = .navigator
        }

        self.navigationItem.title = NSLocalizedString("Reminder", comment: "Reminder view controller title")
        self.navigationItem.rightBarButtonItem = editButtonItem
        
        self.updateSnapshotForViewing()
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        
        if editing {
            self.updateSnapshotForEditing()
            
            return
        }
        
        self.updateSnapshotForViewing()
    }
    
    func cellRegistrationHandler(
        cell: UICollectionViewListCell,
        indexPath: IndexPath,
        row: Row
    ) {
        let section: Section = section(for: indexPath)
        
        switch (section, row) {
        case (_, .header(let title)):
            var contentConfiguration = cell.defaultContentConfiguration()
            
            contentConfiguration.text = title
            
            cell.contentConfiguration = contentConfiguration

        case (.view, _):
            var contentConfiguration = cell.defaultContentConfiguration()
            
            contentConfiguration.text = text(for: row)
            contentConfiguration.textProperties.font = .preferredFont(forTextStyle: row.textStyle)
            
            contentConfiguration.image = row.image
            
            cell.contentConfiguration = contentConfiguration

        default:
            fatalError("Unexpected combination of section and row.")
        }

        cell.tintColor = .todayPrimaryTint
    }

    func text(for row: Row) -> String? {
        switch row {
        case .date:
            return self.reminder.dueDate.dayText
            
        case .notes:
            return self.reminder.notes
            
        case .time:
            return self.reminder.dueDate.formatted(date: .omitted, time: .shortened)
            
        case .title:
            return self.reminder.title
            
        default:
            return nil
        }
    }
    
    private func updateSnapshotForEditing() {
        var snapshot: Snapshot = .init()
        
        snapshot.appendSections([.title, .date, .notes])
        
        snapshot.appendItems([.header(Section.title.name)], toSection: .title)
        snapshot.appendItems([.header(Section.date.name)], toSection: .date)
        snapshot.appendItems([.header(Section.notes.name)], toSection: .notes)
        
        dataSource.apply(snapshot)
    }
    
    private func updateSnapshotForViewing() {
        var snapshot: Snapshot = .init()
        
        snapshot.appendSections([.view])
        snapshot.appendItems(
            [
                Row.header(""),
                Row.title,
                Row.date,
                Row.time,
                Row.notes
            ],
            toSection: .view
        )
        
        dataSource.apply(snapshot)
    }
    
    private func section(for indexPath: IndexPath) -> Section {
        let sectionNumber = self.isEditing ? indexPath.section + 1 : indexPath.section
        
        guard let section: Section = .init(rawValue: sectionNumber) else {
            fatalError("Unable to find matching section")
        }
        
        return section
    }
}
