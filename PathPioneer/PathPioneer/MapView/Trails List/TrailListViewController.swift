//
//  TrailListViewController.swift
//  PathPioneer
//
//  Created by Dev Patel on 4/2/23.
//

import UIKit
import ParseSwift

class TrailListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    private var trails = [Trail]() {
        didSet {
            // Reload table view anytine the data in var posts changes
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        queryTrails()
    }
    
    private func queryTrails() {
        let query = Trail.query()
            .include("user")
            .order([.descending("createdAt")])
        
        // Fetch posts defined in query asynchronously
        query.find { [weak self] result in
            switch result {
            case .success(let trails):
                self?.trails = trails
            case .failure(let error):
                self?.showAlert(description: error.localizedDescription)
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: true)
        }
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // TODO: Pt 1 - Pass the selected track to the detail view controller
        if let cell = sender as? UITableViewCell,
           
            let indexPath = tableView.indexPath(for: cell),
            
            let trailDetailViewController = segue.destination as? TrailDetailViewController {
            
            let trail = trails[indexPath.row]
            
            trailDetailViewController.trail = trail
        }
    }
}

extension TrailListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TrailCell", for: indexPath) as! TrailCell
        
        let trail = trails[indexPath.row]
        
        cell.configure(with: trail)
        
        return cell
    }
    
    
}

extension TrailListViewController: UITableViewDelegate { }
