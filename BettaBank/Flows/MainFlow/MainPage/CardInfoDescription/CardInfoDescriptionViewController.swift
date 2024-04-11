//
//  CardInfoDescriptionViewController.swift
//  BettaBank
//
//  Created by Дмитрий Пономарев on 17.12.2023.
//

import UIKit

private enum Constants {
    static let durationOfAnimation = 0.3
    static let heightOfCardImageView: CGFloat = 200
    static let heightOfSeparatorView: CGFloat = 1
    static let keyForAttributedText: String = "attributedMessage"
    static let cancelAlertAction = "Отмена"
}

final class ChosenCardInfoViewController: UIViewController {
    
    //  MARK: External dependencies

    private let viewModel: ChosenCardInfoViewModelProtocol
    
    //  MARK: - UI properties
    
    private let scrollView = UIScrollView()
    private let scrollContentView = UIView()
    private let cardImageView = UIImageView()
    private let customSegmentControl = CustomSegmentControl()
    private let customSeparatorLineView = UIView()
    
    private lazy var managementSegmentView = ManagementSegmentView(frame: .zero, viewModel: self.viewModel)
    private lazy var informationSegmentView = InformationSegmentView(frame: .zero, viewModel: self.viewModel)
    
    //  MARK: - init
    
    init(viewModel: ChosenCardInfoViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("ChosenCardInfoViewController deinited")
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
        setupConstraints()
        setupBackNavigationButton(type: .pop)
    }
        
    private func addViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(scrollContentView)
        scrollContentView.addSubview(cardImageView)
        scrollContentView.addSubview(customSegmentControl)
        scrollContentView.addSubview(customSeparatorLineView)
        scrollContentView.addSubview(informationSegmentView)
        scrollContentView.addSubview(managementSegmentView)
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        
        cardImageView.backgroundColor = .red
        cardImageView.layer.cornerRadius = Size.smallM
        cardImageView.clipsToBounds = true
        
        customSeparatorLineView.backgroundColor = .lightGray
        scrollView.showsVerticalScrollIndicator = false
        
        showManagementSegmentView()
        showInformationSegmentView()
        showAlertControllers()
        setupCardView()
    }
    
    private func setupCardView() {
        let cardViewModel = CardViewModel(cardData: viewModel.sendDataToCardView())
        let cardView = CardView(viewModel: cardViewModel)
        cardImageView.addSubview(cardView)
        
        cardView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
        
    private func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        scrollContentView.snp.makeConstraints { make in
            make.top.leading.trailing.size.equalTo(scrollView)
            make.bottom.equalTo(scrollView)
        }
        cardImageView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(scrollContentView).inset(Size.middleM)
            make.top.equalTo(scrollContentView).offset(Size.middleM)
            make.height.equalTo(Constants.heightOfCardImageView)
        }
        customSegmentControl.snp.makeConstraints { make in
            make.top.equalTo(cardImageView.snp.bottom).offset(Size.middleM)
            make.width.equalToSuperview().inset(Size.smallXL)
            make.centerX.equalToSuperview()
        }
        customSeparatorLineView.snp.makeConstraints { make in
            make.top.equalTo(customSegmentControl.snp.bottom)
            make.width.equalToSuperview().inset(Size.middleXL)
            make.centerX.equalToSuperview()
            make.height.equalTo(Constants.heightOfSeparatorView)
        }
        informationSegmentView.snp.makeConstraints { make in
            make.width.left.bottom.equalTo(self.view.safeAreaLayoutGuide).inset(Size.smallM)
            make.top.equalTo(customSeparatorLineView.snp.bottom).offset(Size.smallXL)
        }
        managementSegmentView.snp.makeConstraints { make in
            make.left.equalTo(informationSegmentView.snp.right)
            make.width.equalTo(self.view.safeAreaLayoutGuide).inset(Size.smallM)
            make.top.equalTo(customSeparatorLineView.snp.bottom).offset(Size.smallXL)
        }
    }
        
    //  MARK: - setup Actions

    private func showAlertControllers() {
        viewModel.showingAlertToBlockCard = { [weak self] title, message, actionText in
            guard let self else { return }
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let actionCancel = UIAlertAction(title: Constants.cancelAlertAction, style: .default)
            let actionBlock = UIAlertAction(title: actionText, style: .cancel) { _ in
                self.viewModel.changeBlockValue()
                self.managementSegmentView.reloadData()
            }
            alert.addAction(actionCancel)
            alert.addAction(actionBlock)
            
            self.present(alert, animated: true)
        }
        
        viewModel.showingAlertToCloseCard = { [weak self] title, message, actionText in
            guard let self else { return }
            let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
            alert.setValue(message, forKey: Constants.keyForAttributedText)

            let actionCancel = UIAlertAction(title: Constants.cancelAlertAction, style: .default)
            let actionBlock = UIAlertAction(title: actionText, style: .destructive) { _ in
                self.viewModel.changeBlockValue()
                self.managementSegmentView.reloadData()
            }
            alert.addAction(actionCancel)
            alert.addAction(actionBlock)
            
            self.present(alert, animated: true)
        }
    }
    
    //  MARK: - private methods

    private func showManagementSegmentView() {
        customSegmentControl.showInformationTableView = { [weak self] in
            guard let self else { return }
            UIView.animate(withDuration: Constants.durationOfAnimation) {
                self.informationSegmentView.snp.remakeConstraints { make in
                    make.width.bottom.equalTo(self.view.safeAreaLayoutGuide).inset(Size.smallM)
                    make.right.equalTo(self.view.safeAreaLayoutGuide.snp.left)
                    make.top.equalTo(self.customSeparatorLineView.snp.bottom).offset(Size.smallXL)
                }
                self.managementSegmentView.snp.remakeConstraints { make in
                    make.top.equalTo(self.customSeparatorLineView.snp.bottom).offset(Size.smallXL)
                    make.left.width.bottom.equalTo(self.view.safeAreaLayoutGuide).inset(Size.smallM)
                }
                self.view.layoutIfNeeded()
            }
        }
    }
    
    private func showInformationSegmentView() {
        
        customSegmentControl.showManagementTableView = { [weak self] in
            guard let self else { return }
            UIView.animate(withDuration: Constants.durationOfAnimation) {
                self.informationSegmentView.snp.remakeConstraints { make in
                    make.horizontalEdges.equalTo(self.view.safeAreaLayoutGuide).inset(Size.smallM)
                    make.top.equalTo(self.customSeparatorLineView.snp.bottom).offset(Size.smallXL)
                    make.bottom.equalToSuperview()
                }
                self.managementSegmentView.snp.remakeConstraints { make in
                    make.top.equalTo(self.customSeparatorLineView.snp.bottom).offset(Size.smallXL)
                    make.left.equalTo(self.informationSegmentView.snp.right)
                    make.width.bottom.equalTo(self.view.safeAreaLayoutGuide).inset(Size.smallM)
                }
                self.view.layoutIfNeeded()
            }
        }
    }
}
