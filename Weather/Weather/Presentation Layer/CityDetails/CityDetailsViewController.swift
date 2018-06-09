//
//  SearchTableViewCell.swift
//  Weather
//
//  Created by Marian on 6/9/18.
//  Copyright © 2018 Marian. All rights reserved.
//

import UIKit
import DZNEmptyDataSet

class CityDetailsViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var cityTemperatures: [LMCityInfo]?
    var cityName: String?
    var presenter: CityDetailsPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let _ = cityTemperatures {
            cityTemperatures =  cityTemperatures?.sorted(by: { $0.date < $1.date })
            
        }else if let _ = cityName{
            presenter = CityDetailsPresenter(view: self)
            presenter?.getCityDetails(name: cityName!)
        }
    }
}


extension CityDetailsViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return self.cityTemperatures?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CityDetailsTableViewCell
        
        let temp: LMCityInfo = cityTemperatures![indexPath.row]
        
        cell.tempImageView.setImageFrom(icon: (temp.icon)!)
        cell.dayLabel.text = String.getDayInWeek(dateInt: Int(temp.date))
        cell.tempLabel.text = "\(temp.temp)\u{00B0}"
        cell.timeLabel.text = String.getTimeFrom(dateInt: Int(temp.date))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
}

extension CityDetailsViewController:  CityDetailsViewProtocol{
    func showMsg(msg: String) {
        alert(message: msg)
    }
    
    func setCityDetails(info: [LMCityInfo]?) {
        self.cityTemperatures = info
        cityTemperatures =  cityTemperatures?.sorted(by: { $0.date < $1.date })
        tableView.reloadData()
    }
}
