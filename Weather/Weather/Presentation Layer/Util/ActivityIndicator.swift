//
//  SearchTableViewCell.swift
//  Weather
//
//  Created by Marian on 6/9/18.
//  Copyright © 2018 Marian. All rights reserved.
//

import Foundation
import SVProgressHUD

struct ActivityIndicator {
    func show() {
        DispatchQueue.main.async {
            SVProgressHUD.show()
        }
    }
    func hide() {
        DispatchQueue.main.async {
            SVProgressHUD.dismiss()
        }
    }
}
