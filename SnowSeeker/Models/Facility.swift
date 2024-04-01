//
//  Facility.swift
//  SnowSeeker
//
//  Created by Kirill Baranov on 01/04/24.
//

import SwiftUI

struct Facility: Identifiable {
	let id = UUID()
	var name: String

	var icon: some View {
		if let iconName = Facility.icons[name] {
			Image(systemName: iconName)
				.accessibilityLabel(name)
				.foregroundStyle(.secondary)
		} else {
			fatalError("Unknown facility type: \(name)")
		}
	}
	
	var description: String {
		if let message = Facility.descriptions[name] {
			message
		} else {
			fatalError("Unknown facility type: \(name)")
		}
	}
	
	static private let icons = [
		"Accommodation": "house",
		"Beginners": "1.circle",
		"Cross-country": "map",
		"Eco-friendly": "leaf.arrow.circlepath",
		"Family": "person.3"
	]
	
	static private let descriptions = [
		"Accommodation": "This resort has popular on-site accommodation.",
		"Beginners": "This resort has lots of ski schools.",
		"Cross-country": "This resort has many cross-country ski routes.",
		"Eco-friendly": "This resort has won an award for environmental friendliness.",
		"Family": "This resort is popular with families."
	]

}
