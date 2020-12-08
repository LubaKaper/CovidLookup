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
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    var searchQuary: String = ""  {
        didSet {
           countries = countries.filter { $0.country.lowercased().contains(searchQuary.lowercased())}
        }
    }
    
    
    // difference between instance method and static method
    
    private let apiClient = APIClient2()
    
    private var countries = [Summary]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        searchBar.delegate = self 
        loadData()
    }
    
    private func loadData() {
        apiClient.fetchData { [weak self](result) in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let countries):
                self?.countries = countries
            }
        }
    }
   
}

extension CovidSummaryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "countryCell", for: indexPath)
        let country = countries[indexPath.row]
        cell.textLabel?.text = country.country
        cell.detailTextLabel?.text = "total cases: \(country.totalConfirmed), total recovered: \(country.totalRecovered)"
        return cell
    }
    
    
}

extension CovidSummaryViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            loadData()
            return
        }
        searchQuary = searchText
    }
}











//private let apiClient = APIClient()
//
//private var countrySummary = [Summary]() {
//    didSet {
//        DispatchQueue.main.async {// we have to update UI on main thread
//            self.tableView.reloadData()
//        }
//    }
//}
//
//override func viewDidLoad() {
//    super.viewDidLoad()
//    tableView.dataSource = self
//    fetchCovidData()
//}
//
//private func fetchCovidData() {
//    apiClient.fetchCovidDAta { [weak self] (result) in
//        switch result {
//        case .failure(let error):
//            print(error)
//        case .success(let countries):
//        //dump(countries)
//            self?.countrySummary = countries
//        }
//    }
//}



//extension CovidSummaryViewController: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return countrySummary.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "countryCell", for: indexPath)
//        // configure cell
//        let country = countrySummary[indexPath.row]
//        cell.textLabel?.text = country.country
//        cell.detailTextLabel?.text = "Cases Confirmed: \(country.totalConfirmed), Cases Recovered: \(country.totalRecovered)"
//        return cell
//    }
//
//
//}
