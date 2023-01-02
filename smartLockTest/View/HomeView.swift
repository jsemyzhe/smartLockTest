//
//  HomeView.swift
//  smartLockTest
//
//  Created by Julia Semyzhenko on 29.12.2022.
//

import UIKit

protocol IHomeView: UIView {
    func set(controller: IHomeVC)
    func configureView(with config: HomeView.Config)
}

final class HomeView: UIView {
    
    struct Config {
        let doors: [Door]
        
        static var empty: Config {
            Config(doors: [])
        }
    }
    
    let settingsButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "gear_img"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 13
        button.layer.borderWidth = 0.7
        button.layer.borderColor = UIColor.lightGray.cgColor
        return button
    }()
    
    let logoImage: UIImageView = {
        var image = UIImageView()
        image = UIImageView(image: UIImage(named: "logo_img"))
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let gradientBottom: GradientView = {
        let gview = GradientView()
        gview.isUserInteractionEnabled = false
        return gview
    }()
    
    let keyButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "key_img"), for: .normal)
        return button
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.separatorStyle = .none
        tableView.backgroundView = UIView()
        tableView.backgroundColor = .clear
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.identifier)
        tableView.register(HeaderTableView.self, forHeaderFooterViewReuseIdentifier: HeaderTableView.identifier)
        return tableView
    }()
    
    private weak var controller: IHomeVC?
    
    private var config: Config = .empty
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setConstraints()
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        backgroundColor = .white
        
        tableView.dataSource = self
        tableView.delegate = self
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    private func setConstraints() {
        self.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.tableHeaderView?.largeContentImage =  UIImage(named: "logo_img")
        tableView.snp.makeConstraints { (make) -> Void in
            make.bottom.equalTo(self).offset(0)
            make.right.equalTo(self).offset(-20)
            make.top.equalTo(self).offset(130)
            make.left.equalTo(self).offset(20)
        }
        
        self.addSubview(gradientBottom)
        gradientBottom.snp.makeConstraints { (make) -> Void in
            make.bottom.equalTo(self).offset(0)
            make.height.equalTo(100)
            make.right.equalTo(self).offset(0)
            make.left.equalTo(self).offset(0)
        }
        
        self.addSubview(keyButton)
        keyButton.snp.makeConstraints { (make) -> Void in
            make.bottom.equalTo(self).offset(-5)
            make.size.equalTo(CGSize(width: 45, height: 45))
            make.right.equalTo(self).offset(-45)
        }
        
        self.addSubview(settingsButton)
        settingsButton.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self).offset(70)
            make.size.equalTo(CGSize(width: 45, height: 45))
            make.right.equalTo(self).offset(-45)
        }
        
        self.addSubview(logoImage)
        logoImage.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self).offset(85)
            make.size.equalTo(CGSize(width: 86, height: 18))
            make.left.equalTo(self).offset(42)
        }
    }
    
    @objc private func didPullToRefresh(_ sender: UIRefreshControl) {
        sender.endRefreshing()
        controller?.didPullToRefresh()
    }
    
    func configureView(with config: Config) {
        self.config = config
        tableView.reloadData()
    }
}

// MARK: - IHomeView extension

extension HomeView: IHomeView {
    
    func set(controller: IHomeVC) {
        self.controller = controller
    }
    
}

// MARK: - UITableViewDataSource, UITableViewDelegate extensions
extension HomeView: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return config.doors.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as? CustomTableViewCell
        else {
            return UITableViewCell()
        }
        
        let door = config.doors[indexPath.row]
        cell.mainImage.image = UIImage(named: door.mainImageName)
        cell.statusImage.image = UIImage(named: door.state == .locked ? door.lockedImgName : door.unlockedImgName)
        cell.statusImage.isHidden = false
        cell.nameLabel.text = door.doorName
        cell.locationLabel.text = door.doorLocation
        cell.loadingView.isHidden = true
        cell.statusLabel.textColor = UIColor(named: door.state == .locked ? "locked_button_color" : "unlocked_button_color")
        cell.statusLabel.text = door.state == .locked ? "Locked" : "Unlocked"
        
        cell.statusLabelActionHadler = { [weak self] in
            cell.statusImage.isHidden = true
            cell.loadingView.isHidden = false
            cell.statusLabel.textColor = UIColor(named: "gray_main_color")
            cell.statusLabel.text = door.state == .locked ? "Unlocking..." : "Locking..."
            self?.controller?.didTapOpenDoor(index: indexPath.row)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 250
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: HeaderTableView.identifier)
        return header
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let cell = tableView.cellForRow(at: indexPath) as? CustomTableViewCell else { return }
        let door = config.doors[indexPath.row]
        cell.statusImage.isHidden = true
        cell.loadingView.isHidden = false
        cell.statusLabel.textColor = UIColor(named: "gray_main_color")
        cell.statusLabel.text = door.state == .locked ? "Unlocking..." : "Locking..."
        controller?.didTapOpenDoor(index: indexPath.row)
    }
    
}
