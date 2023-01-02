//
//  HeaderTableView.swift
//  smartLockTest
//
//  Created by Julia Semyzhenko on 31.12.2022.
//

import UIKit
import SnapKit

class HeaderTableView: UITableViewHeaderFooterView {
    static let identifier = "TableHeader"
    
    private let imageView: UIImageView = {
        let imageView =  UIImageView()
        imageView.image = UIImage(named: "houses_img")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let welcomeLabel: UILabel = {
        let label =  UILabel()
        label.text = "Welcome"
        label.font = .systemFont(ofSize: 35, weight: .bold)
        label.textAlignment = .left
        return label
    }()
    
    private let myDoorsLabel: UILabel = {
        let label =  UILabel()
        label.text = "My doors"
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = UIColor(named: "headers_color")
        label.textAlignment = .left
        return label
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier:reuseIdentifier)
        contentView.addSubview(imageView)
        contentView.addSubview(welcomeLabel)
        contentView.addSubview(myDoorsLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Layout for the Header items
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(contentView).offset(0)
            make.size.equalTo(CGSize(width: 190, height: 170))
            make.right.equalTo(contentView).offset(0)
        }
        
        welcomeLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(contentView).offset(50)
            make.left.equalTo(contentView).offset(5)
        }
        
        myDoorsLabel.snp.makeConstraints { (make) -> Void in
            make.bottom.equalTo(contentView).offset(-15)
            make.size.equalTo(CGSize(width: 100, height: 24))
            make.left.equalTo(contentView).offset(5)
        }
    }
}
