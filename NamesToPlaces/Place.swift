//
//  Place.swift
//  NamesToPlaces
//
//  Created by Сергей Цайбель on 09.06.2022.
//

import UIKit

class Place: NSObject {
	var name: String
	var image: String
	
	init(name: String, image: String) {
		self.name = name
		self.image = image
	}
}
