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
    var amiiboList = [AmiiboForView]()
    
    override func viewDidLoad() {
        view.backgroundColor = .white
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
        let anonymousFunction = { (fetchedAmiiboList: [Amiibo]) in      // Amiibo comes from our json & api call
            DispatchQueue.main.async {
                let amiiboForViewList = fetchedAmiiboList.map { amiibo in   // convert the Amiibo to an AmiiboForView
                    return AmiiboForView(
                        name: amiibo.name,
                        gameSeries: amiibo.gameSeries,
                        imageUrl: amiibo.image,
                        count: 0)
                }
                self.amiiboList = amiiboForViewList
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
        amiiboCell.countLabel.text = String(amiibo.count)
        
        if let url = URL(string: amiibo.imageUrl) {
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
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let countAction = UIContextualAction(style: .normal, title: "Count up") { (action, view, completionHandler) in
            
            let currentCount = self.amiiboList[indexPath.row].count
            self.amiiboList[indexPath.row].count = currentCount + 1
            
            if let cell = self.tableView.cellForRow(at: indexPath) as? AmiiboCell {
                cell.countLabel.text = String(self.amiiboList[indexPath.row].count)
            }
            completionHandler(true)
        }
        
        return UISwipeActionsConfiguration(actions: [countAction])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedAmiibo = self.amiiboList[indexPath.row]
        let amiiboDetailVC = AmiiboDetailVC()
        amiiboDetailVC.amiibo = selectedAmiibo
        self.present(amiiboDetailVC, animated: true)
    }
}


