//
//  FindViewController.swift
//  AppWeather
//
//  Created by Irisandromeda on 28.11.2022.
//

import UIKit

class FindViewController: UIViewController {
    
    var presenter: FindViewPresenterProtocol!
    
    let tableView = UITableView()
    var tableSectionValue: Int = 0
    var searchCity: String?
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func loadView() {
        super.loadView()
        
        view.backgroundColor = .mainBlue()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        configureBarButtonItems()
        setupSearchBar()
        setupTableView()
        addConstraints()
    }
    
    private func setupTableView() {
        tableView.backgroundColor = .white
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CityCell")
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func setupSearchBar() {
        navigationItem.titleView = searchController.searchBar
        searchController.searchBar.showsCancelButton = false
        searchController.searchBar.placeholder = "City"
        searchController.searchBar.searchTextField.backgroundColor = .white
        searchController.searchBar.setImage(UIImage(), for: .search, state: .normal)
        searchController.searchBar.sizeToFit()
        searchController.searchBar.tintColor = .gray
        
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
    }
    
    private func configureBarButtonItems() {
        navigationController?.navigationBar.tintColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_search"), style: .plain, target: self, action: #selector(findButtonTap))
    }
    
    @objc private func backButtonTap() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func findButtonTap() {
        navigationController?.popViewController(animated: true)
    }
}

extension FindViewController {
    private func addConstraints() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
}

//MARK: - Table View Data Source

extension FindViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableSectionValue
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityCell", for: indexPath)
        cell.textLabel?.text = presenter.weather?.city.name
        return cell
    }
}

extension FindViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        searchCity = cell?.textLabel?.text ?? ""
    }
}

extension FindViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter.getWeatherByCity(city: searchText)
    }
}

extension FindViewController: FindViewProtocol {
    func success() {
        tableSectionValue = 1
        tableView.reloadData()
    }
    
    func failure(error: Error) {
        tableSectionValue = 0
    }
    
    
}
