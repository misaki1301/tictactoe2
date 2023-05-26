//
//  HomeView.swift
//  tictactoe2
//
//  Created by Paul Pacheco on 23/05/23.
//

import SwiftUI

struct MatButton: View {
	var action: () -> Void
	var text: String = ""
	var body: some View {
		Button(action: {action()}) {
			Text(text)
				.padding(.horizontal, 24)
				.padding(.vertical, 8)
		}
		.buttonStyle(MaterialButtonStyle())
		.shadow(radius: 2, x: 0, y: 2)
	}
}

struct MatrixView: View {
	var hasStarted = false
	var widthGraph = 100.0
	
	var matrixArray: [[Score]] =
	[
		[.empty, .empty, .empty],
		[.empty, .empty, .empty],
		[.empty, .empty, .empty]
	]
	var playerAction: (Int, Int) -> Void
	
	var body: some View {
		let blockSize = widthGraph / 3.25
		//let widgetSize = widthGraph / 7
		//let circleSize = widthGraph / 5
		ZStack {
			Path() { path in
				path.move(to: CGPoint(x: widthGraph/1.5, y: 0))
				path.addLine(to: CGPoint(x: widthGraph/1.5, y: widthGraph))
			}.stroke(Color("matrix"),style: StrokeStyle(lineWidth: 6, lineCap: .round))
			Path() { path in
				path.move(to: CGPoint(x: widthGraph/3, y: 0))
				path.addLine(to: CGPoint(x: widthGraph/3, y: widthGraph))
			}.stroke(Color("matrix"),style: StrokeStyle(lineWidth: 6, lineCap: .round))
			Path() { path in
				path.move(to: CGPoint(x: 0, y: widthGraph/3))
				path.addLine(to: CGPoint(x: widthGraph, y: widthGraph/3))
			}.stroke(Color("matrix"),style: StrokeStyle(lineWidth: 6, lineCap: .round))
			Path() { path in
				path.move(to: CGPoint(x: 0, y: widthGraph/1.5))
				path.addLine(to: CGPoint(x: widthGraph, y: widthGraph/1.5))
			}.stroke(Color("matrix"),style: StrokeStyle(lineWidth: 6, lineCap: .round))
			VStack {
				ForEach(Array(matrixArray.enumerated()), id: \.offset) { column, innerArray in
					HStack {
						ForEach(Array(innerArray.enumerated()), id: \.offset) { row, item in
							if case .cross = item {
								MarkXView()
									.frame(width: blockSize, height: blockSize)
									//.padding(20)
							}
							if case .nought = item {
								MarkCircleView()
									.frame(width: blockSize, height: blockSize)
									//.padding(.top, 2)
									//.padding(.leading, 2)
							}
							if case .empty = item {
								ZStack {
									Color("background")
									//Color.red
									//Text("\(row)-\(column)")
								}.frame(width: blockSize, height: blockSize)
									.onTapGesture {
										if hasStarted {
											playerAction(column, row)
										}
									}
							}
						}
					}
				}
			}.frame(width: widthGraph, height: widthGraph)
		}
		.frame(width: widthGraph, height: widthGraph)
	}
}

struct ModalWinnerView: View {
	var winner: Player = .none
	var reset: () -> Void
	var body: some View {
		HStack {
			HStack {
				Image(systemName: "person.circle")
				VStack {
					if winner != .tie {
						Text("Ganador")
							.font(.custom("Poppins-Regular", size: 57))
					}
					switch (winner) {
						case .first:
							Text("Jugador 1")
								.font(.custom("Poppins-Regular", size: 57))
						case .second:
							Text("Jugador 2")
								.font(.custom("Poppins-Regular", size: 57))
						default:
							Text("Empate")
								.font(.custom("Poppins-Regular", size: 57))
					}
				}
			}.padding(.horizontal, 22)
				.padding(.vertical, 16)
		}.background(Color("card_bg"))
			.cornerRadius(16)
			.shadow(radius: 3, x: 0, y: 4)
			.padding(.top, 200)
			.onTapGesture {
				reset()
			}
	}
}

struct HomeView: View {
	@StateObject var viewModel = TicTacViewModel()
	var body: some View {
		GeometryReader { geo in
			let widthGraph = geo.size.width / 1.5
			ZStack(alignment: .top) {
				Color("background")
				VStack(alignment: .center) {
					HStack(spacing: 20) {
						MatButton(action: {}, text: "Jugador 1 O")
							.disabled(viewModel.currentPlayer
									!= .first)
						MatButton(action: {}, text: "Jugador 2 X")
							.disabled(viewModel.currentPlayer
									!= .second)
					}
					if viewModel.winner == .none {
					VStack {
						Text(viewModel.hasStarted ? "Reiniciar" : "Iniciar la partida")
							.font(.custom("Poppins-Regular", size: 24))
							.foregroundColor(Color("font_title"))
							.onTapGesture {
								if viewModel.hasStarted {
									viewModel.resetMatch()
								}
								viewModel.hasStarted.toggle()
							}
					}
					.padding(.vertical, 32)
					
						MatrixView(hasStarted: viewModel.hasStarted, widthGraph: widthGraph,
								   matrixArray: viewModel.matrixArray,
								   playerAction: viewModel.playerAction
						)
					} else {
						ModalWinnerView(winner: viewModel.winner, reset: viewModel.resetMatch)
					}
			}
				.padding(.top, 160)
			}.overlay(alignment: .bottom) {
				Image("footer")
						  .padding(.bottom, 28)
				  }
			.ignoresSafeArea()
		}
	}
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
