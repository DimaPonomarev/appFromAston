//
//  PinCodeSetupViewController.swift
//  BettaBank
//
//  Created by Vadim Blagodarny on 20.12.2023.
//

import UIKit
import SnapKit

private enum Constants {
    static let numbersRowOne: ClosedRange<Int> = 1...3
    static let numbersRowTwo: ClosedRange<Int> = 4...6
    static let numbersRowThree: ClosedRange<Int> = 7...9
    
    static let dotInactiveColor = UIColor(red: 0.769, green: 0.769, blue: 0.769, alpha: 0.5)

    static let dotStackSpacing: CGFloat = 8
    static let numbersHorizontalSpacing: CGFloat = 36
    static let numbersVerticalSpacing: CGFloat = 20

    static let undoButtonTagValue = 10
    static let dotSize = 20
    static let byTwoMultiplier = 2
    static let pinCodeEntryLabelTopOffset = 88
    static let pinCodeEntrySpotsWidth = 104
    static let pinCodeEntrySpotsHeight = 20
    static let numberButtonVStackTopOffset = 72
    static let numberButtonVStackWidth = 264
    static let numberButtonVStackHeight = 316
    static let changePinCodeButtonHeight = 48
    static let numberButtonSize = 64
    
    static let pinCodeEntryLabelText = "Придумайте ПИН-код"
    static let changePinCodeButtonTitle = "Изменить"
    static let viewTitle = "Изменить ПИН-код"
}

private class DotView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.cornerRadius = CGFloat(Constants.dotSize / Constants.byTwoMultiplier)
        clipsToBounds = true
        backgroundColor = Constants.dotInactiveColor
        snp.makeConstraints { make in
            make.size.equalTo(Constants.dotSize)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func switchState() {
        if tag == 0 {
            backgroundColor = .black
            tag = 1
        } else if tag == 1 {
            backgroundColor = Constants.dotInactiveColor
            tag = 0
        }
    }
}

private class DotStackView: UIStackView {
    var activeDots = Int.zero
    var dots: [DotView]
    
