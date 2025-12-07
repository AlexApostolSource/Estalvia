//
//  CustomDate.swift
//  EstalviaDesignSystem
//
//  Created by Alex.personal on 7/12/25.
//

import Foundation

public extension DateFormatter {
	 static func custom() -> DateFormatter {
		let dateFormatter = DateFormatter()
		dateFormatter.calendar = .autoupdatingCurrent
		dateFormatter.locale   = .autoupdatingCurrent
		dateFormatter.timeZone = .autoupdatingCurrent
		dateFormatter.dateFormat = "dd MMM, yyyy · HH:mm"
		return dateFormatter
	}
}

public extension Date {
	var estalviaStyle: String {
		return DateFormatter.custom().string(from: self)
	}
}
