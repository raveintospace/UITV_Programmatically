//
//  AmiiboDetailVC.swift
//  UITV_Programmatically
//  https://youtu.be/O1t_y5c5z60 - Creation of DetailVC
//  Created by Uri on 6/12/22.
//

import UIKit

class AmiiboDetailVC: UIViewController {
    var amiibo: AmiiboForView?
    
    var safeArea: UILayoutGuide!
    let imageIV = CustomImageView()
    let nameLabel = UILabel()
    let dismissButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        view.backgroundColor = .black
        safeArea = view.layoutMarginsGuide
        setupImage()
        setupNameLabel()
        setupData()
        setupDismissButton()
    }
    
    func setupImage() {
        view.addSubview(imageIV)
        
        imageIV.translatesAutoresizingMaskIntoConstraints = false
        imageIV.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imageIV.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 50).isActive = true
        imageIV.widthAnchor.constraint(equalTo: safeArea.widthAnchor, multiplier: 0.5).isActive = true  // half the size of the device screen
        imageIV.heightAnchor.constraint(equalTo: imageIV.widthAnchor).isActive = true   // same height as width
        
        imageIV.contentMode = .scaleAspectFit       // mantains the aspect
    }
    
    func setupNameLabel() {
        view.addSubview(nameLabel)
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.topAnchor.constraint(equalTo: imageIV.bottomAnchor, constant: 10).isActive = true
        nameLabel.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor).isActive = true
        
        nameLabel.textColor = .white
        nameLabel.font = UIFont(name: "Verdana-Bold", size: 18)
    }
    
    func setupData() {
        if
            let amiibo = amiibo,
            let url = URL(string: amiibo.imageUrl)
        {
            imageIV.loadImage(from: url)
            nameLabel.text = amiibo.name
        }
    }
    
    func setupDismissButton() {
        view.addSubview(dismissButton)
        
        dismissButton.translatesAutoresizingMaskIntoConstraints = false
        dismissButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -50).isActive = true
        dismissButton.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor).isActive = true
        
        dismissButton.setTitle("Dissmiss", for: .normal)
        dismissButton.titleLabel?.font = UIFont(name: "Verdana-Bold", size: 16)
        
        dismissButton.addTarget(self, action: #selector(dismissAction), for: .touchUpInside)
    }
    
    @objc func dismissAction() {
        self.dismiss(animated: true)
    }
}
