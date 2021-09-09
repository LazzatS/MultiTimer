//
//  ViewController.swift
//  MultiTimer
//
//  Created by Lazzat Seiilova on 06.09.2021.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    let scrollView = UIScrollView()
    let contentView = UIView()
    let viewTitle = UILabel()
    let timerName = UITextField()
    let timerSeconds = UITextField()
    let addButton = UIButton()
    let timersVC = TimersChildViewController()
    
    var timers: [(name: String, seconds: String)] = []
    var justNames = [String]()
    var justSeconds = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Мульти таймер"
        view.backgroundColor = .white
        setupScrollView()
        createViewTitle()
        createTextFieldForNewTimerName()
        createTextFieldForTimerInSeconds()
        createAddButton()
        addTimersChildViewController()
        
        var tempArray = [(name: String, seconds: String)]()
        justNames = UserDefaults.standard.stringArray(forKey: "newTimerNames") ?? ["No timers yet"]
        justSeconds = UserDefaults.standard.stringArray(forKey: "newTimerSeconds") ?? ["00:05"]
        for i in 0..<justNames.count {
            tempArray.append((name: justNames[i], seconds: justSeconds[i]))
        }
        timers = tempArray
        
        if (timers.count > 1 && timers[0].name == "No timers yet") {
            timers.remove(at: 0)
        }
        
        let tapAnywhereOnScreen = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))
        view.addGestureRecognizer(tapAnywhereOnScreen)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        timersVC.timersSaved = timers
        timersVC.tableView.reloadData()
    }
    
    func setupScrollView(){
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
    }
    
    func createViewTitle() {
        viewTitle.text = "Добавление таймеров"
        viewTitle.textColor = .secondaryLabel
        contentView.addSubview(viewTitle)
        
        let emptyView = UILabel()
        emptyView.backgroundColor = .clear
        contentView.addSubview(emptyView)
        
        viewTitle.translatesAutoresizingMaskIntoConstraints = false
        viewTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30).isActive = true
        viewTitle.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        viewTitle.heightAnchor.constraint(equalToConstant: 60).isActive = true
        viewTitle.leftAnchor.constraint(equalTo: emptyView.rightAnchor, constant: 20).isActive = true
        
        addBottomBorder(for: viewTitle, with: .secondaryLabel, andWidth: 1)
    }
    
    func addBottomBorder(for uiView: UIView, with color: UIColor?, andWidth borderWidth: CGFloat) {
        let border = UIView()
        border.backgroundColor = color
        border.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
        border.frame = CGRect(x: -20, y: uiView.frame.size.height - 15, width: uiView.frame.size.width + 20, height: borderWidth)
        uiView.addSubview(border)
    }
    
    func createTextFieldForNewTimerName() {
        timerName.backgroundColor = UIColor(named: "CustomLightGray")
        timerName.placeholder = "Название таймера"
        timerName.layer.borderWidth = 1
        timerName.layer.borderColor = UIColor.secondaryLabel.cgColor
        timerName.layer.cornerRadius = 5
        contentView.addSubview(timerName)
        
        timerName.autocorrectionType = UITextAutocorrectionType.no
        timerName.keyboardType = UIKeyboardType.default
        timerName.returnKeyType = UIReturnKeyType.done
        timerName.becomeFirstResponder()
        timerName.delegate = self
        
        timerName.translatesAutoresizingMaskIntoConstraints = false
        timerName.topAnchor.constraint(equalTo: viewTitle.bottomAnchor, constant: 20).isActive = true
        timerName.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 22).isActive = true
        timerName.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -150).isActive = true
        timerName.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    func createTextFieldForTimerInSeconds() {
        timerSeconds.backgroundColor = UIColor(named: "CustomLightGray")
        timerSeconds.placeholder = "Время в секундах"
        timerSeconds.layer.borderWidth = 1
        timerSeconds.layer.borderColor = UIColor.secondaryLabel.cgColor
        timerSeconds.layer.cornerRadius = 5
        contentView.addSubview(timerSeconds)
        
        timerSeconds.autocorrectionType = UITextAutocorrectionType.no
        timerSeconds.keyboardType = UIKeyboardType.numberPad
        timerSeconds.returnKeyType = UIReturnKeyType.done
        timerSeconds.becomeFirstResponder()
        timerSeconds.delegate = self
        
        timerSeconds.translatesAutoresizingMaskIntoConstraints = false
        timerSeconds.topAnchor.constraint(equalTo: timerName.bottomAnchor, constant: 10).isActive = true
        timerSeconds.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 22).isActive = true
        timerSeconds.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -150).isActive = true
        timerSeconds.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    func createAddButton() {
        addButton.setTitle("Добавить", for: .normal)
        addButton.setTitleColor(.systemBlue, for: .normal)
        addButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        addButton.backgroundColor = UIColor(named: "CustomLightGray")
        addButton.layer.cornerRadius = 10
        addButton.addTarget(self, action: #selector(addTimer), for: .touchUpInside)
        contentView.addSubview(addButton)
        
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.widthAnchor.constraint(equalToConstant: 240).isActive = true
        addButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        addButton.topAnchor.constraint(equalTo: timerSeconds.bottomAnchor, constant: 30).isActive = true
        addButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
    }
    
    func addTimersChildViewController() {
        addChild(timersVC)
        view.addSubview(timersVC.view)
        timersVC.didMove(toParent: self)
        
        timersVC.view.translatesAutoresizingMaskIntoConstraints = false
        timersVC.view.topAnchor.constraint(equalTo: addButton.bottomAnchor, constant: 40).isActive = true
        timersVC.view.widthAnchor.constraint(equalToConstant: view.frame.size.width).isActive = true
        timersVC.view.heightAnchor.constraint(equalToConstant: timersVC.view.frame.size.height).isActive = true
        timersVC.view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20).isActive = true
    }
    
    @objc func addTimer() {
        if let newTimerName = timerName.text, !newTimerName.isEmpty, !timerSeconds.text!.isEmpty {
            timers.append((name: newTimerName, seconds: timerSeconds.text!))
            timersVC.timersSaved = timers
            timersVC.tableView.reloadData()
            
            justNames.append(newTimerName)
            justSeconds.append(timerSeconds.text!)
            UserDefaults.standard.set(justNames, forKey: "newTimerNames")
            UserDefaults.standard.set(justSeconds, forKey: "newTimerSeconds")
        }
        
        timerName.text = ""
        timerSeconds.text = ""
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

