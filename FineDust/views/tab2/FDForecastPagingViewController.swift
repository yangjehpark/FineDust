//
//  FDForecastPagingViewController.swift
//  FineDust
//
//  Created by YangJehPark on 2018. 5. 14..
//  Copyright © 2018년 YangJehPark. All rights reserved.
//

import UIKit

class FDForecastPagingViewController: UIPageViewController {
    
    @IBOutlet weak var topNavigationItem: UINavigationItem?
    private let minPageCount: Int = 1
    private var totalPageCount: Int {
        get {
            return minPageCount + DataManager.shared.getUserAreaDataList().count
        }
    }
    
    private var currentChildViewController: FDForecastChildViewController?
    private var currentIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate = self
        dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        topNavigationItem?.title = "예보"
        
        if currentChildViewController?.childViewControllers == nil {
            setViewControllers([getChildVC(index: currentIndex)!], direction: .forward, animated: true, completion: nil)
        }
    }
    
    @IBAction func sideMenuButtonPressed() {
        //ViewControllerHelper.openSideMenu(vc: self)
        ViewControllerHelper.openEditArea(vc: self)
    }
    
    @IBAction func addAreaButtonPressed() {
        ViewControllerHelper.openAddArea(vc: self)
    }
    
    private func getChildVC(index: Int) -> FDForecastChildViewController? {
        if index == 0 {
            return FDForecastChildViewController(index: 0, data: DataManager.shared.getCurrentAreaData() ?? FDData())
        } else {
            if let userAreaData = DataManager.shared.getUserAreaData(index: index) {
                return FDForecastChildViewController(index: index, data: userAreaData)
            } else {
                return nil
            }
        }
    }
}

extension FDForecastPagingViewController: UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        if let currentChildVC = pageViewController.viewControllers![0] as? FDForecastChildViewController {
            currentChildViewController = currentChildVC
            currentIndex = currentChildVC.pageIndex
        }
    }
}

extension FDForecastPagingViewController: UIPageViewControllerDataSource {
    
    override func setViewControllers(_ viewControllers: [UIViewController]?, direction: UIPageViewControllerNavigationDirection, animated: Bool, completion: ((Bool) -> Void)? = nil) {
        super.setViewControllers(viewControllers, direction: direction, animated: animated, completion: completion)
        
        if let last = viewControllers?.last, last.isKind(of: FDForecastChildViewController.self) {
            currentChildViewController = (last as! FDForecastChildViewController)
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        let nowIndex = (viewController as! FDForecastChildViewController).pageIndex
        return nowIndex == 0 ? nil : getChildVC(index: nowIndex-1)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let afterIndex = (viewController as! FDForecastChildViewController).pageIndex+1
        return afterIndex == totalPageCount ? nil : getChildVC(index: afterIndex)
    }
}
