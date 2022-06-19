//
//  Calculator.swift
//  DataStructureAR
//
//  Created by Jayvenn on 2022-06-19.
//

import UIKit

struct Calculator {
    static let shared = Calculator()
    struct CollectionView {
        static func getOperationCollectionViewCellSize(view: UIView, flowLayout: UICollectionViewFlowLayout) -> CGSize {
            let horizontalInsets = flowLayout.sectionInset.left + flowLayout.sectionInset.right
            let minimumInteritemSpacing = flowLayout.minimumLineSpacing
            let horizontalItemsCount: CGFloat = 2
            let width = ((view.frame.width - 2 - horizontalInsets) - (horizontalItemsCount - 1) * minimumInteritemSpacing) / horizontalItemsCount
            let height = view.frame.height - 80
            let size = CGSize(width: width, height: height)
            return size
        }
    }
}
