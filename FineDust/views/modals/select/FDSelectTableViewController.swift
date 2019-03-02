//
//  FDSelectTableViewController.swift
//  FineDust
//
//  Created by YangJehPark on 06/02/2019.
//  Copyright © 2019 YangJehPark. All rights reserved.
//

import UIKit

class FDSelectTableViewController: FDViewController {
    
    @IBOutlet weak var editTableView: UITableView!
    @IBOutlet weak var closeBarButtonItem: UIBarButtonItem!
    
    weak var superVC: FDViewController?
    
    @IBAction func doneButtonPressed() {
        superVC?.modalWillDisappear()
        dismiss(animated: true) {
            self.superVC?.modalDidDisappear()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
        editTableView.reloadData()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if editTableView.isEditing {
            editTableView.setEditing(false, animated: false)
        }
    }

}

