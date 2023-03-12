//
//  DiffableViewController.swift
//  lesson 4 Table
//
//  Created by Константин Лопаткин on 11.03.2023.
//

import UIKit
import Foundation

class DifViewController: UIViewController {
    var tableView = TableView(style: .insetGrouped)
    var dataSource: DataSource!
    var data: [Int] = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40]

    
    override func loadView() {
        super.loadView()
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate(tableView.layoutConstraints(in: view))
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = DataSource(tableView)
        title = "Lesson 4"
        
        let button = UIBarButtonItem(title: "Shuffle", style: .done, target: self, action: #selector(DifViewController.shuffle))
        navigationItem.rightBarButtonItem = button
//        navigationController?.navigationBar.prefersLargeTitles = true

        tableView.register(CustomCell.self)
        tableView.delegate = self

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        reload()
    }
    
    func reload() {
        dataSource.reload(data)
        tableView.select(dataSource.selectedIndexPaths(SelectionOptions(data)) { $0 })
    }
    @objc func shuffle() {
        dataSource.shuffleValues(data)
    }
}

extension DifViewController: UITableViewDelegate {
    func toggleData(_ sectionId: Int) {
        var multiple = SelectionOptions<Int>(data, selected: [], multiple: true)
        multiple.toggle(sectionId)
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let sectionId = dataSource.sectionIdentifier(for: indexPath.section) else { return }
        toggleData(sectionId)
        
        dataSource.firstItem(data, indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        guard let sectionId = dataSource.sectionIdentifier(for: indexPath.section) else { return }
        toggleData(sectionId)
    }
    
}
struct SelectionOptions<T: Hashable> {

    var values: [T]
    var selectedValues: [T]
    var multipleSelection: Bool

    init(_ values: [T], selected: [T] = [], multiple: Bool = false) {
        self.values = values
        self.selectedValues = selected
        self.multipleSelection = multiple
    }

    mutating func toggle(_ value: T) {
        guard multipleSelection else {
            selectedValues = [value]
            return
        }
        
        if selectedValues.contains(value) {
            selectedValues = selectedValues.filter { $0 != value }
        } else {
            selectedValues.append(value)
            
        }
    }
}

extension UITableViewDiffableDataSource {

    func selectedIndexPaths<T: Hashable>(_ selection: SelectionOptions<T>,
                                         _ transform: (T) -> ItemIdentifierType) ->  [IndexPath] {
        selection.values
            .filter { selection.selectedValues.contains($0) }
            .map { transform($0) }
            .compactMap { indexPath(for: $0) }
        
    }
}
