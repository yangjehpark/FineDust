//
//  FDAddAreaViewController.swift
//  FineDust
//
//  Created by YangJehPark on 2018. 5. 15..
//  Copyright © 2018년 YangJehPark. All rights reserved.
//

import UIKit

class FDAddAreaViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var resultTableview: UITableView!
   
    weak var superVC: UIViewController?
    var data = [KakaoSearchDocument]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        searchBar.placeholder = "Please search your address"
        resultTableview.delegate = self
        resultTableview.dataSource = self
        resultTableview.separatorStyle = .none
        resultTableview.fdRegisterCell(FDAddAreaSearchCell.self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        searchBar.becomeFirstResponder()
    }
    
    @IBAction func closeButtonPressed() {
        close()
    }
    
    func query(_ query: String, _ page: Int? = nil) {
        let parameter = KakaoParameters.Search(query: query, page: nil, size: nil)
        KakaoAPI.searchAddress(parameter: parameter) { (response:KakaoSearchResponse?) in
            if let documents = response?.documents {
                self.data = documents
                self.resultTableview.reloadData()
            }
        }
    }
    
    func close() {
        searchBar.resignFirstResponder()
        dismiss(animated: true) {
            
        }
    }
}

extension FDAddAreaViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let queryString = searchBar.text {
            query(queryString)
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        log("cancel")
    }
}

extension FDAddAreaViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.fdDequeueCell(FDAddAreaSearchCell.self, indexPath), let datum = data[safe: indexPath.row], let name = datum.address?.address_name {
            cell.setup(datum)
            if UserAreaManager.shared.has(addressName: name) {
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .none
            }
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return FDAddAreaSearchCell.defaultHeight
    }
}

extension FDAddAreaViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        log("didSelectRowAt:\(indexPath)")
        guard let name = data[safe: indexPath.row]?.address_name else {
            return
        }
        guard let x = data[safe: indexPath.row]?.address?.x else {
            return
        }
        guard let y = data[safe: indexPath.row]?.address?.y else {
            return
        }
        if UserAreaManager.shared.has(addressName: name) {
            tableView.cellForRow(at: indexPath)?.isSelected = false
        } else {
            UserAreaManager.shared.save(area: UserArea(name: name, latitude: x, longitude: y))
            close()
        }
    }
}
