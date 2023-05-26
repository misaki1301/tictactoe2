//
//  MarkXView.swift
//  tictactoe2
//
//  Created by Paul Pacheco on 23/05/23.
//

import SwiftUI

struct MarkXView: View {
	var width: Double = 57.0
	var height: Double = 57.0
    var body: some View {
		VStack {
			Spacer()
			HStack {
				Spacer()
				ZStack {
					//Color.red
					Path() { path in
						path.move(to: CGPoint(x: width, y: 0))
						path.addLine(to: CGPoint(x: 0, y: width))
					}.stroke(Color("x_mark"),style: StrokeStyle(lineWidth: 8, lineCap: .square))
					Path() { path in
						path.move(to: CGPoint(x: 0, y: 0))
						path.addLine(to: CGPoint(x: width, y: width))
					}.stroke(Color("x_mark"),style: StrokeStyle(lineWidth: 8, lineCap: .square))
				}
				Spacer()
			}
			Spacer()
		}
    }
}

struct MarkCircleView: View {
	var width: Double = 57.0
	var height: Double = 57.0
	var body: some View {
		VStack {
			Spacer()
			HStack {
				Spacer()
				ZStack {
					//Color.red
					Path(ellipseIn: CGRect(x: 0, y: 0, width: width, height: width))
						.stroke(Color.white, lineWidth: 6)
				}
				Spacer()
			}
			Spacer()
		}
	}
}

struct MarkXView_Previews: PreviewProvider {
    static var previews: some View {
			MarkXView().previewLayout(.fixed(width: 57, height: 57))
		MarkCircleView().previewLayout(.fixed(width: 57, height: 57))
		
    }
}
