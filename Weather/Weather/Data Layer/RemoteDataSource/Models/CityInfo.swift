

import Foundation
struct CityInfo : Codable {
    
	let id : Int?
	let name : String?
	let country : String?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case name = "name"
		case country = "country"
	}

}
