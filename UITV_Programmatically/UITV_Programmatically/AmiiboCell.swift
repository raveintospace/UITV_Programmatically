//
//  AmiiboCell.swift
//  UITV_Programmatically
//  https://youtu.be/_7eJHVpt_cs - Custom UITVCell
//  Created by Uri on 6/12/22.
//

import UIKit

class AmiiboCell: UITableViewCell {
    var safeArea: UILayoutGuide!
    let imageIV = CustomImageView()     // Our custom image view
    let nameLabel = UILabel()
    let gameSeriesLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    func setupView() {
        safeArea = layoutMarginsGuide
        setupImageView()
        setupLabel()
        setupGameSeriesLabel()
    }
    
    func setupImageView() {
        addSubview(imageIV)
        
        imageIV.translatesAutoresizingMaskIntoConstraints = false
        imageIV.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true
        imageIV.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        imageIV.widthAnchor.constraint(equalToConstant: 40).isActive = true
        imageIV.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        imageIV.contentMode = .scaleAspectFit
    }
    
    func setupLabel() {
        addSubview(nameLabel)
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.leadingAnchor.constraint(equalTo: imageIV.trailingAnchor, constant: 5).isActive = true
        nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        
        nameLabel.font = UIFont(name: "Verdana-Bold", size: 16)
    }
    
    func setupGameSeriesLabel() {
        addSubview(gameSeriesLabel)
        
        gameSeriesLabel.translatesAutoresizingMaskIntoConstraints = false
        gameSeriesLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor).isActive = true
        gameSeriesLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
        
        gameSeriesLabel.font = UIFont(name: "Verdana", size: 14)
    }
}
