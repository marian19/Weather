//
//  APIClient.swift
//  Blends
//
//  Created by Marian on 12/21/17.
//  Copyright © 2017 Marian. All rights reserved.
//

import Foundation

protocol APIClient {
    func getRequest(path: String, parameters: [String: Any]?, completion:@escaping (Data?, Error?) -> Void)
}
