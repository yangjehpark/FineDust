//
//  UITableView.swift
//  BitMax
//
//  Created by USER on 2018. 3. 5..
//  Copyright © 2018년 USER. All rights reserved.
//

import UIKit

extension UITableView {
    
    func fdRegisterCell<T: UITableViewCell>(_ type: T.Type, _ index: Int? = nil) {
        register(UINib(nibName: type.fdClassName, bundle: nil), forCellReuseIdentifier: type.fdClassName+(index != nil ? String(index!) : ""))
    }
    
    func fdRegisterCells<T: UITableViewCell>(_ types: [T.Type]) {
        types.forEach { fdRegisterCell($0) }
    }
    
    func fdRegisterHeaderFooterView<T: UITableViewHeaderFooterView>(_ type: T.Type) {
        register(UINib(nibName: type.fdClassName, bundle: nil), forHeaderFooterViewReuseIdentifier: type.fdClassName)
    }
    
    func fdRegisterHeaderFooterViews<T: UITableViewHeaderFooterView>(_ types: [T.Type]) {
        types.forEach { fdRegisterHeaderFooterView($0) }
    }
    
    func fdDequeueCell<T: UITableViewCell>(_ type: T.Type, _ indexPath: IndexPath, _ index: Int? = nil) -> T? {
        return self.dequeueReusableCell(withIdentifier: type.fdClassName+(index != nil ? String(index!) : ""), for: indexPath) as? T
    }
    
    func fdDequeueHeaderFooterView<T: UITableViewHeaderFooterView>(_ type: T.Type) -> T? {
        return self.dequeueReusableHeaderFooterView(withIdentifier: type.fdClassName) as? T
    }
    
    func fdReloadDataWithoutScrolling() {
        fdReloadWithoutAnimationAndScrolling {
            self.reloadData()
        }
    }
    
    func fdReloadRowsWithoutScrolling(at: [IndexPath], with: UITableViewRowAnimation) {
        fdReloadWithoutAnimationAndScrolling {
            self.reloadRows(at: at, with: with)
        }
    }
    
    func fdReloadSectionsWithoutScrolling(sections: IndexSet, with: UITableViewRowAnimation) {
        fdReloadWithoutAnimationAndScrolling {
            self.reloadSections(sections, with: with)
        }
    }
    
    private func fdReloadWithoutAnimationAndScrolling(closure: ()->()) {
        let offset = self.contentOffset
        UIView.performWithoutAnimation {
            closure()
        }
        self.layoutIfNeeded()
        self.setContentOffset(offset, animated: false)
    }
}

extension UICollectionView {
    
    // Register
    
    func fdRegisterCell<T: UICollectionViewCell>(_ type: T.Type) {
        self.register(UINib(nibName: type.fdClassName, bundle: nil), forCellWithReuseIdentifier: type.fdClassName)
    }
    
    func fdRegisterCells<T: UICollectionViewCell>(_ types: [T.Type]) {
        types.forEach { fdRegisterCell($0) }
    }
    
    func fdRegisterSectionHeaderView<T: UICollectionReusableView>(_ type: T.Type) {
        self.register(UINib(nibName: type.fdClassName, bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: type.fdClassName)
    }
    
    func fdRegisterSectionFooterView<T: UICollectionReusableView>(_ type: T.Type) {
        self.register(UINib(nibName: type.fdClassName, bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: type.fdClassName)
    }
    
    // Dequeue
    
    func fdDequeueCell<T: UICollectionViewCell>(_ type: T.Type, _ indexPath: IndexPath) -> T {
        return dequeueReusableCell(withReuseIdentifier: type.fdClassName, for: indexPath) as! T
    }
    
    func fdDequeueHeaderView<T: UICollectionReusableView>(_ type: T.Type, _ indexPath: IndexPath) -> T {
        return dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: type.fdClassName, for: indexPath) as! T
    }
    
    func fdDequeueFooterView<T: UICollectionReusableView>(_ type: T.Type, _ indexPath: IndexPath) -> T {
        return dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionFooter, withReuseIdentifier: type.fdClassName, for: indexPath) as! T
    }
    
    // Get
    func fdGetCell<T: UICollectionViewCell>(_ type: T.Type, _ indexPath: IndexPath) -> T? {
        return self.cellForItem(at: indexPath) as? T
    }
    
    func fdGetHeaderView<T: UICollectionReusableView>(_ type: T.Type, _ section: Int) -> T? {
        return self.supplementaryView(forElementKind: UICollectionElementKindSectionHeader, at: IndexPath(item: 0, section: section)) as? T
    }
    
    func fdGetFooterView<T: UICollectionReusableView>(_ type: T.Type, _ section: Int) -> T? {
        return self.supplementaryView(forElementKind: UICollectionElementKindSectionFooter, at: IndexPath(item: 0, section: section)) as? T
    }

}
