//
//  ViewController.swift
//  OCRApp
//
//  Created by Zhanibek Lukpanov on 28.04.2020.
//  Copyright © 2020 Zhanibek Lukpanov. All rights reserved.
//

import UIKit
import VisionKit
import WeScan
import SideMenu

final class MainViewController: UIViewController {
    
    //MARK:- Properties
    var documents = [URL]()
    var scannedImage: UIImage!
    var documentOrderNumber = 0
    var filteredDocuments = [URL]()
    
    let searchController = UISearchController(searchResultsController: nil)
    var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    var isFiltered: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var scanButton: UIButton!
    
    //MARK:- Controller Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        documents = Utilities.getDocuments()
        collectionView.reloadData()
    }
    
    //MARK:- @IBActions
    @IBAction func scanButtonPressed(_ sender: UIButton) {
        
        let actionSheet = UIAlertController(title: "Scan or Import?", message: "Choose how you want to add your file", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Scan", style: .default, handler: {[weak self] (_) in
//            let scannerVC = VNDocumentCameraViewController()
//                scannerVC.delegate = self
//            self.present(scannerVC,animated: true, completion: nil)
            
            guard let self = self else { return }

            let scannerVC = ImageScannerController()
            scannerVC.imageScannerDelegate = self
            scannerVC.modalPresentationStyle = .fullScreen
            self.present(scannerVC, animated: true, completion: nil)
            
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Import", style: .default, handler: { [weak self] (_) in
            guard let self = self else {return}
            self.chooseImageSourse(.photoLibrary)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(actionSheet, animated: true, completion: nil)
    }
    
    @IBAction func sortingButton(_ sender: UIBarButtonItem) {
        
        let actionSheet = UIAlertController(title: "Sorting", message: "Choose how you want to sort your files", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "A-Z", style: .default, handler: {(action) in
            
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Z-A", style: .default, handler: { (action) in
                
            }))
        
        actionSheet.addAction(UIAlertAction(title: "Date(new first)", style: .default, handler: { (action) in
            
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Date(old first)", style: .default, handler: { (action) in
                  
              }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(actionSheet, animated: true, completion: nil)
    }
    
    @IBAction func menuButtonPressed(_ sender: UIButton) {
        let menu = SideMenuNavigationController(rootViewController: MenuViewController())
        menu.leftSide = true
        menu.presentationStyle = .menuSlideIn
        menu.menuWidth = 250
        present(menu, animated: true, completion: nil)
    }
    
    
    //MARK:- Methods
    func setupSearchBar() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        definesPresentationContext = true
    }
    
    func setup() {
         view.backgroundColor = .white
         navigationController?.navigationBar.prefersLargeTitles = false
         
         setupSearchBar()
         
         let image = #imageLiteral(resourceName: "icon2-1")
         setTitle("My files", andImage: image)
         
         scanButton.layer.cornerRadius = scanButton.frame.size.height / 2
         
         collectionView.backgroundColor = .white
         collectionView?.contentInset = UIEdgeInsets(top: 5, left: 10, bottom: 0, right: 10)
    }
    
    //MARK:- Prepare for Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        var documentss = [URL]()
        
        if isFiltered {
            documentss = filteredDocuments
        } else {
            documentss = documents
        }
        
        let imageURL = documentss[documentOrderNumber]
        var documentTitle = documentss[documentOrderNumber].path.components(separatedBy: "Documents/")[1]
        documentTitle = String(Array(documentTitle)[0..<(documentTitle.count-4)])
        
        if segue.identifier == "imageDetail" {
            
            let imageDetailVC = segue.destination as! ImageDetailViewController
            imageDetailVC.pictureOrderNumber = documentOrderNumber
            imageDetailVC.imageTitle = documentTitle
            imageDetailVC.imageURL = imageURL
        }
    }
    
    deinit {
        print("deinit!!! \(self)")
    }
    
}
