//
//  Favorites.swift
//  SnowSeeker
//
//  Created by Kirill Baranov on 01/04/24.
//

import SwiftUI

@Observable
class Favorites {
	// the actual resorts the user has favorited
	private var resorts: Set<String>

	// the key we're using to read/write in UserDefaults
	private let key = "Favorites"
	private let urlFavorites = URL.documentsDirectory.appending(path: "Favorites")

	init() {
		do {
			let data = try Data(contentsOf: urlFavorites)
			resorts = try JSONDecoder().decode(Set<String>.self, from: data)
		} catch {
			resorts = []
		}
	}
	
	// returns true if our set contains this resort
	func contains(_ resort: Resort) -> Bool {
		resorts.contains(resort.id)
	}

	// adds the resort to our set and saves the change
	func add(_ resort: Resort) {
		resorts.insert(resort.id)
		save()
	}

	// removes the resort from our set and saves the change
	func remove(_ resort: Resort) {
		resorts.remove(resort.id)
		save()
	}

	func save() {
		do {
			let data = try JSONEncoder().encode(resorts)
			try data.write(to: urlFavorites, options: [.atomic])
		} catch {
			print("Unable to save data.")
			print(error.localizedDescription)
		}
	}
}
