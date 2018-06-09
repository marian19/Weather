//
//  SearchTableViewCell.swift
//  Weather
//
//  Created by Marian on 6/9/18.
//  Copyright © 2018 Marian. All rights reserved.
//

import UIKit
import DZNEmptyDataSet

class CitiesListViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var cities: [LMCityWeather]?
    var presenter: CitiesListPresenterProtocol?
    let searchController = UISearchController(searchResultsController: nil)
    var searchKeywoard: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Setup the Search Controller
        searchController.obscuresBackgroundDuringPresentation = false
        definesPresentationContext = true
        searchController.searchBar.delegate = self
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.navigationItem.titleView = searchController.searchBar
        
        presenter = CitiesListPresenter(view: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presenter?.getCitiesList()
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "details"{
            
            let selectedIndex = tableView.indexPathForSelectedRow!
            let detailsViewcontroller = segue.destination as? CityDetailsViewController
            let cityTemps = cities?[selectedIndex.row].list?.allObjects as! [LMCityInfo]
            detailsViewcontroller?.cityTemperatures = cityTemps
            
        }else if segue.identifier == "search"{
            let searchViewcontroller = segue.destination as? SearchCitiesViewController
            searchViewcontroller?.keyword = searchKeywoard
        }
    }
}

extension CitiesListViewController: CitiesListViewProtocol{
    func setCitiesList(cities: [LMCityWeather]?) {
        self.cities = cities?.sorted(by: { $0.cityID < $1.cityID })
        tableView.reloadData()
    }
    
    
    
    func showMsg(msg : String){
        alert(message: msg)
    }
    
    
}

extension CitiesListViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return self.cities?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CityTableViewCell
        let city = cities![indexPath.row]
        var tempList = city.list?.allObjects as! [LMCityInfo]
        tempList.sort { $0.date < $1.date }
        cell.tempImageView.setImageFrom(icon: (tempList[0].icon)!)
        cell.nameLabel.text = "\(city.name!),\(city.country!)"
        cell.tempLabel.text = "\(tempList[0].temp)\u{00B0}"
        cell.descriptionLabel.text = tempList[0].desc!
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            print("Deleted")
            let city: LMCityWeather = cities![indexPath.row]
            presenter?.delete(city: city)
            cities?.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
}

extension CitiesListViewController: DZNEmptyDataSetSource{
    
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let str = "check_connection".localized()
        let attrs = [NSAttributedStringKey.font: UIFont.preferredFont(forTextStyle: UIFontTextStyle.headline)]
        return NSAttributedString(string: str, attributes: attrs)
    }
}

extension CitiesListViewController: UISearchControllerDelegate, UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchKeywoard = searchBar.text
        
        self.performSegue(withIdentifier: "search", sender: self)
    }
}
