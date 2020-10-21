//
//  Alerts.swift
//
//
//  Created by Ryan Bosher on 28/08/20.
//

import Foundation

enum Alerts {
	func notify() {
		let process = Process()
		process.launchPath = launchPath
		process.arguments = arguments
		
		let pipe = Pipe()
		process.standardOutput = pipe
		process.launch()
	}
	
	private var launchPath: String {
		#if os(Linux)
		return "notify-send"
		#else
		return "/usr/bin/osascript"
		#endif
	}
	
	private var arguments: [String] {
		#if os(Linux)
		return ["EggBlockchain", description]
		#else
		return ["-e", "display notification \"Server started on port: 5000\" with title \"EggBlockchain\""]
		#endif
	}
	
	case serverStarted(onPort: Int)
	case serverStopped
	
	private var description: String {
		switch self {
		case .serverStarted(let onPort):
			return "Server started on port:\(onPort)"
		case .serverStopped:
			return "Server stopped"
		}
	}
}
