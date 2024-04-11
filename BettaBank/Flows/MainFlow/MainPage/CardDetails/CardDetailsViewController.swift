//
//  CardDetailsViewController.swift
//  BettaBank
//
//  Created by Vadim Blagodarny on 11.12.2023.
//

import UIKit
import SnapKit

private enum Constants {
    static let cardHolderDescription = "Держатель счета"
    static let cardHolderTitle = "Ирина Иванова"
    static let cardTypeDescription = "Тип карты"
    static let cardTypeTitle = "Дебетовая"
    static let cardNumberDescription = "Номер карты"
    static let cardNumberTitle = "1234 5678 9012 3456"
    static let cardDateDescription = "Срок действия"
    static let cardDateTitle = "09/23"
    static let cardCVCDescription = "CVC"
    static let cardCVCTitle = "564"
    static let cardCurrencyDescription = "Валюта"
    static let cardCurrencyTitle = "RUB"
    static let detailsCopiedTitle = "Реквизиты скопированы в буфер"
    static let copyDetailsTitle = "Копировать реквизиты"
    
    static let pasteBoardButtonSize = CGSize(width: 20, height: 20)
    static let detailsCopiedColor = UIColor(red: 0.298, green: 0.686, blue: 0.314, alpha: 1)
    
    static let copyDetailsButtonHeight = 48
    static let copyDetailsButtonWidth = 215
    
}

final class CardDetailsViewController: UIViewController {
    
    // MARK: - external dependencies
    
    private var viewModel: CardDetailsViewModelProtocol
    
    // MARK: - private properties
    
    private let items = [CardDetailsItemsModel(description: Constants.cardHolderDescription,
                                    title: Constants.cardHolderTitle),
                         CardDetailsItemsModel(description: Constants.cardTypeDescription,
                                    title: Constants.cardTypeTitle),
                         CardDetailsItemsModel(description: Constants.cardNumberDescription,
                                    title: Constants.cardNumberTitle),
                         CardDetailsItemsModel(description: Constants.cardDateDescription,
                                    title: Constants.cardDateTitle),
                         CardDetailsItemsModel(description: Constants.cardCVCDescription,
                                    title: Constants.cardCVCTitle),
                         CardDetailsItemsModel(description: Constants.cardCurrencyDescription,
                                    title: Constants.cardCurrencyTitle)]
    
    private let cardDetails = CardDetailsDataModel(cardHolder: Constants.cardHolderTitle,
                                          cardType: Constants.cardTypeTitle,
                                          cardNumber: Constants.cardNumberTitle,
                                          cardDate: Constants.cardDateTitle,
                                          cardCVC: Constants.cardCVCTitle,
                                          cardCurrency: Constants.cardCurrencyTitle)
    
    // MARK: - UI properties
    
    private let stackView = UIStackView()
    
    private let descriptionLabel = UILabel()
    private let titleLabel = UILabel()
    private let pasteBoardButton = UIButton()
    
    private let detailsCopiedView = UIView()
    private let detailsCopiedImageView = UIImageView()
    private let detailsCopiedLabel = UILabel()
    
    private let copyDetailsButton = UIButton()
    
    // MARK: - init
    
