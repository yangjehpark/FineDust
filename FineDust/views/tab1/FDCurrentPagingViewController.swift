//
//  FDCurrentPagingViewController.swift
//  FineDust
//
//  Created by YangJehPark on 2018. 5. 11..
//  Copyright © 2018년 YangJehPark. All rights reserved.
//

import UIKit

class FDCurrentPagingViewController: UIPageViewController {
    
    @IBOutlet weak var topNavigationItem: UINavigationItem?
    private let minPageCount: Int = 1
    private var totalPageCount: Int {
        get {
            return minPageCount + DataManager.shared.getUserAreaDataList().count
        }
    }
    
    private var currentChildViewController: FDCurrentChildViewController?
    private var currentIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate = self
        dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        topNavigationItem?.title = "now".localized
        
        if currentChildViewController?.childViewControllers == nil {
            setViewControllers([getChildVC(index: currentIndex)!], direction: .forward, animated: true, completion: nil)
        }
    }
    
    @IBAction func shareButtonPressed() {
        print("shareButtonPressed")
    }

    private func getChildVC(index: Int) -> FDCurrentChildViewController? {
        if index == 0 {
            return FDCurrentChildViewController(index: 0, data: DataManager.shared.getCurrentAreaData() ?? FDData())
        } else {
            if let userAreaData = DataManager.shared.getUserAreaData(index: index) {
                return FDCurrentChildViewController(index: index, data: userAreaData)
            } else {
                return nil
            }
        }
    }
}

extension FDCurrentPagingViewController: UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        if let currentChildVC = pageViewController.viewControllers![0] as? FDCurrentChildViewController {
            currentChildViewController = currentChildVC
            currentIndex = currentChildVC.pageIndex
        }
    }
}

extension FDCurrentPagingViewController: UIPageViewControllerDataSource {
    
    override func setViewControllers(_ viewControllers: [UIViewController]?, direction: UIPageViewControllerNavigationDirection, animated: Bool, completion: ((Bool) -> Void)? = nil) {
        super.setViewControllers(viewControllers, direction: direction, animated: animated, completion: completion)
        
        if let last = viewControllers?.last, last.isKind(of: FDCurrentChildViewController.self) {
            currentChildViewController = (last as! FDCurrentChildViewController)
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        let nowIndex = (viewController as! FDCurrentChildViewController).pageIndex
        
        return nowIndex == 0 ? nil : getChildVC(index: nowIndex-1)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let afterIndex = (viewController as! FDCurrentChildViewController).pageIndex+1
        
        return afterIndex == totalPageCount ? nil : getChildVC(index: afterIndex)
    }
}
