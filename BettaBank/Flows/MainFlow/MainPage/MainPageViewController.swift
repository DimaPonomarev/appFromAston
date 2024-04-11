//
//  MainPageViewController.swift
//  BettaBank
//
//  Created by Egor Kruglov on 27.11.2023.
//

import UIKit

final class MainPageViewController: UIViewController {
    
    //  MARK: External dependencies
    
    var viewModel: MainPageViewModelProtocol
    
    //  MARK: - UI properties
    
    private let scrollView = UIScrollView()
    private let profileButton = UIButton()
    private let notificationButton = UIButton()
    private let walletTitleLabel = UILabel()
    private var cardsCollectionView: UICollectionView!
    private let collectionViewPageControll = UIPageControl()
    private let linksTableView = ContentSizedTableView()
    private let specialOfferView = SpecialOfferView()
    private let currenciesView = CurrenciesView()
    private let whiteBackGroundView = UIView()
    
    //  MARK: - init
    
    init(viewModel: MainPageViewModelProtocol) {
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
        setupCardCollectionView()
        addViews()
        setupViews()
        setupConstraints()
    }
    
    private func addViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(whiteBackGroundView)
        scrollView.addSubview(walletTitleLabel)
        scrollView.addSubview(collectionViewPageControll)
        scrollView.addSubview(linksTableView)
        scrollView.addSubview(specialOfferView)
        scrollView.addSubview(currenciesView)
        scrollView.addSubview(cardsCollectionView)
    }
    
    private func setupViews() {
        view.backgroundColor = UIColor.itemBackgroundColor
        
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.contentInset = .zero
        scrollView.contentOffset = .zero
        scrollView.verticalScrollIndicatorInsets = .zero
        
        setupProfileButton()
        setupNotificationButton()
        
        walletTitleLabel.text = MainPageTextLabels.walletTitle
        walletTitleLabel.font = Font.mediumMiddleM
                
        collectionViewPageControll.numberOfPages = viewModel.getNumberOfItemsInCardsCollectionView()
        collectionViewPageControll.isUserInteractionEnabled = false
        collectionViewPageControll.currentPageIndicatorTintColor = .black
        collectionViewPageControll.pageIndicatorTintColor = .black.withAlphaComponent(0.5)
        
        setupLinksTableView()
        
        whiteBackGroundView.backgroundColor = .white
        whiteBackGroundView.layer.cornerRadius = Size.smallM
        whiteBackGroundView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    private func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        walletTitleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(Size.smallXL)
            make.top.equalToSuperview().inset(Size.smallL)
        }
        
        cardsCollectionView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(self.view.safeAreaLayoutGuide).inset(Size.smallXL)
            make.top.equalTo(walletTitleLabel.snp.bottom).offset(Size.smallL)
            make.height.equalTo(MainPageSizes.cardsCollectionViewHeight)
        }
        
        collectionViewPageControll.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(cardsCollectionView.snp.bottom).offset(Size.smallM)
        }
        
        linksTableView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(self.view.safeAreaLayoutGuide).inset(Size.smallXL)
            make.top.equalTo(collectionViewPageControll.snp.bottom).offset(Size.smallXL)
        }
        
        specialOfferView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(self.view.safeAreaLayoutGuide).inset(Size.smallXL)
            make.top.equalTo(linksTableView.snp.bottom).offset(Size.smallXL)
        }
        
        currenciesView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(self.view.safeAreaLayoutGuide).inset(Size.smallXL)
            make.top.equalTo(specialOfferView.snp.bottom).offset(Size.smallXL)
            make.bottom.equalToSuperview().inset(Size.smallXL)
        }
        
        whiteBackGroundView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(self.view.safeAreaLayoutGuide)
            make.top.equalTo(linksTableView.snp.top).offset(-Size.smallM)
            make.bottom.equalToSuperview()
        }
    }
    
    //  MARK: - private methods
    
    private func setupProfileButton() {
        let userImage = UIImage(resource: .userIcon)
            .withRenderingMode(.alwaysOriginal)
            .preparingThumbnail(of: CGSize.init(width: Size.middleXL, height: Size.middleXL))
        
        profileButton.configuration = .borderless()
        profileButton.configuration?.title = String.Demo.userName.localized()
        profileButton.configuration?.baseForegroundColor = .black
        profileButton.configuration?.image = userImage
        profileButton.configuration?.imagePlacement = .leading
        profileButton.configuration?.imagePadding = Size.smallL
        profileButton.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        profileButton.addAction(
            UIAction(
                handler: { [weak self] _ in
                    self?.viewModel.goToProfileViewController()
                }
            ),
            for: .touchUpInside
        )
        
        let barButtonItem = UIBarButtonItem(customView: profileButton)
        navigationItem.leftBarButtonItem = barButtonItem
    }
    
    private func setupNotificationButton() {
        let bellImage = UIImage(resource: .bell)
            .withRenderingMode(.alwaysTemplate)
            .preparingThumbnail(of: CGSize.init(width: Size.middleM, height: Size.middleM + Size.smallS))
        notificationButton.configuration = .borderless()
        notificationButton.configuration?.baseForegroundColor = .black
        notificationButton.configuration?.image = bellImage
        notificationButton.addAction(
            UIAction(
                handler: { [weak self]  _ in
                    self?.viewModel.goToNotifications()
                }
            ),
            for: .touchUpInside
        )
        
        let barButtonItem = UIBarButtonItem(customView: notificationButton)
        navigationItem.rightBarButtonItem = barButtonItem
    }
    
    private func setupCardCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        cardsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cardsCollectionView.showsHorizontalScrollIndicator = false
        cardsCollectionView.delegate = self
        cardsCollectionView.dataSource = self
        cardsCollectionView.register(CardCell.self, forCellWithReuseIdentifier: CardCell.identifier)
        cardsCollectionView.isPagingEnabled = true
        cardsCollectionView.backgroundColor = .white
        cardsCollectionView.layer.cornerRadius = Size.smallXL
        cardsCollectionView.layer.shadowOffset = CGSize(width: 0, height: 4)
        cardsCollectionView.layer.shadowOpacity = 1
        cardsCollectionView.layer.shadowColor = UIColor.black.cgColor
        cardsCollectionView.layer.shadowRadius = 1
    }
    
    private func setupLinksTableView() {
        linksTableView.dataSource = self
        linksTableView.delegate = self
        linksTableView.showsVerticalScrollIndicator = false
        linksTableView.isScrollEnabled = false
        linksTableView.register(LinkCell.self, forCellReuseIdentifier: LinkCell.identifier)
    }
}

