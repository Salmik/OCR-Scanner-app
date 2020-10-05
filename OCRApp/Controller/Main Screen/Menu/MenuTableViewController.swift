//
//  MenuTableViewController.swift
//  OCRApp
//
//  Created by Zhanibek Lukpanov on 13.08.2020.
//  Copyright © 2020 Zhanibek Lukpanov. All rights reserved.
//

import UIKit

final class MenuViewController: UIViewController {

    var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }

    func configureTableView() {
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MenuTableCell.self, forCellReuseIdentifier: MenuTableCell.reuseId)
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.separatorStyle = .none
        tableView.rowHeight = 90
        tableView.backgroundColor = .darkGray
        tableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    
    deinit {
        print("deinit!!! \(self)")
    }
}

extension MenuViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: MenuTableCell.reuseId, for: indexPath) as! MenuTableCell
        
        let menuModel = MenuModel(rawValue: indexPath.row)
        cell.iconImage.image = menuModel?.image
        cell.myLabel.text = menuModel?.description
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let menuModel = MenuModel(rawValue: indexPath.row)
        
        switch menuModel {
        case .Contex: print("Contex")
        case .Menu: print("Menu")
        case .Profile: print("Profile")
        case .Settings: print("Settings")
        case .none: print("None")
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
