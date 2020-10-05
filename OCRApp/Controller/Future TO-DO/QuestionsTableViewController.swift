//
//  QuestionsTableViewController.swift
//  OCRApp
//
//  Created by Zhanibek Lukpanov on 08.06.2020.
//  Copyright © 2020 Zhanibek Lukpanov. All rights reserved.
//

import UIKit

final class QuestionsTableViewController: UITableViewController, ExpandableHeaderViewDelegate {
    
    var secitonsArray = [
        Section(title: "Questions", items: ["Item","Item","Item","Item","Item"], expanded: false),
        Section(title: "FAQ", items: ["Item","Item","Item","Item","Item"], expanded: false),
        Section(title: "Contacts", items: ["Item","Item","Item","Item","Item"], expanded: true)
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView(frame: CGRect.zero)
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return secitonsArray.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return secitonsArray[section].items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = secitonsArray[indexPath.section].items[indexPath.row]

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 57
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if secitonsArray[indexPath.section].expanded {
            return 44
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = ExpandableHeaderView()
        header.setup(with: secitonsArray[section].title, section: section, delegate: self)
        return header
    }
    
    // MARK: - Methods
    
    func toggleSection(section: Int) {
        
        secitonsArray[section].expanded = !secitonsArray[section].expanded
        
        tableView.beginUpdates()
        for row in 0..<secitonsArray[section].items.count {
            tableView.reloadRows(at: [IndexPath(row: row, section: section)], with: .automatic)
        }
        tableView.endUpdates()
    }
    
}
