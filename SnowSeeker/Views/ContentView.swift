//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Kirill Baranov on 18/03/24.
//

import SwiftUI
import Observation

struct ContentView: View {
	let resorts: [Resort] = Bundle.main.decode("resorts.json")
	@State private var searchText = ""
	
	@State private var favorites = Favorites()
	@State var sortOrder: SortOrders = .dyDefault
	
	var filteredResorts: [Resort] {
		if searchText.isEmpty {
		   resorts
		} else {
			resorts.filter { $0.name.localizedStandardContains(searchText) }
		}
	}
	
	var body: some View {
		NavigationSplitView {
			List(sortRerorts(filteredResorts, by: sortOrder)) { resort in
				NavigationLink(value: resort) {
					HStack {
						Image(resort.country)
							.resizable()
							.scaledToFill()
							.frame(width: 40, height: 25)
							.clipShape(
								.rect(cornerRadius: 5)
							)
							.overlay(
								RoundedRectangle(cornerRadius: 5)
									.stroke(.black, lineWidth: 1)
							)

						VStack(alignment: .leading) {
							Text(resort.name)
								.font(.headline)
							Text("\(resort.runs) runs")
								.foregroundStyle(.secondary)
						}
						if favorites.contains(resort) {
							Spacer()
							Image(systemName: "heart.fill")
							.accessibilityLabel("This is a favorite resort")
								.foregroundStyle(.red)
						}
					}
				}
			}
			.navigationTitle("Resorts")
			.searchable(text: $searchText, prompt: "Search for a resort")
			.navigationDestination(for: Resort.self) { resort in
				ResortView(resort: resort)
			}
			.toolbar {
				ToolbarItem(placement: .topBarTrailing) {
					Menu {
						Picker("Choose sort order", selection: $sortOrder) {
							ForEach (SortOrders.allCases, id: \.self) {
								Text($0.rawValue)
							}
						}
					} label: {
						Image(systemName: "arrow.up.arrow.down")
					}
				}
			}
		} detail: {
			WelcomeView()
		}
		.environment(favorites)

		
	}
	
	func sortRerorts(_ resorts: [Resort], by sortOrder: SortOrders) -> [Resort] {
		switch sortOrder {
		case .dyDefault:
			return resorts
		case .byName:
			return resorts.sorted(by: { $0.name < $1.name })
		case .byCountry:
			return resorts.sorted(by: { $0.country < $1.country })
		}
	}
}

#Preview {
    ContentView()
}

enum SortOrders: String, CaseIterable {
	case dyDefault = "dyDefault", byName = "byName", byCountry = "byCountry"
}
