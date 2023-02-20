import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate {
	private let splitViewController = NSSplitViewController()
	private let sidebarViewController = SidebarViewController()
	private let contentViewController = ContentViewController()
	private let toolbarController = ToolbarController()
	
	@IBOutlet private var window: NSWindow!
	
	func applicationWillFinishLaunching(_ notification: Notification) {
		// Comment this out to make it not crash
		enableCrashOnExceptions()
	}

	func applicationDidFinishLaunching(_ aNotification: Notification) {
		configureUI()
	}
}

private extension AppDelegate {
	func enableCrashOnExceptions() {
		UserDefaults.standard.register(defaults: [
			"NSApplicationCrashOnExceptions": true
		])
	}
	
	func configureUI() {
		configureSplitView()
		configureToolbar()
	}
	
	func configureSplitView() {
		guard let contentView = window.contentView else { return }
		
		let splitViewController = self.splitViewController
		let splitView = splitViewController.view
		
		splitView.frame = contentView.bounds
		splitView.autoresizingMask = [ .minXMargin, .maxXMargin, .minYMargin, .maxYMargin, .width, .height ]
		
		contentView.addSubview(splitView)
		
		let sidebarItem = NSSplitViewItem(sidebarWithViewController: sidebarViewController)
		let contentItem = NSSplitViewItem(viewController: contentViewController)
		
		splitViewController.addSplitViewItem(sidebarItem)
		splitViewController.addSplitViewItem(contentItem)
	}
	
	func configureToolbar() {
		let toolbar = toolbarController.toolbar
		window.toolbar = toolbar
	}
}
