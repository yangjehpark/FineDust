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
        
        navigationBar.topItem?.title = "ChangeIcons".localized
        
        editTableView.delegate = self
        editTableView.dataSource = self
        editTableView.allowsSelection = true
        editTableView.allowsMultipleSelection = false
        editTableView.separatorStyle = .singleLine
        editTableView.fdRegisterCell(FDIconSelectCell.self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        editTableView.selectRow(at: IndexPath(row: IconHelper.loadUserDefaultIconOrder(), section: 0), animated: false, scrollPosition: .middle)
    }
}

extension FDIconSelectViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return IconHelper.iconArraysCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.fdDequeueCell(FDIconSelectCell.self, indexPath) {
            cell.delegate = self
            cell.icons = IconHelper.iconArrays(indexPath.row)
            cell.cellIndexPath = indexPath
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
}

extension FDIconSelectViewController: FDIconSelectCellDelegate {
    
    func didSelectItemAt(_ indexPath: IndexPath?) {
        guard let indexPath = indexPath else { return }
        editTableView.selectRow(at: indexPath, animated: false, scrollPosition: UITableViewScrollPosition.middle)
        IconHelper.saveUserDefaultIconOrder(indexPath.item)
    }
}
