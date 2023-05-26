//
//  Score.swift
//  tictactoe2
//
//  Created by Paul Pacheco on 24/05/23.
//

import Foundation
enum Score: Identifiable {
	
	var id: Self {
		return self
	}
	
	case empty
	case nought
	case cross
}
