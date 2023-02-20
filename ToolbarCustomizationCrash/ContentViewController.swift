import Cocoa
import AVKit

protocol ContentViewControllerDelegate: AnyObject {
	func contentViewControllerSetInvalidToolbarConfig(_ contentViewController: ContentViewController)
}

class ContentViewController: NSViewController {
	weak var delegate: ContentViewControllerDelegate?
	
	@IBOutlet private weak var avPlayerView: AVPlayerView!
	
	init() {
		super.init(nibName: "ContentView", bundle: .main)
	}
	
	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		view.wantsLayer = true
		
		if let layer = view.layer {
			layer.backgroundColor = .black
		}
		
		let bundle = Bundle.main
		
		guard let movieURL = bundle.url(forResource: "NSToolbarCrash",
										withExtension: "mov") else {
			return
		}
		
		let player = AVPlayer(url: movieURL)
		
		avPlayerView.player = player
		player.play()
	}
	
	@IBAction private func buttonSetInvalidToolbarConfig_action(_ sender: Any) {
		delegate?.contentViewControllerSetInvalidToolbarConfig(self)
	}
}
