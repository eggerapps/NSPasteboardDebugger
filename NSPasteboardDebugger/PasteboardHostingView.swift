//
//  DropableHostingView.swift
//  NSPasteboardDebugger
//
//  Created by Jakob Egger on 2020-05-25.
//  Copyright © 2020 Egger Apps. All rights reserved.
//

import SwiftUI

class PasteboardHostingView: NSHostingView<PasteboardView> {
		
	override func viewDidMoveToWindow() {
		superview?.viewDidMoveToWindow()
		self.unregisterDraggedTypes()
		self.registerForDraggedTypes(
			[NSPasteboard.PasteboardType("public.data")]
				+ NSFilePromiseReceiver.readableDraggedTypes.map({NSPasteboard.PasteboardType($0)})
		)
	}
	
	override func draggingEntered(_ sender: NSDraggingInfo) -> NSDragOperation {
		(NSApp.delegate as! AppDelegate).pbmodel.pasteboard = Pasteboard(sender.draggingPasteboard)
		(NSApp.delegate as! AppDelegate).pbmodel.draggingSourceOperationMask = sender.draggingSourceOperationMask
		return []
	}
	
	override func draggingUpdated(_ sender: NSDraggingInfo) -> NSDragOperation {
		(NSApp.delegate as! AppDelegate).pbmodel.pasteboard = Pasteboard(sender.draggingPasteboard)
		(NSApp.delegate as! AppDelegate).pbmodel.draggingSourceOperationMask = sender.draggingSourceOperationMask
		return []
	}
}
