//
//  ViewController.swift
//  HomeWork12
//
//  Created by Denis Solovkin on 02.06.2022.
//

import UIKit

class ViewController: UIViewController {
    
    var timer = Timer()
    var isStarted = true
    var isWorkTime = false
    var time = 1500
    
    private lazy var label: UILabel = {
        var label = UILabel()
        label.font = .systemFont(ofSize: Metric.labelfondSize)
        label.text = Strings.labelText
        return label
    }()
    
    private lazy var buttonStart: UIButton = {
        var buttonStart = UIButton(type: .system)
        buttonStart.setTitle(Strings.buttonTitleStart, for: .normal)
        buttonStart.addTarget(self, action: #selector(buttonActionStart), for: .touchUpInside)
        buttonStart.setTitleColor(.white, for: .normal)
        buttonStart.titleLabel?.font =  .systemFont(ofSize: Metric.buttonFondCize)
        buttonStart.backgroundColor = .black
        buttonStart.layer.masksToBounds = true
        buttonStart.layer.cornerRadius = Metric.buttonCornerRadius
        return buttonStart
    }()
    
    private lazy var buttonRelax: UIButton = {
        var buttonRelax = UIButton(type: .system)
        buttonRelax.setTitle(Strings.buttonTitlePause, for: .normal)
        buttonRelax.addTarget(self, action: #selector(buttonActionRelax), for: .touchUpInside)
        buttonRelax.setTitleColor(.white, for: .normal)
        buttonRelax.titleLabel?.font =  .systemFont(ofSize: Metric.buttonFondCize)
        buttonRelax.backgroundColor = .black
        buttonRelax.layer.masksToBounds = true
        buttonRelax.layer.cornerRadius = Metric.buttonCornerRadius
        return buttonRelax
    }()
    
    private lazy var buttonReset: UIButton = {
        var buttonReset = UIButton(type: .system)
        buttonReset.setTitle(Strings.buttonTitleReset, for: .normal)
        buttonReset.addTarget(self, action: #selector(buttonActionReset), for: .touchUpInside)
        buttonReset.setTitleColor(.white, for: .normal)
        buttonReset.titleLabel?.font =  .systemFont(ofSize: Metric.buttonFondCize)
        buttonReset.backgroundColor = .black
        buttonReset.layer.masksToBounds = true
        buttonReset.layer.cornerRadius = Metric.buttonCornerRadius
        return buttonReset
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupHierarchy()
        setupLayout()
    }
    
    // MARK: - Settings
    
    private func setupHierarchy() {
        view.addSubview(label)
        view.addSubview(buttonStart)
        view.addSubview(buttonRelax)
        view.addSubview(buttonReset)
    }
    
    private func setupLayout() {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.topAnchor.constraint(equalTo: view.topAnchor, constant: Metric.labelTopOfSet).isActive = true
        
        buttonStart.translatesAutoresizingMaskIntoConstraints = false
        buttonStart.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        buttonStart.topAnchor.constraint(equalTo: label.bottomAnchor, constant: Metric.buttonFieldTopOfSet).isActive = true
        buttonStart.heightAnchor.constraint(equalToConstant: Metric.buttonHeight).isActive = true
        buttonStart.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: Metric.buttonWidthMultiply).isActive = true
        
        buttonRelax.translatesAutoresizingMaskIntoConstraints = false
        buttonRelax.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        buttonRelax.topAnchor.constraint(equalTo: buttonStart.bottomAnchor, constant: Metric.buttonFieldTopOfSetTwo).isActive = true
        buttonRelax.heightAnchor.constraint(equalToConstant: Metric.buttonHeight).isActive = true
        buttonRelax.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: Metric.buttonWidthMultiply).isActive = true
        
        buttonReset.translatesAutoresizingMaskIntoConstraints = false
        buttonReset.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        buttonReset.topAnchor.constraint(equalTo: buttonRelax.bottomAnchor, constant: Metric.buttonFieldTopOfSetTwo).isActive = true
        buttonReset.heightAnchor.constraint(equalToConstant: Metric.buttonHeight).isActive = true
        buttonReset.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: Metric.buttonWidthMultiply).isActive = true
    }
    
    private func setupView() {
        view.backgroundColor = .white
    }
    
    // MARK: - Settings
    
    @objc private func buttonActionStart() {
       
        buttonReset.isEnabled = true
        buttonReset.alpha = 1.0
        
        if !isStarted {
            startTimer()
            isStarted = true
            buttonStart.setTitle("Pause", for: .normal)
        } else {
            timer.invalidate()
            isStarted = false
            buttonStart.setTitle("Start", for: .normal)
            view.backgroundColor = .red
        }
    }
    
    @objc private func buttonActionRelax() {
        
        buttonReset.isEnabled = true
        buttonReset.alpha = 0.9
        time = 300
        isStarted = true
        label.text = "05:00"
        
        if !isStarted {
            startTimer()
            isStarted = true
            buttonStart.setTitle("Pause", for: .normal)
        } else {
            timer.invalidate()
            isStarted = false
            buttonStart.setTitle("Start", for: .normal)
            view.backgroundColor = .green
        }
    }
    
    @objc private func buttonActionReset() {
        
        buttonReset.isEnabled = false
        buttonReset.alpha = 0.9
        timer.invalidate()
        time = 1500
        isStarted = true
        label.text = "25:00"
        buttonStart.setTitle("Pomodoro", for: .normal)
        view.backgroundColor = .blue
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(updateTimer)), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        
        time -= 1
        label.text = formatTime()
        
        if label.text == "00:00" {
            view.backgroundColor = .green
            timer.invalidate()
            buttonStart.setTitle("Start", for: .normal)
            isStarted = false
            buttonReset.isEnabled = false
            buttonReset.alpha = 0.9
            time = 1500
            isStarted = false
            label.text = "25:00"
        }
    }
    
    func formatTime() -> String {
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i", minutes, seconds)
    }
}

// MARK: - Constans

extension ViewController {
    
    enum Metric {
        static let labelfondSize: CGFloat = 80
        static let labelTopOfSet: CGFloat = 180
        static let buttonFieldTopOfSet: CGFloat = 200
        static let buttonFieldTopOfSetTwo: CGFloat = 8
        static let buttonHeight: CGFloat = 44
        static let buttonWidthMultiply: CGFloat = 0.9
        static let buttonCornerRadius: CGFloat = 10
        static let buttonFondCize: CGFloat = 20
    }
    
    enum Strings {
        static let labelText: String = "25:00"
        static let buttonTitleStart: String = "Pomodoro"
        static let buttonTitlePause: String = "Relax"
        static let buttonTitleReset: String = "Reset"
    }
}
