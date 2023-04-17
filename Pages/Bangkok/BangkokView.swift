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

    @State var temples: [TempleData] = TempleData.temples
    @State var templeIndex: Int = -1
    @State var showTemple: Bool = false

    var body: some View {
        ZStack {
            Color.purple
                .sheet(isPresented: $showTemple) {
                    templeView
                }
            Button("Next temple") {
                showTemple = false
                templeIndex += 1
                // TODO: Animate the movement
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    showTemple = true
                }
            }
            .buttonStyle(.borderedProminent)
        }
    }

    @ViewBuilder
    var templeView: some View {
        let temple = temples[templeIndex]
        List {
            Text(temple.name)
            Text(temple.description)
        }
    }
}

extension Int: Identifiable {
    public var id: Int { self }
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
