import Cocoa

class SidebarViewController: NSViewController {
	init() {
		super.init(nibName: "SidebarView", bundle: .main)
	}
	
	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
