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
    var amiiboList = [Amiibo]()
    
    override func viewDidLoad() {
        view.backgroundColor = .orange
        setup()
    }
    
    // MARK: - Setup View
    
    func setup() {
        safeArea = view.layoutMarginsGuide
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(AmiiboCell.self, forCellReuseIdentifier: "cellId")
        setupTableView()
        loadDataFromJsonToVC()
    }
    
    func setupTableView() {
        view.addSubview(tableView)  // always add the view before setting its constraints
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    func loadDataFromJsonToVC() {
        let anonymousFunction = { (fetchedAmiiboList: [Amiibo]) in
            DispatchQueue.main.async {
                self.amiiboList = fetchedAmiiboList
                self.tableView.reloadData()
            }
        }
        AmiiboAPI.shared.fetchAmiiboList(onCompletion: anonymousFunction)
    }
}

// MARK: - UITableViewDataSource

extension AmiiboListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return amiiboList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        let amiibo = amiiboList[indexPath.row]
        
        guard let amiiboCell = cell as? AmiiboCell else { return cell }
        amiiboCell.nameLabel.text = amiibo.name
        amiiboCell.gameSeriesLabel.text = amiibo.gameSeries
        
        if let url = URL(string: amiibo.image) {
            amiiboCell.imageIV.loadImage(from: url)
        }
        return cell
    }
}

// MARK: - UITableViewDelegate  - https://youtu.be/jbFLBBc4TNY

extension AmiiboListVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completionHandler) in
        
        self.amiiboList.remove(at: indexPath.row)
        self.tableView.deleteRows(at: [indexPath], with: .automatic)
        
        completionHandler(true)
    }
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}


