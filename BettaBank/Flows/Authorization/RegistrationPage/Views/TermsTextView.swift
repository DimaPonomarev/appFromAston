//
//  TermsTextView.swift
//  BettaBank
//
//  Created by Dzhami on 07.12.2023.
//

import UIKit

private enum Constants {
    static let termsAndConditionsUrl = "terms://termsAndConditions"
    static let privacyPolicyUrl = "privacy://privacyPolicy"
}

final class TermsTextView: UITextView {
    
    // MARK: - Initialization
    
    init() {
        super.init(frame: .zero, textContainer: nil)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    // MARK: - Configuration
    
    private func configure() {
        let attributedString = NSMutableAttributedString(string: TextLabels.LoginVC.terms)
        attributedString.addAttribute(
            .link,
            value: Constants.termsAndConditionsUrl,
            range: (attributedString.string as NSString).range(of: TextLabels.LoginVC.termsOfUse))
        
        attributedString.addAttribute(
            .link,
            value: Constants.privacyPolicyUrl,
            range: (attributedString.string as NSString).range(of: TextLabels.LoginVC.privacyPolicy))
        
        attributedString.addAttribute(
            .link,
            value: Constants.privacyPolicyUrl,
            range: (attributedString.string as NSString).range(of: TextLabels.LoginVC.dataStorage))
        
        self.linkTextAttributes = [.foregroundColor: UIColor.blueButton]
        self.backgroundColor = .clear
        self.attributedText = attributedString
        self.textColor = .label
        self.textAlignment = .justified
        self.isSelectable = true
        self.isEditable = false
        self.delaysContentTouches = false
        self.isScrollEnabled = false
    }
}
