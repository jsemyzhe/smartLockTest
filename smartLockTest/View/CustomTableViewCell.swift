//
//  CustomTableViewCell.swift
//  smartLockTest
//
//  Created by Julia Semyzhenko on 30.12.2022.
//

import UIKit
import SnapKit

class CustomTableViewCell: UITableViewCell {
    
    static let identifier = "CustomTableViewCell"
    
    var statusLabelActionHadler: (() -> ())?
    
    var mainImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "shield_blue_img")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    var statusImage: UIImageView = {
        var imageView = UIImageView()
        imageView.image = UIImage(named: "status_blue_closed_img")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.text = "Front door"
        label.textColor = UIColor(named: "headers_color")
        label.numberOfLines = 0
        return label
    }()
    
    let locationLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = UIColor(named: "gray_main_color")
        label.text = "Home"
        label.numberOfLines = 0
        return label
    }()
    
    var statusLabel: UILabel = {
        let label = UILabel()
        label.text = "Locked"
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        label.textColor = UIColor(named: "locked_button_color")
        return label
    }()
    
    let loadingView: LoadingView =  {
        var loading = LoadingView()
        loading.isHidden = true
        return loading
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .clear
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor(named: "frame_color")?.cgColor
        contentView.addSubview(mainImage)
        contentView.addSubview(nameLabel)
        contentView.addSubview(locationLabel)
        contentView.addSubview(statusLabel)
        contentView.addSubview(statusImage)
        contentView.addSubview(loadingView)
        contentView.layer.cornerRadius = 15
        
        labelSetUp()
    }
    
    @objc func statusLabelTapped(_ sender: UITapGestureRecognizer) {
        statusLabelActionHadler?()
    }
    
    func labelSetUp() {
        let labelTap = UITapGestureRecognizer(target: self, action: #selector(self.statusLabelTapped(_:)))
        self.statusLabel.isUserInteractionEnabled = true
        self.statusLabel.addGestureRecognizer(labelTap)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Layout for cell items
    override func layoutSubviews() {
        super.layoutSubviews()
        selectionStyle = .none
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0))
        
        mainImage.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(contentView).offset(18)
            make.size.equalTo(CGSize(width: 41, height: 41))
            make.left.equalTo(contentView).offset(27)
        }
        
        loadingView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(contentView).offset(40)
            make.size.equalTo(CGSize(width: 40, height: 40))
            make.right.equalTo(contentView).offset(-10)
        }
        
        nameLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(contentView).offset(22)
            make.left.equalTo(contentView).offset(80)
        }
        
        locationLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(contentView).offset(41)
            make.left.equalTo(contentView).offset(80)
        }
        
        statusLabel.snp.makeConstraints { (make) -> Void in
            make.bottom.equalTo(contentView).offset(-10)
            make.left.equalTo(contentView).offset(contentView.frame.size.width/2.4)
        }
        
        statusImage.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(contentView).offset(18)
            make.size.equalTo(CGSize(width: 40, height: 40))
            make.right.equalTo(contentView).offset(-27)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
