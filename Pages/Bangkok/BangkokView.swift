//
//  BangkokView.swift
//  CultureSpeedrun
//
//  Created by Kai Quan Tay on 6/4/23.
//

import SwiftUI

struct BangkokView: View {
    @Binding var timeLeft: CGFloat
    @Binding var pauseTime: Bool
    @Binding var points: Int

    var nextPage: () -> Void

    var body: some View {
        Color.purple
        VStack {
            Text("Stuff here")
            Button("Toggle time pause") {
                pauseTime.toggle()
            }
        }
    }
}

struct BangkokView_Previews: PreviewProvider {
    static var previews: some View {
        BangkokView(
            timeLeft: .constant(30),
            pauseTime: .constant(false),
            points: .constant(5),
            nextPage: {}
        )
    }
}
