//
//  ViewController.swift
//  UITV_Programmatically
//  https://youtu.be/OOLDgMK_KnE
//  Created by Uri on 4/12/22.
//

import UIKit

class AmiiboListVC: UIViewController {
    let tableView = UITableView()
    var safeArea: UILayoutGuide!
    
    override func viewDidLoad() {
        view.backgroundColor = .orange
        setup()
    }
    
    // MARK: - Setup View
    
    func setup() {
        safeArea = view.layoutMarginsGuide
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
        setupView()
    }
    
    func setupView() {
        view.addSubview(tableView)  // always add the view before setting its constraints
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
}

// MARK: - UITableViewDataSource

extension AmiiboListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        cell.textLabel?.text = "Fato"
        return cell
    }
}

// lesson for monday - https://youtu.be/t8sYKkST1gs


