//
//  MainScreenSearchResults.swift
//  OCRApp
//
//  Created by Zhanibek Lukpanov on 08.08.2020.
//  Copyright © 2020 Zhanibek Lukpanov. All rights reserved.
//

import UIKit

//MARK: - UISearchResultsUpdating
extension MainViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        filteredDocuments(searchController.searchBar.text!)
    }
    
    func filteredDocuments(_ searchText: String) {
        filteredDocuments = documents.filter({(document: URL)-> Bool in
            return document.absoluteString.lowercased().contains(searchText.lowercased())
        })
        collectionView.reloadData()
    }
    
}
