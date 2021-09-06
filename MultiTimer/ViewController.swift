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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Мульти таймер"
        view.backgroundColor = .white
        setupScrollView()
        createViewTitle()
        createTextFieldForNewTimerName()
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
}

