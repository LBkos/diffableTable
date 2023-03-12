//
//  CustomCell.swift
//  lesson 4 Table
//
//  Created by Константин Лопаткин on 10.03.2023.
//

import UIKit

class CustomCell: UITableViewCell {

    var number: Int?

    override func updateConfiguration(using state: UICellConfigurationState) {
        super.updateConfiguration(using: state)
        
        var contentConfig = defaultContentConfiguration().updated(for: state)
        contentConfig.text = "\(number ?? 0)"

        tintColor = .systemGreen
        
        if state.isHighlighted || state.isSelected {
            accessoryView = UIImageView(image:UIImage(systemName: "checkmark")!)
        
        } else {
            accessoryView = nil
        }
        
        contentConfiguration = contentConfig
    }
}

extension UITableViewCell {
    
    static var reuseIdentifier: String {
        String(describing: self)
    }

    var reuseIdentifier: String {
        type(of: self).reuseIdentifier
    }
}

extension UITableView {
        
    func register<T: UITableViewCell>(_ type: T.Type) {
        register(T.self, forCellReuseIdentifier: T.reuseIdentifier)
    }

    func reuse<T: UITableViewCell>(_ type: T.Type, _ indexPath: IndexPath) -> T {
        dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as! T
    }
}


