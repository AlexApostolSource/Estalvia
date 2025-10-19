//
//  HomeTab.swift
//  Estalvia
//
//  Created by Alex.personal on 18/10/25.
//

import UIKit

public final class HomeTab: UITab {

	public override init(
		title: String,
		image: UIImage?,
		identifier: String,
		viewControllerProvider: ((UITab) -> UIViewController)? = nil
	) {
		super.init(
			title: title,
			image: image,
			identifier: identifier,
			viewControllerProvider: viewControllerProvider
		)
	}
}
