//
//  FDIconSelectViewController.swift
//  FineDust
//
//  Created by YangJehPark on 06/02/2019.
//  Copyright © 2019 YangJehPark. All rights reserved.
//

import UIKit

class FDIconSelectViewController: FDSelectTableViewController {
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar.topItem?.title = "icons".localized
        
        editTableView.delegate = self
        editTableView.dataSource = self
        editTableView.allowsSelection = true
        editTableView.allowsMultipleSelection = false
        editTableView.separatorStyle = .singleLine
        editTableView.fdRegisterCell(FDIconSelectCell.self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        editTableView.selectRow(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: .middle)
    }
}

extension FDIconSelectViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return IconHelper.iconArrays.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.fdDequeueCell(FDIconSelectCell.self, indexPath), let icons = IconHelper.iconArrays[safe: indexPath.row] {
            cell.setup(icons: icons)
            return cell
        } else {
            return UITableViewCell()
        }
    }
}

extension FDIconSelectViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return FDIconSelectCell.defaultHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        log("didSelectRowAt=\(indexPath)")
    }
}

