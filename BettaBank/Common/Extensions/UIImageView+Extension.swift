//
//  Extension+UIImageView.swift
//  BettaBank
//
//  Created by Дмитрий Пономарев on 10.11.2023.
//

import UIKit

extension UIImageView {
    func makeImageInStackViewForProfileScreen(image: ImageResource) {
        self.image = UIImage(resource: image)
        self.contentMode = .scaleAspectFit
        self.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    }
    
    func makeProfileImageViewForProfileScreen(image: ImageResource) {
        self.image = UIImage(resource: image)
        self.contentMode = .scaleAspectFit
        self.layer.cornerRadius = Size.middleXL
        self.clipsToBounds = true
    }
}
