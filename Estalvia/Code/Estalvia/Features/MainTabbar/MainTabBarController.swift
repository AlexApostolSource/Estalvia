//
//  MainTabBarController.swift
//  Estalvia
//
//  Created by Alex.personal on 18/10/25.
//

import Foundation
import UIKit

final class MainTabBarController: UITabBarController, UITabBarControllerDelegate {

	init() {
		super.init(nibName: nil, bundle: nil)
	}

	override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
		super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
		delegate = self
	}

	override init(tabs: [UITab]) {
		super.init(tabs: tabs)
		delegate = self
	}

	override func viewDidLoad() {
		super.viewDidLoad()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