// MARK: - UICollectionViewDelegate

extension MainPageViewController: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x / (scrollView.frame.width + Size.smallXL))
           collectionViewPageControll.currentPage = Int(pageIndex)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.showCardInfoDescriptionPage(indexPath.row)
    }
}

// MARK: - UICollectionViewDataSource

extension MainPageViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getNumberOfItemsInCardsCollectionView()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardCell.identifier, for: indexPath) as? CardCell
        else { return UICollectionViewCell() }
        cell.viewModel = viewModel.cellsViewModels[indexPath.item]
        
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension MainPageViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        cardsCollectionView.bounds.size
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        0
    }
}

// MARK: - UITableViewDataSource

extension MainPageViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getNumberOfRowsInLinksTableView()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: LinkCell.identifier, for: indexPath) as? LinkCell
        else { return UITableViewCell() }
        
        cell.text = viewModel.getTitleForCellAt(indexPath)

        return cell
    }
}

// MARK: - UITableViewDelegate

extension MainPageViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        MainPageSizes.linksTableCellSize
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath.row {
        case 0:
            viewModel.showCards()
        case 1:
            viewModel.showDepositAccontPage()
        case 2:
            viewModel.showLoanPage()
            
        default:
            print("error tab LinkCell")
        }
    }
}
