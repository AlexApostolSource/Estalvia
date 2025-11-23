//
//  MainTabBarFactory.swift
//  Estalvia
//
//  Created by Alex.personal on 18/10/25.
//
import SwiftUI
import UIKit

public final class MainTabBarFactory {
	static func createMainTabbar() -> UIViewController {
		let tab = HomeTab(title: "Home", image: UIImage(systemName: "house"), identifier: "homeId") { _ in
			UIHostingController(rootView: HomeView())
		}

		let tab2 = HomeTab(title: "Home", image: UIImage(systemName: "house"), identifier: "homeId2") { _ in
			RedViewController()
		}

		let tabBarController = MainTabBarController(tabs: [tab, tab2])
		return tabBarController
	}
}

final class RedViewController: UIViewController {

	init() {
		super.init(nibName: nil, bundle: nil)
	}
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		setupUI()
	}

	private func setupUI() {
		view.backgroundColor = .systemRed
	}
}
