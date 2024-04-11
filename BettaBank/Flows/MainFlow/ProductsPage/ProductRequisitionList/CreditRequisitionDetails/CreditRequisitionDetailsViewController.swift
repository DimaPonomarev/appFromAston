//
//  CreditRequisitionDetailsViewController.swift
//  BettaBank
//
//  Created by Vadim Blagodarny on 12.01.2024.
//

import UIKit
import SnapKit

private enum Constants {
    static let productIconTopConstraint = 90
    static let stateLabelWidth = 120
    static let stateLabelHeight = 36
    static let amountTitleLeadingTrailingConstraint = 16 // both, Size
    static let amountTitleTopConstraint = 12
    static let loanTermTitleLeadingTrailing = 16 // both, Size
    static let loanTermTitleTop = 8 // Size
    static let withdrawButtonBottom = 40
    static let withdrawButtonColor = CGColor(red: 1, green: 0, blue: 0, alpha: 1)
    static let withdrawButtonWidth = 300
    static let withdrawButtonHeight = 36
    
    static let amountTitleLabelText = "Сумма заявки"
    static let loanTermValueLabelText = "Срок кредитования"
    static let openingDateTitleLabelText = "Дата открытия"
    static let withdrawButtonText = "Отозвать заявку"
    static let interestRateSuffix = " % годовых"
    static let loanTermSuffix = " месяцев"
    static let withdrawAlertMessage = "Вы действительно хотите отозвать данную заявку?"
    static let withdrawAlertYes = "Да"
    static let withdrawAlertNo = "Нет"
}

final class CreditRequisitionDetailsViewController: UIViewController {
    
    // MARK: - external dependencies

    private let viewModel: CreditRequisitionDetailsViewModelProtocol
    
    // MARK: - UI properties
    
    private let productIcon = UIImageView()
    private let productTitleLabel = UILabel()
    private let productDescriptionLabel = UILabel()
    private let interestRateLabel = UILabel()
    private let stateLabel = ProductRequisitionStateLabel()
    private let amountTitleLabel = UILabel()
    private let amountValueLabel = UILabel()
    private let loanTermTitleLabel = UILabel()
    private let loanTermValueLabel = UILabel()
    private let openingDateTitleLabel = UILabel()
    private let openingDateValueLabel = UILabel()
    private let withdrawButton = UIButton()
    
    // MARK: - init
    
    init(viewModel: CreditRequisitionDetailsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        setupConstraints()
    }
        
    private func addViews() {
        view.addSubview(productIcon)
        view.addSubview(productTitleLabel)
        view.addSubview(productDescriptionLabel)
        view.addSubview(interestRateLabel)
        view.addSubview(stateLabel)
        view.addSubview(amountTitleLabel)
        view.addSubview(amountValueLabel)
        view.addSubview(loanTermTitleLabel)
        view.addSubview(loanTermValueLabel)
        view.addSubview(openingDateTitleLabel)
        view.addSubview(openingDateValueLabel)
        if viewModel.productData.state == .approved || viewModel.productData.state == .processing {
            view.addSubview(withdrawButton)
        }
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        let numberFormatter = CustomNumberFormatter()
        numberFormatter.configureFormatter(number: Float(viewModel.productData.amount), label: amountValueLabel)
        productIcon.image = UIImage(resource: .productsIcon)
        productTitleLabel.text = viewModel.productData.name
        productTitleLabel.font = Font.regularMiddleL
        productDescriptionLabel.text = viewModel.productData.description
        productDescriptionLabel.font = Font.regularSmallL
        interestRateLabel.text = viewModel.productData.interestRate.description
            .appending(Constants.interestRateSuffix)
        interestRateLabel.font = Font.regularSmallXL
        interestRateLabel.textColor = .gray
        stateLabel.text = viewModel.productData.state.rawValue
        stateLabel.configureState(state: viewModel.productData.state)
        amountTitleLabel.text = Constants.amountTitleLabelText
        amountTitleLabel.font = Font.regularSmallL
        amountValueLabel.font = Font.regularSmallL
        loanTermTitleLabel.text = Constants.loanTermValueLabelText
        loanTermTitleLabel.font = Font.regularSmallL
        loanTermValueLabel.text = viewModel.productData.loanTerm.description
            .appending(Constants.loanTermSuffix)
        loanTermValueLabel.font = Font.regularSmallL
        openingDateTitleLabel.text = Constants.openingDateTitleLabelText
        openingDateTitleLabel.font = Font.regularSmallL
        openingDateValueLabel.text = viewModel.productData.openingDate
        openingDateValueLabel.font = Font.regularSmallL
        if viewModel.productData.state == .approved || viewModel.productData.state == .processing {
            withdrawButton.setTitle(Constants.withdrawButtonText, for: .normal)
            withdrawButton.setTitleColor(.black, for: .normal)
            withdrawButton.titleLabel?.font = Font.regularSmallXL
            withdrawButton.layer.backgroundColor = Constants.withdrawButtonColor
            withdrawButton.layer.cornerRadius = Size.smallM
            withdrawButton.addAction(UIAction(handler: { [weak self] _ in
                self?.withdrawTapped()
            }), for: .touchUpInside)
        }
    }
        
