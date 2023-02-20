import Cocoa

class ToolbarController: NSObject {
	let toolbar = NSToolbar(identifier: "MainToolbar")
	
	override init() {
		super.init()
		
		toolbar.displayMode = .iconOnly
		toolbar.allowsUserCustomization = true
		toolbar.autosavesConfiguration = false
		
		toolbar.delegate = self
	}
}

private extension ToolbarController {
	enum Item: String {
		case add = "add"
		case remove = "remove"
		case refresh = "refresh"
		case action = "action"
		case home = "home"
		case search = "search"
		
		var toolbarItemIdentifier: NSToolbarItem.Identifier {
			.init(self.rawValue)
		}
		
		var isSearchItem: Bool {
			self == .search
		}
		
		var label: String {
			switch self {
				case .add: return "Add"
				case .remove: return "Remove"
				case .refresh: return "Refresh"
				case .action: return "Action"
				case .home: return "Home"
				case .search: return "Search"
			}
		}
		
		var image: NSImage? {
			switch self {
				case .add: return .init(named: NSImage.addTemplateName)
				case .remove: return .init(named: NSImage.removeTemplateName)
				case .refresh: return .init(named: NSImage.refreshTemplateName)
				case .action: return .init(named: NSImage.actionTemplateName)
				case .home: return .init(named: NSImage.homeTemplateName)
				case .search: return nil
			}
		}
		
		func makeItem(target: AnyObject?,
					  action: Selector?) -> NSToolbarItem {
			let itemIdentifier = NSToolbarItem.Identifier(rawValue)
			
			let item = isSearchItem
				? NSSearchToolbarItem(itemIdentifier: itemIdentifier)
				: NSToolbarItem(itemIdentifier: itemIdentifier)
			
			item.label = label
			item.image = image
			
			item.target = target
			item.action = action
			
			return item
		}
	}
	
	@IBAction private func toolbarItem_action(_ sender: Any) { }
}

extension ToolbarController: NSToolbarDelegate {
	func toolbar(_ toolbar: NSToolbar,
				 itemForItemIdentifier itemIdentifier: NSToolbarItem.Identifier,
				 willBeInsertedIntoToolbar flag: Bool) -> NSToolbarItem? {
		guard let item = Item(rawValue: itemIdentifier.rawValue) else {
			fatalError("Unknown Item Identifier: \(itemIdentifier.rawValue)")
		}
		
		let toolbarItem = item.makeItem(target: self,
										action: #selector(toolbarItem_action(_:)))
		
		return toolbarItem
	}
	
	func toolbarDefaultItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
		[
			Item.add.toolbarItemIdentifier,
			Item.remove.toolbarItemIdentifier,
			Item.refresh.toolbarItemIdentifier,
			.sidebarTrackingSeparator,
			Item.action.toolbarItemIdentifier,
			.flexibleSpace,
			Item.search.toolbarItemIdentifier
		]
	}
	
	func toolbarAllowedItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
		[
			.space,
			.flexibleSpace,
			.sidebarTrackingSeparator,
			Item.add.toolbarItemIdentifier,
			Item.remove.toolbarItemIdentifier,
			Item.refresh.toolbarItemIdentifier,
			Item.action.toolbarItemIdentifier,
			Item.home.toolbarItemIdentifier,
			Item.search.toolbarItemIdentifier
		]
	}
}
