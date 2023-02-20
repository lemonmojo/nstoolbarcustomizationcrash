# Toolbar Customization Crash

## Description

A demo project to illustrate AppKit crashes when customizing `NSToolbar`s with sidebar tracking separators.

## Issues

This project actually showcases two loosely related `NSToolbar` issues. 

1. The first issue causes the app to crash when dragging an item to the sidebar area of the toolbar when space is too tight to actually fit the item.

https://user-images.githubusercontent.com/186198/220128906-6373b283-4c7f-492b-9383-798291b8f34a.mov


2. The second issue is related to toolbar configurations. When calling `NSToolbar.setConfiguration(_:)` with a configuration that does NOT(!) include the sidebar tracking separator item (`NSToolbarItem.Identifier.sidebarTrackingSeparator`) and later opening the customization sheet and dragging the default set to the toolbar, the app crashes. Unfortunately, this is a rather common case when migrating configurations from macOS versions that did not support the sidebar tracking separator item (before macOS Big Sur). A potential workaround for this is to inspect the config before applying it and inserting a sidebar tracking separator item if it's not present in the dictionary. It's not ideal though as it requires knowledge of implementation details of the configuration dictionary. To see the issue in action run the demo app, customize the toolbar (ie. by dragging the "Home" item into the toolbar), then click the "Set invalid toolbar config" button. The customization sheet should appear again. When it does, drag the default set into the toolbar and watch the app crash. 

https://user-images.githubusercontent.com/186198/220145527-edd28d83-da8f-4c54-aa70-97e65f8fd69b.mov
