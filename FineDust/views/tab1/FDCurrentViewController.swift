//
//  FDCurrentViewController.swift
//  FineDust
//
//  Created by YangJehPark on 2018. 5. 11..
//  Copyright © 2018년 YangJehPark. All rights reserved.
//

import UIKit

class FDCurrentViewController: UIViewController {
    
    @IBOutlet weak var topNavigationItem: UINavigationItem?

    var data: FDData? {
        didSet {
            self.dataChanged()
        }
    }
    
    @IBOutlet weak var mainTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainTableView.dataSource = self
        mainTableView.delegate = self
        let headerTypes = [FDCurrentStandardColorHeader.self, FDCurrentOtherStateHeader.self, FDCurrentInfomationHeader.self]
        let cellTypes = [FDCurrentStateCell.self, FDCurrentOtherStateCell.self, FDCurrentInfomationCell.self]
        mainTableView.fdRegisterHeaderFooterViews(headerTypes)
        mainTableView.fdRegisterCells(cellTypes)
        
        data = DataManager.shared.getCurrentAreaData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        topNavigationItem?.title = "now".localized
        mainTableView.backgroundColor = AQIStandards.getLevelBackgroundColor(AQIStandards.getLevel(data?.mainIndex))
    }
    
    enum Section: Int {
        case CurrentState = 0
        case CurrentOtherState = 1
        case CurrentInfomation = 2
        static func totalCount() -> Int {
            return 3
        }
    }
    
    func setBackgroundColor(_ color: UIColor) {
        mainTableView.backgroundColor = color
    }
    
    func dataChanged() {
        mainTableView.backgroundColor = AQIStandards.getLevelBackgroundColor(AQIStandards.getLevel(data?.mainIndex))
    }
    
    @IBAction func shareButtonPressed() {
        if let currentStateCellView = mainTableView.cellForRow(at: IndexPath(row: 0, section: Section.CurrentState.rawValue))?.contentView {
            currentStateCellView.backgroundColor = AQIStandards.getLevelBackgroundColor(AQIStandards.getLevel(data?.mainIndex))
            if let screenshot = ScreenshotHelper.takeScreenshot(tagetView: currentStateCellView) {
                print("shareButtonPressed success")
                return
            }
        }
        print("shareButtonPressed fail")
    }
    
    @IBAction func reloadButtonPressed() {
        mainTableView.reloadData()
    }
}

extension FDCurrentViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Section.totalCount()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case Section.CurrentState.rawValue:
            if let cell = tableView.fdDequeueCell(FDCurrentStateCell.self, indexPath) {
                cell.setup(data: data)
                return cell
            }
        case Section.CurrentOtherState.rawValue:
            if let cell = tableView.fdDequeueCell(FDCurrentOtherStateCell.self, indexPath) {
                cell.setup(data: data)
                return cell
            }
        case Section.CurrentInfomation.rawValue:
            if let cell = tableView.fdDequeueCell(FDCurrentInfomationCell.self, indexPath) {
                cell.setup(data: data)
                return cell
            }
        default:
            break
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case Section.CurrentState.rawValue:
            return FDCurrentStateCell.defaultHeight
        case Section.CurrentOtherState.rawValue:
            return FDCurrentOtherStateCell.defaultHeight
        case Section.CurrentInfomation.rawValue:
            return FDCurrentInfomationCell.defaultHeight
        default:
            return 0
        }
    }

    // Header
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case Section.CurrentState.rawValue:
            let header = tableView.fdDequeueHeaderFooterView(FDCurrentStandardColorHeader.self)
            header?.setup(data: data)
            return header
        case Section.CurrentOtherState.rawValue:
            let header = tableView.fdDequeueHeaderFooterView(FDCurrentOtherStateHeader.self)
            header?.setup(data: data)
            return header
        case Section.CurrentInfomation.rawValue:
            let header = tableView.fdDequeueHeaderFooterView(FDCurrentInfomationHeader.self)
            header?.setup(data: data)
            return header
        default:
            return UIView()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case Section.CurrentState.rawValue:
            return FDCurrentStandardColorHeader.defaultHeight
        case Section.CurrentOtherState.rawValue:
            return FDCurrentOtherStateHeader.defaultHeight
        case Section.CurrentInfomation.rawValue:
            return FDCurrentInfomationHeader.defaultHeight
        default:
            return 0.01
        }
    }
    
    // Footer
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20
    }
}
