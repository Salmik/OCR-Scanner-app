//
//  ExpandableHeaderView.swift
//  OCRApp
//
//  Created by Zhanibek Lukpanov on 08.06.2020.
//  Copyright © 2020 Zhanibek Lukpanov. All rights reserved.
//

import UIKit

protocol ExpandableHeaderViewDelegate: class {
    func toggleSection(section: Int)
}

public class ExpandableHeaderView: UITableViewHeaderFooterView {

    weak var delegate: ExpandableHeaderViewDelegate?
    var section: Int?
    
    func setup(with title: String, section: Int, delegate: ExpandableHeaderViewDelegate ) {
        self.delegate = delegate
        self.section = section
        self.textLabel?.text = title
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        textLabel?.textColor = .white
        contentView.backgroundColor = .darkGray
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectHeaderAction)))
    }
    
    @objc func selectHeaderAction(gestureRecognizer: UITapGestureRecognizer) {
        let cell = gestureRecognizer.view as? ExpandableHeaderView
        delegate?.toggleSection(section: (cell?.section)!)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
