//
//  SearchTableViewCell.swift
//  Weather
//
//  Created by Marian on 6/9/18.
//  Copyright © 2018 Marian. All rights reserved.
//

import UIKit
import DZNEmptyDataSet

class SearchCitiesViewController: BaseViewController {
    
    var presenter: SearchCitiesPresenterProtocol?
    var cities: [City]?
    var keyword: String?
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = SearchCitiesPresenter(view: self)
        presenter?.searchCities(keyword: keyword!)
    }
    
    @IBAction func saveCityButtonClicked(_ sender: UIButton) {
        
        sender.isEnabled = false
        let city = cities![sender.tag]
        presenter?.save(city: city)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "details"{
            
            let selectedIndex = tableView.indexPathForSelectedRow!
            let detailsViewcontroller = segue.destination as? CityDetailsViewController
            let city = cities?[selectedIndex.row]
            detailsViewcontroller?.cityName = "\(city!.name!),\(city!.sys!.country!)"
        }
    }
}

extension SearchCitiesViewController: SearchCitiesViewProtocol{
    
    func showMsg(msg: String) {
        alert(message: msg)
    }
    
    func setCities(cities: [City]){
        self.cities = cities
        tableView.reloadData()
        
    }
}

extension SearchCitiesViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return self.cities?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SearchTableViewCell
        
        let city = cities![indexPath.row]
        let weather: Weather = city.weather![0]
        let main: Main = city.main!
        
        cell.tempImageView.setImageFrom(icon: (weather.icon)!)
        cell.nameLabel.text = "\(city.name!),\(city.sys!.country!)"
        cell.tempLabel.text = "\(main.temp!)\u{00B0}"
        cell.addButton.tag = indexPath.row
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
}
extension SearchCitiesViewController: DZNEmptyDataSetSource{
    
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let str = "No_match".localized()
        let attrs = [NSAttributedStringKey.font: UIFont.preferredFont(forTextStyle: UIFontTextStyle.headline)]
        return NSAttributedString(string: str, attributes: attrs)
    }
}
