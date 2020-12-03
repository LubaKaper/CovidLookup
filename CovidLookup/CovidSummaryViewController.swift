//
//  ViewController.swift
//  CovidLookup
//
//  Created by Liubov Kaper  on 12/3/20.
//

import UIKit

// Add SearchBar

class CovidSummaryViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    // difference between instance method and static method
    private let apiClient = APIClient()
    
    private var countrySummary = [Summary]() {
        didSet {
            DispatchQueue.main.async {// we have to update UI on main thread
                self.tableView.reloadData()
            }
        }
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        fetchCovidData()
    }

    private func fetchCovidData() {
        apiClient.fetchCovidDAta { [weak self] (result) in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let countries):
            //dump(countries)
                self?.countrySummary = countries
            }
        }
    }

}

extension CovidSummaryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countrySummary.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "countryCell", for: indexPath)
        // configure cell
        let country = countrySummary[indexPath.row]
        cell.textLabel?.text = country.country
        cell.detailTextLabel?.text = "Cases Confirmed: \(country.totalConfirmed), Cases Recovered: \(country.totalRecovered)"
        return cell
    }
    
    
}
