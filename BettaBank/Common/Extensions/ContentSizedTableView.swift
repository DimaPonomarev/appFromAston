//
//  ContentSizedTableView.swift
//  BettaBank
//
//  Created by Egor Kruglov on 22.11.2023.
//

import UIKit

final class ContentSizedTableView: UITableView {
    override var contentSize: CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }
    
    override var intrinsicContentSize: CGSize {
        layoutIfNeeded()
        return CGSize(
            width: UIView.noIntrinsicMetric,
            height: contentSize.height
        )
    }
}
