//
//  ReminderListViewController.swift
//  
//  
//  Created by TakashiUshikoshi on 2023/06/02
//  
//

import UIKit

class ReminderListViewController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let listLayout = listLayout()
        
        self.collectionView.collectionViewLayout = listLayout
    }

    private func listLayout() -> UICollectionViewCompositionalLayout {
        var listConfiguration = UICollectionLayoutListConfiguration(appearance: .grouped)
        
        listConfiguration.showsSeparators = false
        listConfiguration.backgroundColor = .clear
        
        return .list(using: listConfiguration)
    }
}

