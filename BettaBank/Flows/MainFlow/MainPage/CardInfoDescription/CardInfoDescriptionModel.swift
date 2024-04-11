//
//  CardInfoDescriptionModel.swift
//  BettaBank
//
//  Created by Дмитрий Пономарев on 17.12.2023.
//

import Foundation

enum SegmentsInSegmentControl {
    case information
    case management
}

struct ChosenCardInfoModel {
    var text: String
    let icon: ImageResource?
    let action: () -> Void
    
    init(text: String, icon: ImageResource? = nil, action: @escaping () -> Void) {
        self.text = text
        self.icon = icon
        self.action = action
    }
}