    override init(frame: CGRect) {
        
        let dotOne = DotView()
        let dotTwo = DotView()
        let dotThree = DotView()
        let dotFour = DotView()
        
        self.dots = [dotOne, dotTwo, dotThree, dotFour]
        
        super.init(frame: frame)

        axis = .horizontal
        spacing = Constants.dotStackSpacing

        dots.forEach { spotView in
            addArrangedSubview(spotView)
        }
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func incrementDot() {
        dots[activeDots].switchState()
        activeDots += 1
    }
    
    func decrementDot() {
        activeDots -= 1
        dots[activeDots].switchState()
    }
}

private class NumberButtonHStack: UIStackView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        axis = .horizontal
        spacing = Constants.numbersHorizontalSpacing
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final class PinCodeSetupViewController: UIViewController {
    
    // MARK: - external dependencies

    private let viewModel: PinCodeSetupViewModelProtocol
    
    // MARK: - UI properties
    
    private let pinCodeEntryLabel = UILabel()
    private let pinCodeEntryDots = DotStackView()
    private let numberButtonVStack = UIStackView()
    private let numberButtonRowOne = NumberButtonHStack()
    private let numberButtonRowTwo = NumberButtonHStack()
    private let numberButtonRowThree = NumberButtonHStack()
    private let numberButtonRowFour = NumberButtonHStack()
    private let changePinCodeButton = UIButton()
        
    // MARK: - init
    
    init(viewModel: PinCodeSetupViewModelProtocol) {
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
        setupPinButtons()
    }
        
    private func addViews() {
        view.addSubview(pinCodeEntryLabel)
        view.addSubview(pinCodeEntryDots)
        view.addSubview(numberButtonVStack)
        numberButtonVStack.addArrangedSubview(numberButtonRowOne)
        numberButtonVStack.addArrangedSubview(numberButtonRowTwo)
        numberButtonVStack.addArrangedSubview(numberButtonRowThree)
        numberButtonVStack.addArrangedSubview(numberButtonRowFour)
        view.addSubview(changePinCodeButton)
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        title = Constants.viewTitle
        setupBackNavigationButton(type: .pop)
        
        pinCodeEntryLabel.text = Constants.pinCodeEntryLabelText
        pinCodeEntryLabel.font = Font.regularSmallXL
        pinCodeEntryLabel.textAlignment = .center

        numberButtonVStack.axis = .vertical
        numberButtonVStack.spacing = Constants.numbersVerticalSpacing
        
        changePinCodeButton.setTitle(Constants.changePinCodeButtonTitle, for: .normal)
        changePinCodeButton.titleLabel?.font = Font.boldSmallXL
        changePinCodeButton.setTitleColor(.black, for: .normal)
        changePinCodeButton.backgroundColor = .yellowButtonColor
        changePinCodeButton.layer.cornerRadius = Size.smallM
        changePinCodeButton.addAction(UIAction(handler: { [weak self] _ in
            guard let self else { return }
            self.changePinCodeButtonTapped()
        }), for: .touchUpInside)

    }
        
    private func setupConstraints() {
        pinCodeEntryLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
                .offset(Constants.pinCodeEntryLabelTopOffset)
            make.leading.equalToSuperview()
                .offset(Size.middleXL)
            make.trailing.equalToSuperview()
                .inset(Size.middleXL)
        }
        
        pinCodeEntryDots.snp.makeConstraints { make in
            make.top.equalTo(pinCodeEntryLabel.snp.bottom)
                .offset(Size.smallL)
            make.centerX.equalToSuperview()
            make.width.equalTo(Constants.pinCodeEntrySpotsWidth)
            make.height.equalTo(Constants.pinCodeEntrySpotsHeight)
        }
        
        numberButtonVStack.snp.makeConstraints { make in
            make.top.equalTo(pinCodeEntryDots.snp.bottom)
                .offset(Constants.numberButtonVStackTopOffset)
            make.centerX.equalToSuperview()
            make.width.equalTo(Constants.numberButtonVStackWidth)
            make.height.equalTo(Constants.numberButtonVStackHeight)
        }
        
        changePinCodeButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
                .inset(Size.middleXL)
            make.leading.equalToSuperview()
                .offset(Size.middleXL)
            make.trailing.equalToSuperview()
                .inset(Size.middleXL)
            make.height.equalTo(Constants.changePinCodeButtonHeight)
        }
    }
        
    private func setupPinButtons() {
        setupButtonRow(stack: numberButtonRowOne, 
                       range: Constants.numbersRowOne)
        setupButtonRow(stack: numberButtonRowTwo, 
                       range: Constants.numbersRowTwo)
        setupButtonRow(stack: numberButtonRowThree, 
                       range: Constants.numbersRowThree)
        setupButtonLastRow(stack: numberButtonRowFour)
    }
    
    private func setupButtonRow(stack: UIStackView, range: ClosedRange<Int>) {
        for number in range {
            let numberButton = createNumberButton(number: number)
            stack.addArrangedSubview(numberButton)
        }
    }
    
    private func setupButtonLastRow(stack: UIStackView) {
        stack.addArrangedSubview(createSpacer())
        stack.addArrangedSubview(createNumberButton(number: Int.zero))
        stack.addArrangedSubview(createUndoButton())
    }
    
    private func createSpacer() -> UIView {
        let spacer = UIView()
        spacer.snp.makeConstraints { make in
            make.size.equalTo(Constants.numberButtonSize)
        }
        return spacer
    }

    private func createNumberButton(number: Int) -> UIButton {
        let numberButton = UIButton()
        numberButton.titleLabel?.font = Font.boldLargeM
        numberButton.setTitleColor(.black, for: .normal)
        numberButton.addAction(UIAction(handler: { [weak self] _ in
            guard let self else { return }
            self.numberButtonTap(number: numberButton.tag)
        }), for: .touchUpInside)
        numberButton.setTitle("\(number)", for: .normal)
        numberButton.tag = number
        numberButton.snp.makeConstraints { make in
            make.size.equalTo(Constants.numberButtonSize)
        }
        return numberButton
    }
    
    private func createUndoButton() -> UIButton {
        let undoButton = UIButton()
        undoButton.setImage(UIImage(resource: .pinCodeErase), for: .normal)
        undoButton.tintColor = .black
        undoButton.addAction(UIAction(handler: { [weak self] _ in
            guard let self else { return }
            self.numberButtonTap(number: undoButton.tag)
        }), for: .touchUpInside)
        undoButton.tag = Constants.undoButtonTagValue
        undoButton.snp.makeConstraints { make in
            make.size.equalTo(Constants.numberButtonSize)
        }
        return undoButton
    }

    // MARK: - private methods

    private func numberButtonTap(number: Int) {
        if number < Constants.undoButtonTagValue {
            if pinCodeEntryDots.activeDots < pinCodeEntryDots.dots.count {
                viewModel.pinCodeValue.append(String(number))
                pinCodeEntryDots.incrementDot()
            }
        } else if number ==
                    Constants.undoButtonTagValue &&
                    pinCodeEntryDots.activeDots > 0 {
            viewModel.pinCodeValue.remove(at: viewModel.pinCodeValue.index(before: viewModel.pinCodeValue.endIndex))
            pinCodeEntryDots.decrementDot()
        }
    }
    
    private func changePinCodeButtonTapped() {
        guard pinCodeEntryDots.activeDots == pinCodeEntryDots.dots.count else { return }
        viewModel.changePinCode()
    }
}
