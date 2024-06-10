//
//  CurrencyConverterViewController.swift
//  CurrencyConverterSample
//
//  Created by Andriy Kupich on 02/06/2024.
//

import UIKit
import Combine

final class CurrencyConverterViewController: UIViewController {
    private let amountTextField = UITextField()
    private let fromCurrencyPicker = UIPickerView()
    private let toCurrencyPicker = UIPickerView()
    private let loadingIndicator = UIActivityIndicatorView(style: .medium)
    private let convertedAmountLabel = UILabel()
    
    private var viewModel: ExchangeCurrencyViewModel
    
    private var cancellables: Set<AnyCancellable> = Set()
    
    init(viewModel: ExchangeCurrencyViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupUI()
        setupConstraints()
        setupActions()
        
        bindViewModel()
    }
    
    private func setupUI() {
        amountTextField.borderStyle = .roundedRect
        amountTextField.placeholder = "Enter amount"
        amountTextField.keyboardType = .decimalPad
        
        fromCurrencyPicker.dataSource = self
        fromCurrencyPicker.delegate = self
        
        toCurrencyPicker.dataSource = self
        toCurrencyPicker.delegate = self
        
        loadingIndicator.hidesWhenStopped = true
        
        convertedAmountLabel.text = "Converted Amount"
        convertedAmountLabel.textAlignment = .center
        
        view.addSubview(amountTextField)
        view.addSubview(fromCurrencyPicker)
        view.addSubview(toCurrencyPicker)
        view.addSubview(loadingIndicator)
        view.addSubview(convertedAmountLabel)
    }
    
    private func setupConstraints() {
        amountTextField.translatesAutoresizingMaskIntoConstraints = false
        fromCurrencyPicker.translatesAutoresizingMaskIntoConstraints = false
        toCurrencyPicker.translatesAutoresizingMaskIntoConstraints = false
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        convertedAmountLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            amountTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            amountTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            amountTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            fromCurrencyPicker.topAnchor.constraint(equalTo: amountTextField.bottomAnchor, constant: 20),
            fromCurrencyPicker.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            fromCurrencyPicker.trailingAnchor.constraint(equalTo: view.centerXAnchor),
            fromCurrencyPicker.heightAnchor.constraint(equalToConstant: 150),
            
            toCurrencyPicker.topAnchor.constraint(equalTo: amountTextField.bottomAnchor, constant: 20),
            toCurrencyPicker.leadingAnchor.constraint(equalTo: view.centerXAnchor),
            toCurrencyPicker.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            toCurrencyPicker.heightAnchor.constraint(equalToConstant: 150),
            
            loadingIndicator.topAnchor.constraint(equalTo: fromCurrencyPicker.bottomAnchor, constant: 20),
            loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            convertedAmountLabel.topAnchor.constraint(equalTo: loadingIndicator.bottomAnchor, constant: 20),
            convertedAmountLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            convertedAmountLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }
    
    private func setupActions() {
        amountTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    private func bindViewModel() {
        viewModel.state
            .sink(receiveValue: { [weak self] state in
                switch state {
                case .isLoading:
                    self?.loadingIndicator.startAnimating()
                case .loaded(let value):
                    self?.convertedAmountLabel.text = value
                    self?.loadingIndicator.stopAnimating()
                case .failed(let error):
                    self?.showError(message: error.localizedDescription)
                    self?.loadingIndicator.stopAnimating()
                }
            })
            .store(in: &cancellables)
    }
    
    @objc private func textFieldDidChange() {
        viewModel.amount = amountTextField.text ?? ""
    }

    private func showError(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

extension CurrencyConverterViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel.availableCurrencies.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return viewModel.availableCurrencies[row].rawValue
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == fromCurrencyPicker {
            viewModel.sourceCurrency = viewModel.availableCurrencies[row]
        } else if pickerView == toCurrencyPicker {
            viewModel.targetCurrency = viewModel.availableCurrencies[row]
        }
    }
}

