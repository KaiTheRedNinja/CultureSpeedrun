//
//  StartView.swift
//  CultureSpeedrun
//
//  Created by Kai Quan Tay on 6/4/23.
//

import SwiftUI

struct StartView: View {
    var nextPage: () -> Void

    init(nextPage: @escaping () -> Void) {
        self.nextPage = nextPage
    }

    var body: some View {
        ZStack {
            Color.white
                .overlay {
                    Image("journey map")
                        .resizable()
                        .scaledToFill()
                }
            Color.white
                .frame(width: 350, height: 300)
                .cornerRadius(50)
                .opacity(0.8)
                .overlay {
                    VStack {
                        Spacer()
                        Text("Culture Speedrun")
                            .font(.largeTitle)
                        Text("Around the Region in 3 Minutes")
                            .font(.title2)

                        Spacer()

                        Button {
                            nextPage()
                        } label: {
                            Text("START")
                                .padding(.horizontal, 60)
                                .padding(.vertical, 20)
                        }
                        .buttonStyle(.borderedProminent)
                        Spacer()
                    }
                }
        }
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView(nextPage: {})
    }
}
