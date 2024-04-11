//
//  PaymentViewController.swift
//  BettaBank
//
//  Created by Софья Норина on 28.11.2023.
//

import UIKit
import SnapKit

private enum Constants {
    static let multiplier: CGFloat = 0.17
}

final class PaymentViewController: UIViewController {
    
    //  MARK: External dependencies
    
    private let viewModel: PaymentViewModelProtocol
    
    //  MARK: - UI properties
    private let buttonView = UIView()
    private let checkButton = UIButton()
    private let checkButtoLabel = UILabel()
    private let createTemplButton = UIButton()
    private let createTemplButtonLabel = UILabel()
    private let createAutoPayButton = UIButton()
    private let createAutoPayButtonLabel = UILabel()
    private let tableView = UITableView()
    private let checkImage = UIImage(resource: .checkIcon)
    private let createImage = UIImage(resource: .plusIcon)
    
    //  MARK: - private properties
    
    private let cellId = PaymentConstants.cellId
    
    //  MARK: - init
    
    init(viewModel: PaymentViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //  MARK: - life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    //  MARK: - setup UI
    
    private func setup() {
        addViews()
        setupViews()
        setupButtonConstraints()
        setupLabelConstraints()
        setupTableConstraints()
    }
    
    private func addViews() {
        view.addSubview(buttonView)
        [checkButton,
         checkButtoLabel,
         createTemplButton,
         createTemplButtonLabel,
         createAutoPayButton,
         createAutoPayButtonLabel].forEach {
            buttonView.addSubview($0)
        }
        view.addSubview(tableView)
    }
    
    private func setupButtonConstraints() {
        
        buttonView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(Size.middleS)
            make.horizontalEdges.equalToSuperview().inset(Size.smallXL)
            make.height.equalToSuperview().multipliedBy(Constants.multiplier)
        }
        
        checkButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Size.smallM)
            make.leading.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(Constants.multiplier)
            make.height.equalTo(checkButton.snp.width)
        }
        
        createTemplButton.snp.makeConstraints { make in
            make.centerY.equalTo(checkButton.snp.centerY)
            make.width.equalTo(checkButton.snp.width)
            make.height.equalTo(createTemplButton.snp.width)
            make.leading.equalTo(checkButton.snp.trailing).offset(Size.middleM)
        }
        
        createAutoPayButton.snp.makeConstraints { make in
            make.centerY.equalTo(checkButton.snp.centerY)
            make.width.equalTo(checkButton.snp.width)
            make.height.equalTo(createTemplButton.snp.width)
            make.leading.equalTo(createTemplButton.snp.trailing).offset(Size.middleM)
        }
        
    }
    
    private func setupLabelConstraints() {
        
        checkButtoLabel.snp.makeConstraints { make in
            make.top.equalTo(checkButton.snp.bottom).offset(Size.smallM)
            make.centerX.equalTo(checkButton.snp.centerX)
            
        }
        
        createTemplButtonLabel.snp.makeConstraints { make in
            make.top.equalTo(createTemplButton.snp.bottom).offset(Size.smallM)
            make.centerX.equalTo(createTemplButton.snp.centerX)
            make.width.equalTo(createTemplButton.snp.width)
        }
        
        createAutoPayButton.snp.makeConstraints { make in
            make.centerY.equalTo(checkButton.snp.centerY)
            make.width.equalTo(checkButton.snp.width)
            make.height.equalTo(createTemplButton.snp.width)
            make.leading.equalTo(createTemplButton.snp.trailing).offset(Size.middleM)
        }
        
        createAutoPayButtonLabel.snp.makeConstraints { make in
            make.top.equalTo(createAutoPayButton.snp.bottom).offset(Size.smallM)
            make.centerX.equalTo(createAutoPayButton.snp.centerX)
            make.width.equalTo(createAutoPayButton.snp.width)
        }
    }
    
    private func setupTableConstraints() {
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(buttonView.snp.bottom)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    private func setupViews() {
        
        title = PaymentConstants.titleString
        view.backgroundColor = .mainBackgroundColor
        
        navigationController?.navigationBar.tintColor = .textFieldPlaceholder
        navigationController?.navigationBar.topItem?.backButtonTitle = ""
        
        tableView.register(PaymentCellView.self, forCellReuseIdentifier: cellId)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.backgroundColor = UIColor.mainBackgroundColor
        tableView.separatorStyle = .none
        
        setupButton(text: PaymentConstants.checkLabelString,
                    nameButton: checkButtoLabel,
                    button: checkButton,
                    buttonImage: checkImage)
        setupButton(text: PaymentConstants.createTemplString,
                    nameButton: createTemplButtonLabel,
                    button: createTemplButton,
                    buttonImage: createImage)
        setupButton(text: PaymentConstants.createAutoString,
                    nameButton: createAutoPayButtonLabel,
                    button: createAutoPayButton,
                    buttonImage: createImage)
    }
    
    //  MARK: - private func
    
    private func setupButton(text: String, nameButton: UILabel, button: UIButton, buttonImage: UIImage) {
        nameButton.text = text
        nameButton.font = Font.regularSmallL
        nameButton.minimumScaleFactor = 0.5
        nameButton.adjustsFontSizeToFitWidth = true
        nameButton.numberOfLines = 2
        nameButton.textAlignment = .center
        
        button.setImage(buttonImage, for: .normal)
    }
}

extension PaymentViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? PaymentCellView else {
            return UITableViewCell()
        }
        cell.configure(model: viewModel.data[indexPath.row])
        return cell
    }
}
