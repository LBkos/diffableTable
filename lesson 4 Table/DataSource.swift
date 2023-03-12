//
//  DataSource.swift
//  lesson 4 Table
//
//  Created by Константин Лопаткин on 11.03.2023.
//
import Foundation
import UIKit

final class DataSource: UITableViewDiffableDataSource<Int, Int> {
    
    init(_ tableView: UITableView) {
        super.init(tableView: tableView) { tableView, indexPath, itemIdentifier in
            let cell = tableView.reuse(CustomCell.self, indexPath)
            cell.selectionStyle = .none
            cell.number = itemIdentifier
            
            return cell
        }
    }
    
    func shuffleValues(_ data: [Int]) {
        var snapshot = snapshot()
        let shuffledData = data.shuffled()
        snapshot.deleteAllItems()
        snapshot.appendSections([1])
        
        snapshot.appendItems(shuffledData)
        
        apply(snapshot, animatingDifferences: true)
        
        
    }
    func firstItem(_ data: [Int], indexPath: IndexPath, animated: Bool = true) {
        var snapshot = snapshot()
        if let itemIdent = itemIdentifier(for: indexPath),
        let first = snapshot.itemIdentifiers(inSection: 1).first,
        itemIdent != first {
            snapshot.moveItem(itemIdent, beforeItem: first)
            apply(snapshot, animatingDifferences: animated)
        }
    }
    
    func reload(_ data: [Int], animated: Bool = true) {
        var snapshot = snapshot()
        snapshot.deleteAllItems()
        snapshot.appendSections([1])
        snapshot.appendItems(data)
        apply(snapshot, animatingDifferences: animated)
        
    }
}
