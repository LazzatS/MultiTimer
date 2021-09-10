//
//  TimersViewController.swift
//  MultiTimer
//
//  Created by Lazzat Seiilova on 07.09.2021.
//

import UIKit

class TimersChildViewController: UITableViewController {
    
    var timersSaved: [(name: String, seconds: String)] = []
    var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        cell.timersTableVC = self
        cell.timerName.text = timersSaved[indexPath.row].name
        count = Int(timersSaved[indexPath.row].seconds) ?? 5
        cell.timerSeconds.text = String(count)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header")
        return header
    }
    
    func deleteCell(cell: UITableViewCell) {
        if let deletionIndexPath = tableView.indexPath(for: cell) {
            timersSaved.remove(at: deletionIndexPath.row)
            tableView.deleteRows(at: [deletionIndexPath], with: .automatic)
        }
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
    
    var timersTableVC: TimersChildViewController?
    var timer = Timer()
    var isStopped = false
    var secondsInt = 0
    
    let timerName: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let timerSeconds: UILabel = {
        let secLabel = UILabel()
        return secLabel
    }()
    
    let stopButton: UIButton = {
        let stopButton = UIButton(type: .system)
        stopButton.setImage(UIImage(systemName: "play"), for: .normal)
        stopButton.setTitleColor(.secondaryLabel, for: .normal)
        return stopButton
    }()
    
    let deleteButton: UIButton = {
        let deleteButton = UIButton(type: .system)
        deleteButton.setImage(UIImage(systemName: "trash"), for: .normal)
        return deleteButton
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
        
        contentView.addSubview(deleteButton)
        deleteButton.addTarget(self, action: #selector(handleDeletion), for: .touchUpInside)
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        deleteButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        deleteButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
        
        contentView.addSubview(stopButton)
        stopButton.addTarget(self, action: #selector(stopTimer(cell:)), for: .touchUpInside)
        stopButton.translatesAutoresizingMaskIntoConstraints = false
        stopButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        stopButton.rightAnchor.constraint(equalTo: deleteButton.leftAnchor, constant: -20).isActive = true
        
        addSubview(timerSeconds)
        timerSeconds.translatesAutoresizingMaskIntoConstraints = false
        timerSeconds.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        timerSeconds.rightAnchor.constraint(equalTo: stopButton.leftAnchor, constant: -20).isActive = true
    }
    
    @objc func stopTimer(cell: UITableViewCell) {
        let tempSecString = timerSeconds.text
        secondsInt = Int(tempSecString ?? "5") ?? 5
        if isStopped {
            isStopped = false
            stopButton.setImage(UIImage(systemName: "play"), for: .normal)
            timer.invalidate()
        } else {
            isStopped = true
            stopButton.setImage(UIImage(systemName: "pause"), for: .normal)
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countdown), userInfo: nil, repeats: true)
        }
    }
    
    @objc func countdown() {
        let minInt = (secondsInt / 60) % 60
        let secInt = secondsInt % 60
        var timerString = ""
        
        if secondsInt > 0 {
            secondsInt -= 1
            if (minInt <= 9 && secInt <= 59) {
                timerString = String(format: "%02d:%02d", minInt, secInt)
            } else if (minInt > 9 && secInt <= 59) {
                timerString = String(format: "%2d:%2d", minInt, secInt)
            }
            timerSeconds.text = timerString
        } else {
            timersTableVC?.deleteCell(cell: self)
        }
    }
    
    @objc func handleDeletion() {
        timersTableVC?.deleteCell(cell: self)
    }
}
