//
//  MaterialButtonStyle.swift
//  tictactoe2
//
//  Created by Paul Pacheco on 25/05/23.
//

import Foundation
import SwiftUI

struct MaterialButtonStyle: ButtonStyle {
	func makeBody(configuration: Self.Configuration) -> some View {
		MaterialButtonStyleView(configuration: configuration)
	}
}

private extension MaterialButtonStyle {
	struct MaterialButtonStyleView: View {
		@Environment(\.isEnabled) var isEnabled
		let configuration: MaterialButtonStyle.Configuration
		
		var body: some View {
			return configuration.label
				.font(.custom("Poppins-Medium", size: 16))
				.foregroundColor(Color("font_primary"))
				.background(isEnabled ? Color("button_bg") : Color("button_bg_disabled"))
				.cornerRadius(100)
				.shadow(radius: 2, x: 0, y: 2)
				// make the button a bit more translucent when pressed
				.opacity(configuration.isPressed ? 0.8 : 1.0)
				// make the button a bit smaller when pressed
				.scaleEffect(configuration.isPressed ? 0.98 : 1.0)
		}
	}
}
