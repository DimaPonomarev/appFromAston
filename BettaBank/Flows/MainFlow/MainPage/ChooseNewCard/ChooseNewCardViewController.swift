//
//  ChooseNewCardViewController.swift
//  BettaBank
//
//  Created by Egor Kruglov on 16.11.2023.
//

import UIKit
import Combine

final class ChooseNewCardViewController: UIViewController {
    
    //  MARK: External dependencies

    let viewModel: ChooseNewCardViewModelProtocol
    
    //  MARK: - UI properties
    
    private var tableView = UITableView()
    private var cancellables: Set<AnyCancellable> = []
    private var segmentedControl = CustomSegmentedControlAllCardsToBuy()
    private var model: [ChooseNewCardModel] = []

    //  MARK: - init
    
    init(viewModel: ChooseNewCardViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print(String(describing: Self.self) + " was deinited")
    }
    
    //  MARK: - life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        viewModel.makeRequestToShowAvailableCards(index: 0)
    }
    
    //  MARK: - setup UI
    
    private func setup() {
        addViews()
        setupViews()
        setupConstraints()
        setupActions()
        setupBackNavigationButton(type: .dismiss)
    }
        
    private func addViews() {
        view.addSubview(segmentedControl)
        view.addSubview(tableView)
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        title = String.Demo.chooseCardTitle.localized()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ChooseNewCardTableViewCell.self,
            forCellReuseIdentifier: ChooseNewCardTableViewCell.identifier)
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorColor = .clear
    }
        
    private func setupConstraints() {
        segmentedControl.snp.makeConstraints { make in
            make.top.centerX.equalTo(view.layoutMarginsGuide)
            make.width.equalToSuperview().dividedBy(2)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(segmentedControl.snp.bottom)
            make.left.right.bottom.equalTo(view.layoutMarginsGuide)
        }
    }

    private func setupActions() {
        viewModel.avaibleCardsToBuyPublisher.receive(on: DispatchQueue.main).sink { [ weak self] arrayOfModels in
            guard let self else { return }
            self.model = arrayOfModels
            self.tableView.reloadData()
        }.store(in: &cancellables)

        segmentedControl.valueChangedClosure = { [weak self] value in
            guard let self else { return }
            self.viewModel.makeRequestToShowAvailableCards(index: value)
        }
    }
}

//  MARK: - extension UITableViewDataSource

extension ChooseNewCardViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
                withIdentifier: ChooseNewCardTableViewCell.identifier,
                for: indexPath) as? ChooseNewCardTableViewCell
        else { return UITableViewCell() }

        let cellViewModel = model[indexPath.row]
        cell.configureView(cellViewModel)
        return cell
    }
}

//  MARK: - extension UITableViewDelegate

extension ChooseNewCardViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)

        // TODO: Потерялся экран Показать Больше
//        let cardOption = viewModel.cardOptionsViewModels[indexPath.row].cardData.cardOption
//        let viewModel = NewCardDetailsViewModel(output: nil, cardOption: cardOption)
//        let viewController = NewCardDetailsViewController(viewModel: viewModel)
        
//        if let sheet = viewController.sheetPresentationController {
//            sheet.detents = [.medium()]
        }
        
//        self.present(viewController, animated: true)
    }
