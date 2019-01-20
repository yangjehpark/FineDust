//
//  FDForecastChildViewController.swift
//  FineDust
//
//  Created by YangJehPark on 2018. 5. 14..
//  Copyright © 2018년 YangJehPark. All rights reserved.
//

import UIKit

class FDForecastChildViewController: UIViewController {
    
    var pageIndex = 0
    @IBOutlet weak var label: UILabel?
    @IBOutlet weak var mainTableView: UITableView!
    
    convenience init(index: Int, data:FDData?) {
        self.init()
        self.pageIndex = index
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        label?.text = "\(pageIndex)"
        
        mainTableView.dataSource = self
        mainTableView.delegate = self
        mainTableView.fdRegisterCell(FDForecastCell.self)
        mainTableView.fdRegisterHeaderFooterView(FDForecastSectionHeaderView.self)
    }
    
    enum Section: Int {
        case Today = 0
        case Tommorow = 1
        case TheDayAfterTomorrow = 2
        static func totalCount() -> Int {
            return 3
        }
    }
}

extension FDForecastChildViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Section.totalCount()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.fdDequeueCell(FDForecastCell.self, indexPath) {
            cell.setup()
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return FDForecastCell.defaultHeight
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let header = tableView.fdDequeueHeaderFooterView(FDForecastSectionHeaderView.self) {
            header.setup(title:"\(section)")
            return header
        } else {
            return nil
        }
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return FDForecastSectionHeaderView.defaultHeight
    }
    
    
}
