//
//  ContentView.swift
//  NSPasteboardDebugger
//
//  Created by Jakob Egger on 2020-05-22.
//  Copyright © 2020 Egger Apps. All rights reserved.
//

import SwiftUI

struct PasteboardView: View {
	@ObservedObject var model: PasteboardViewModel
	@State var selectedItemIndex: Int = 0
	
	@State var selectedType: String = NSPasteboard.PasteboardType.string.rawValue
	
	var pasteboard: Pasteboard { model.pasteboard }
	
    var body: some View {
		VStack(alignment: .leading, spacing: 0) {
			Text(model.draggingSourceOperationMask.debugDescription.isEmpty ? pasteboard.id : "\(pasteboard.id) (\(model.draggingSourceOperationMask.debugDescription))")
				.font(.title)
				.padding([.top,.leading,.bottom])
			Divider()
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
						.buttonStyle(PlainButtonStyle())
					}
					}.frame(minWidth: 150)
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
					}.frame(minWidth: 250).layoutPriority(1)
				}
			}.frame(minHeight: 200)
			Divider()
			VStack(spacing: 0) {
				if pasteboard.items.indices.contains(selectedItemIndex) && pasteboard.items[selectedItemIndex].representations.contains(where: { $0.id == self.selectedType }) {
					TextField("No String Content", text: .constant(pasteboard.items[selectedItemIndex].representations.first(where: { $0.id == self.selectedType })!.stringValue))
						.font(.custom("Menlo", size: 11))
						.multilineTextAlignment(.leading)
						.layoutPriority(2).frame(maxWidth:.infinity, alignment: .topLeading)
				}

				HStack {
					Text("Contents of selected NSPasteboardItem")
						.frame(maxWidth:.infinity, alignment: .leading)
					if pasteboard.items.indices.contains(selectedItemIndex) && pasteboard.items[selectedItemIndex].representations.contains(where: { $0.id == self.selectedType }) {
						Text(pasteboard.items[selectedItemIndex].representations.first(where: { $0.id == self.selectedType })!.data.debugDescription)
					}
				}
				.frame(maxWidth:.infinity)
				.font(.caption)
				.foregroundColor(Color(NSColor.secondaryLabelColor))
				.padding(EdgeInsets(top: 2, leading: 5, bottom: 0, trailing: 5))
			}.padding(10).frame(maxWidth:.infinity)
			Divider()
			VStack() {
				Text("Click one of the buttons, or drag something on this window to read the drag pasteboard")
				HStack {
					Button("Read General Pasteboard") {
						self.model.pasteboard = Pasteboard(NSPasteboard.general)
						self.model.draggingSourceOperationMask = []
					}
					Button("Read Find Pasteboard") {
						self.model.pasteboard = Pasteboard(NSPasteboard(name: .find))
						self.model.draggingSourceOperationMask = []
					}
				}
			}.padding().frame(maxWidth:.infinity)
		}
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
		PasteboardView(model: PasteboardViewModel())
    }
}

extension NSDragOperation: CustomDebugStringConvertible {
	public var debugDescription: String {
		if self.contains(.every) { return "every" }
		var str = ""
		if self.contains(.copy) { str += "copy," }
		if self.contains(.link) { str += "link," }
		if self.contains(.move) { str += "move," }
		if self.contains(.generic) { str += "generic," }
		if self.contains(.delete) { str += "delete," }
		if self.contains(.private) { str += "private," }
		if !str.isEmpty { str.removeLast() }
		return str
	}
}