    private func setupConstraints() {
        productIcon.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(Constants.productIconTopConstraint)
            make.size.equalTo(Size.middleXL)
            make.centerX.equalToSuperview()
        }
        productTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(productIcon.snp.bottom).offset(Size.smallXL)
            make.centerX.equalToSuperview()
        }
        productDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(productTitleLabel.snp.bottom).offset(Size.smallS)
            make.centerX.equalToSuperview()
        }
        interestRateLabel.snp.makeConstraints { make in
            make.top.equalTo(productDescriptionLabel.snp.bottom).offset(Size.smallS)
            make.centerX.equalToSuperview()
        }
        stateLabel.snp.makeConstraints { make in
            make.top.equalTo(interestRateLabel.snp.bottom).offset(Size.smallXL)
            make.centerX.equalToSuperview()
            make.width.equalTo(Constants.stateLabelWidth)
            make.height.equalTo(Constants.stateLabelHeight)
        }
        amountTitleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(Size.smallXL)
            make.top.equalTo(stateLabel.snp.bottom).offset(Size.smallL)
        }
        amountValueLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(Size.smallXL)
            make.top.equalTo(stateLabel.snp.bottom).offset(Size.smallL)
        }
        loanTermTitleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(Size.smallXL)
            make.top.equalTo(amountTitleLabel.snp.bottom).offset(Size.smallL)
        }
        loanTermValueLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(Size.smallXL)
            make.top.equalTo(amountValueLabel.snp.bottom).offset(Size.smallL)
        }
        openingDateTitleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(Size.smallXL)
            make.top.equalTo(loanTermTitleLabel.snp.bottom).offset(Size.smallL)
        }
        openingDateValueLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(Size.smallXL)
            make.top.equalTo(loanTermValueLabel.snp.bottom).offset(Size.smallL)
        }
        if viewModel.productData.state == .approved || viewModel.productData.state == .processing {
            withdrawButton.snp.makeConstraints { make in
                make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(Constants.withdrawButtonBottom)
                make.centerX.equalToSuperview()
                make.width.equalTo(Constants.withdrawButtonWidth)
                make.height.equalTo(Constants.withdrawButtonHeight)
            }
        }
    }
    
    private func withdrawTapped() {
        let alert = UIAlertController(title: nil, message: Constants.withdrawAlertMessage, preferredStyle: .alert)
        let actionNo = UIAlertAction(title: Constants.withdrawAlertNo, style: .cancel)
        let actionYes = UIAlertAction(title: Constants.withdrawAlertYes, style: .default) { [weak self] _ in
            // TODO: отозвать заявку
            self?.navigationController?.popViewController(animated: true)
        }
        alert.addAction(actionYes)
        alert.addAction(actionNo)
        
        self.present(alert, animated: true)
    }
}
