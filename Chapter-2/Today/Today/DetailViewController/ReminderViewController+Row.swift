//
//  ReminderViewController+Row.swift
//  Today
//  
//  Created by TakashiUshikoshi on 2023/06/04
//  
//

import UIKit

extension ReminderViewController {
    enum Row: Hashable {
        case date
        case notes
        case time
        case title
        
        var imageName: String? {
            switch self {
            case .date:
                return "calendar.circle"

            case .notes:
                return "square.and.pencil"

            case .time:
                return "clock"

            default:
                return nil
            }
        }
        
        var image: UIImage? {
            guard let imageName = self.imageName else { return nil }
            
            let symbolConfiguration: UIImage.SymbolConfiguration = .init(textStyle: .headline)
            
            return UIImage(systemName: imageName, withConfiguration: symbolConfiguration)
        }
        
        var textStyle: UIFont.TextStyle {
            switch self {
            case .title:
                return .headline

            default:
                return .subheadline
            }
        }
    }
}
