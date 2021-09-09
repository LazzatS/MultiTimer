//
//  TimersViewController.swift
//  MultiTimer
//
//  Created by Lazzat Seiilova on 07.09.2021.
//

import UIKit

class TimersChildViewController: UITableViewController {
    
    var timersSaved: [(name: String, seconds: String)] = []
    var secondsSaved = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        view.frame.size.height = 200
        tableView.register(CustomCell.self, forCellReuseIdentifier: "cell")
        tableView.register(TimersHeader.self, forHeaderFooterViewReuseIdentifier: "header")
        tableView.sectionHeaderHeight = 40
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timersSaved.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomCell
        cell.timerName.text = timersSaved[indexPath.row].name
        cell.timerSeconds.text = timersSaved[indexPath.row].seconds
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header")
        return header
    }
}

class TimersHeader: UITableViewHeaderFooterView {
    
    let timersHeaderName: UILabel = {
        let label = UILabel()
        label.text = "Таймеры"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .secondaryLabel
        return label
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        addSubview(timersHeaderName)
        timersHeaderName.translatesAutoresizingMaskIntoConstraints = false
        timersHeaderName.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        timersHeaderName.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
    }
}

class CustomCell: UITableViewCell {
    
    let timerName: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let timerSeconds: UILabel = {
        let secLabel = UILabel()
        secLabel.text = "ooo"
        return secLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        addSubview(timerName)
        timerName.translatesAutoresizingMaskIntoConstraints = false
        timerName.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        timerName.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        
        addSubview(timerSeconds)
        timerSeconds.translatesAutoresizingMaskIntoConstraints = false
        timerSeconds.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        timerSeconds.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
    }
    
}
