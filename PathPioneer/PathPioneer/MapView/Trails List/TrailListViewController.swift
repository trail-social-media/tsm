//
//  TrailListViewController.swift
//  PathPioneer
//
//  Created by Dev Patel on 4/2/23.
//

import UIKit

class TrailListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var trails: [Trail] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        trails = Trail.mockTrails
        
        tableView.dataSource = self

        // Do any additional setup after loading the view.
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
