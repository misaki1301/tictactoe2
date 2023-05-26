//
//  TicTacViewModel.swift
//  tictactoe2
//
//  Created by Paul Pacheco on 24/05/23.
//
import Foundation

class TicTacViewModel: ObservableObject {
	
	@Published var currentPlayer: Player = .first
	@Published var hasStarted = false
	@Published var turnCount = 0
	@Published var winner: Player = .none
	@Published var matrixArray: [[Score]] =
	[
		[.empty, .empty, .empty],
		[.empty, .empty, .empty],
		[.empty, .empty, .empty]
	]
	
	private func playerByScore(shape: Score) -> Player {
		let player: Player = shape == .nought ? .first : .second
		return player
	}

	
	func checkWinner() -> Player {
			var horizontalWinner = Array(repeating: Score.empty, count: 3)
			var verticalWinner = Array(repeating: Score.empty, count: 3)
			var leftDiagonalWinner = Array(repeating: Score.empty, count: 3)
			var rightDiagonalWinner = Array(repeating: Score.empty, count: 3)
			
			for (indexY, y) in matrixArray.enumerated() {
				leftDiagonalWinner[indexY] = matrixArray[indexY][indexY]
				rightDiagonalWinner[indexY] = matrixArray[indexY][(matrixArray.count - 1) - indexY]
				for (indexX, x) in y.enumerated() {
					horizontalWinner[indexX] = x
					//print("\(indexX) \(indexY)")
					verticalWinner[indexX] = matrixArray[indexX][indexY]
					if indexX == 2 {
						if verticalWinner.allSatisfy({$0 == .cross}) || verticalWinner.allSatisfy({$0 == .nought}) {
							winner = playerByScore(shape: verticalWinner[0])
							break
						}
						if horizontalWinner.allSatisfy({$0 == .cross}) || horizontalWinner.allSatisfy({$0 == .nought}) {
							winner = playerByScore(shape: horizontalWinner[0])
							break
						}
					}
					if indexY == 2 {
						if rightDiagonalWinner.allSatisfy({$0 == .nought}) || rightDiagonalWinner.allSatisfy({$0 == .cross}) {
							winner = playerByScore(shape: rightDiagonalWinner[0])
							break
						}
						if leftDiagonalWinner.allSatisfy({$0 == .nought}) || leftDiagonalWinner.allSatisfy({$0 == .cross}) {
							winner = playerByScore(shape: leftDiagonalWinner[0])
							break
						}
						
					}
				}
			}
		return winner
	}
	
	func playerAction(column: Int, row: Int) {
		let currentMatrixValue = matrixArray[column][row]
		
		if case .empty = currentMatrixValue {
			if case .first = currentPlayer {
				matrixArray[column][row] = .nought
				currentPlayer = .second
			}
			else if case .second = currentPlayer {
				matrixArray[column][row] = .cross
				currentPlayer = .first
			}
			//print(currentPlayer)
			turnCount += 1
			if turnCount >= 5 {
				winner = checkWinner()
			}
			if turnCount == 9 {
				if case .none = winner {
					winner = .tie
				}
			}
			
		}
	}
	
	func resetMatch() {
		matrixArray =
		[
			[.empty, .empty, .empty],
			[.empty, .empty, .empty],
			[.empty, .empty, .empty]
		]
		currentPlayer = .first
		winner = .none
		hasStarted = false
		turnCount = 0
	}
	
	
	
}
