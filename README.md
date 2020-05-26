# NSPasteboardDebugger

If you've ever worked on adding copy/paste support to a macOS app, or drag&drop support, you've probably wondered what types you should support.

What data types do other apps store in the clipboard / pasteboard?

You've seend Strings, Attributed Strings, Tabular Data, RTF(D), Property Lists, Data, Private Types, File URLs, regular URLs, and the ever elusive File Promises. And so often it just doesn't seem to work.

NSPasteboardDebugger is the app you've been waiting for.

There are two buttons to read the "general" pasteboard (aka. your clipboard) or the "find" pasteboard (used to synchronize search terms across apps).

And you can just drag anything from any app on the NSPasteboardDebugger window to examine the dragging pasteboard. Finally an easy way to see which apps provide file promises, URLs, strings, url names, and so on.

This app is built with SwiftUI, which means it only runs on macOS 10.15 or later. I wrote it to get acquainted Apple's newest framework.
