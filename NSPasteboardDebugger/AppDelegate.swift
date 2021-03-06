//
//  AppDelegate.swift
//  NSPasteboardDebugger
//
//  Created by Jakob Egger on 2020-05-22.
//  Copyright © 2020 Egger Apps. All rights reserved.
//

import Cocoa
import SwiftUI

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

	var window: NSWindow!

	var pbmodel = PasteboardViewModel()

	func applicationDidFinishLaunching(_ aNotification: Notification) {
		// Create the SwiftUI view that provides the window contents.
		let contentView = PasteboardView(model: pbmodel)

		// Create the window and set the content view. 
		window = NSWindow(
		    contentRect: NSRect(x: 0, y: 0, width: 480, height: 300),
		    styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
		    backing: .buffered, defer: false)
		window.center()
		window.setFrameAutosaveName("Main Window")
		window.contentView = PasteboardHostingView(rootView: contentView)
		window.makeKeyAndOrderFront(nil)
	}

	func applicationWillTerminate(_ aNotification: Notification) {
		// Insert code here to tear down your application
	}


}

