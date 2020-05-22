//
//  ContentView.swift
//  NSPasteboardDebugger
//
//  Created by Jakob Egger on 2020-05-22.
//  Copyright © 2020 Egger Apps. All rights reserved.
//

import SwiftUI

struct ContentView: View {
	@State var pasteboard: Pasteboard = Pasteboard(NSPasteboard.general)
	@State var selectedItemIndex: Int = 0
	
	@State var selectedType: String = NSPasteboard.PasteboardType.string.rawValue
	
    var body: some View {
		VStack {
			Text("Pasteboard Name: \(pasteboard.id)")
				.font(.title)
			HSplitView {
				List(pasteboard.items) { item in
					if item.id == self.selectedItemIndex {
						Text("Item \(item.id)").foregroundColor(.blue)
					} else {
						Button(action: {
							self.selectedItemIndex = item.id
						}) {
							Text("Item \(item.id)")
						}
						
					}
				}
				if pasteboard.items.indices.contains(selectedItemIndex) {
					List(pasteboard.items[selectedItemIndex].representations) { representation in
						if representation.id == self.selectedType {
							Text(representation.id).foregroundColor(.blue)
						} else {
							Button(action: {
								self.selectedType = representation.id
							}) {
								Text(representation.id)
							}
							.buttonStyle(PlainButtonStyle())
						}
					}
				}
			}
			if pasteboard.items.indices.contains(selectedItemIndex) && pasteboard.items[selectedItemIndex].representations.contains(where: { $0.id == self.selectedType }) {
				Text(pasteboard.items[selectedItemIndex].representations.first(where: { $0.id == self.selectedType })!.stringValue)
					.font(.custom("Menlo", size: 10))
					.multilineTextAlignment(.leading)
				Text(pasteboard.items[selectedItemIndex].representations.first(where: { $0.id == self.selectedType })!.data.debugDescription)
					.foregroundColor(Color.gray)
					.multilineTextAlignment(.trailing)
			}
			Divider()
			VStack {
				Text("Click one of the buttons, or drag something on this window to read the drag pasteboard")
				HStack {
					Button("Read General Pasteboard") { self.pasteboard = Pasteboard(NSPasteboard.general) }
					Button("Read Find Pasteboard") { self.pasteboard = Pasteboard(NSPasteboard(name: .find)) }
				}
			}.padding()
		}
		.onDrop(
			of: ["public.data"],
			delegate: PasteboardCatcher(pasteboard: $pasteboard)
		)
    }
}

struct PasteboardCatcher: DropDelegate {
	@Binding var pasteboard: Pasteboard
	
	func performDrop(info: DropInfo) -> Bool {
		return false
	}
	
	func validateDrop(info: DropInfo) -> Bool {
		pasteboard = Pasteboard(NSPasteboard(name: .drag))
		return false
	}
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