    init(viewModel: CardDetailsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    // MARK: - setup UI
    
    private func setup() {
        addViews()
        setupViews()
        setupStackView()
        setupConstraints()
        setupBackNavigationButton(type: .pop)
    }
    
    private func addViews() {
        view.addSubview(stackView)
        view.addSubview(copyDetailsButton)
        view.addSubview(detailsCopiedView)
        detailsCopiedView.addSubview(detailsCopiedImageView)
        detailsCopiedView.addSubview(detailsCopiedLabel)
    }
    
    private func setupStackView() {
        stackView.axis = .vertical
        stackView.spacing = Size.middleM
        
        items.forEach { model in
            let itemsView = UIView()
            let descriptionLabel = UILabel()
            let titleLabel = UILabel()
            let pasteBoardButton = UIButton(primaryAction: UIAction(handler: { [weak self] _ in
                self?.viewModel.pasteBoardCopySingle(text: model.title)
            }))
            
            setupItemsView(model: model,
                           itemsView: itemsView,
                           descriptionLabel: descriptionLabel,
                           titleLabel: titleLabel,
                           pasteBoardButton: pasteBoardButton)

            stackView.addArrangedSubview(itemsView)
            
            setupItemsViewConstraints(itemsView: itemsView,
                                      descriptionLabel: descriptionLabel,
                                      titleLabel: titleLabel,
                                      pasteBoardButton: pasteBoardButton)
        }
    }
    
    private func setupViews() {
        view.backgroundColor = .white
                
        copyDetailsButton.titleLabel?.font = Font.regularSmallXL
        copyDetailsButton.setTitleColor(.black, for: .normal)
        copyDetailsButton.backgroundColor = .yellowButtonColor
        copyDetailsButton.layer.cornerRadius = Size.smallM
        copyDetailsButton.setTitle(Constants.copyDetailsTitle, for: .normal)
        copyDetailsButton.addAction(UIAction(handler: { [weak self] _ in
            guard let self else { return }
            viewModel.pasteBoardCopyComplete(descriptions: self.items,
                                             details: self.cardDetails)
            detailsCopiedView.isHidden = false

        }), for: .touchUpInside)

        detailsCopiedView.isHidden = true

        detailsCopiedImageView.image = UIImage(resource: .greenCheck)
        
        detailsCopiedLabel.text = Constants.detailsCopiedTitle
        detailsCopiedLabel.textColor = Constants.detailsCopiedColor
        detailsCopiedLabel.font = Font.mediumSmallXL
        
    }
    
    private func setupConstraints() {
        stackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalToSuperview().offset(Size.middleXL)
            make.trailing.equalToSuperview()
        }
        
        copyDetailsButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(Size.middleM)
            make.centerX.equalToSuperview()
            make.height.equalTo(Constants.copyDetailsButtonHeight)
            make.width.equalTo(Constants.copyDetailsButtonWidth)
        }
        
        detailsCopiedView.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(stackView.snp.bottom).offset(Size.middleM)
        }

        detailsCopiedImageView.snp.makeConstraints { make in
            make.leading.equalTo(detailsCopiedView)
            make.size.equalTo(Size.middleM)
        }
        
        detailsCopiedLabel.snp.makeConstraints { make in
            make.leading.equalTo(detailsCopiedImageView.snp.trailing).offset(Size.smallL)
            make.trailing.equalToSuperview()
            make.centerY.equalTo(detailsCopiedImageView)
        }
    }
    
    private func setupItemsView(model: CardDetailsItemsModel,
                                itemsView: UIView,
                                descriptionLabel: UILabel,
                                titleLabel: UILabel,
                                pasteBoardButton: UIButton) {
        
        descriptionLabel.text = model.description
        descriptionLabel.font = Font.regularSmallL
        descriptionLabel.textColor = .darkGray
                    
        titleLabel.text = model.title
        titleLabel.font = Font.regularSmallXL
        titleLabel.textColor = .black
        
        pasteBoardButton.setImage(UIImage(resource: .pasteBoard)
            .resized(to: Constants.pasteBoardButtonSize),
                                  for: .normal)
        pasteBoardButton.tintColor = .black

        itemsView.addSubview(descriptionLabel)
        itemsView.addSubview(titleLabel)
        itemsView.addSubview(pasteBoardButton)
    }
    
    private func setupItemsViewConstraints(itemsView: UIView,
                                           descriptionLabel: UILabel,
                                           titleLabel: UILabel,
                                           pasteBoardButton: UIButton) {
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(itemsView.snp.top)
            make.leading.equalTo(itemsView.snp.leading)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(Size.smallS)
            make.leading.equalTo(itemsView.snp.leading)
            make.bottom.equalTo(itemsView.snp.bottom)
        }
        
        pasteBoardButton.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel.snp.centerY)
            make.trailing.equalToSuperview().inset(Size.middleXL)
        }
    }    
}
