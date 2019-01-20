//
//  FDEditAreaViewController.swift
//  FineDust
//
//  Created by YangJehPark on 2018. 6. 7..
//  Copyright © 2018년 YangJehPark. All rights reserved.
//

import UIKit

class FDEditAreaViewController: UIViewController {
    
    @IBOutlet weak var editTableView: UITableView!
    @IBOutlet weak var closeBarButtonItem: UIBarButtonItem!
    
    weak var superVC: UIViewController?
    
    enum Section: Int {
        case current
        case user
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        editTableView.delegate = self
        editTableView.dataSource = self
        editTableView.fdRegisterCell(FDEditAreaCell.self)
    }
 
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
        editTableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        editTableView.setEditing(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if editTableView.isEditing {
            editTableView.setEditing(false, animated: false)
        }
    }
    
    @IBAction func doneButtonPressed() {
        dismiss(animated: true) {
            
        }
    }
}

extension FDEditAreaViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch Section(rawValue: section)! {
        case .current:
            return 1
        case .user:
            tableView.separatorStyle = UserAreaManager.shared.count != 0 ? .singleLine : .none
            return UserAreaManager.shared.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch Section(rawValue: indexPath.section)! {
        case .current:
            if let cell = tableView.fdDequeueCell(FDEditAreaCell.self, indexPath) {
                cell.setup(index: 1, addressName: DataManager.shared.getCurrentAreaData()?.pointName)
                return cell
            } else {
                return UITableViewCell()
            }
        case .user:
            if let cell = tableView.fdDequeueCell(FDEditAreaCell.self, indexPath) {
                cell.setup(index: indexPath.row+2, addressName: UserAreaManager.shared.get(index: indexPath.row)?.name)
                return cell
            } else {
                return UITableViewCell()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        switch Section(rawValue: indexPath.section)! {
        case .current:
            return false
        case .user:
            return true
        }
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        switch Section(rawValue: indexPath.section)! {
        case .current:
            return .none
        case .user:
            return .delete
        }
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        switch Section(rawValue: indexPath.section)! {
        case .current:
            return false
        case .user:
            return true
        }
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        if sourceIndexPath.section != Section.current.rawValue && destinationIndexPath.section != Section.current.rawValue {
            UserAreaManager.shared.change(fromIndex: sourceIndexPath.row, toIndex: destinationIndexPath.row)
            tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath, toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath {
        guard proposedDestinationIndexPath.section != Section.current.rawValue else {
            return sourceIndexPath
        }
        return proposedDestinationIndexPath
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if indexPath.section != Section.current.rawValue {
            switch editingStyle {
            case .delete:
                UserAreaManager.shared.delete(index: indexPath.row)
                tableView.beginUpdates()
                tableView.deleteRows(at: [indexPath], with: .fade)
                tableView.endUpdates()
            default:
                break
            }
        }
    }
}

extension FDEditAreaViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return FDEditAreaCell.defaultHeight
    }
}
