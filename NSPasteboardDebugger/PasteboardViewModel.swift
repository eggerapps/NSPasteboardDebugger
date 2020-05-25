//
//  PasteboardViewModel.swift
//  NSPasteboardDebugger
//
//  Created by Jakob Egger on 2020-05-22.
//  Copyright © 2020 Egger Apps. All rights reserved.
//

import AppKit

class PasteboardViewModel: ObservableObject {
	@Published var pasteboard: Pasteboard = Pasteboard(NSPasteboard.general)
	@Published var draggingSourceOperationMask: NSDragOperation = []
}

struct Pasteboard: Identifiable {
	let id: String
	let items: [PasteboardItem]
	
	init(_ pasteboard: NSPasteboard) {
		id = pasteboard.name.rawValue
		items = pasteboard.pasteboardItems?.enumerated().map { (index, item) in PasteboardItem(index: index, item: item) } ?? []
	}
}

struct PasteboardItem: Identifiable {
	let id: Int
	let representations: [PasteboardItemRepresentation]
	init(index: Int, item: NSPasteboardItem) {
		id = index
		representations = item.types.map {
			PasteboardItemRepresentation(
				id: $0.rawValue,
				stringValue: item.string(forType: $0) ?? "",
				data: item.data(forType: $0) ?? Data()
			)
		}
	}
}

struct PasteboardItemRepresentation: Identifiable {
	let id: String
	let stringValue: String
	let data: Data
}
