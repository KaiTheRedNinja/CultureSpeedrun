//
//  PointsView.swift
//  CultureSpeedrun
//
//  Created by Kai Quan Tay on 6/4/23.
//

import SwiftUI

struct PointsView: View {
    @Binding var vietnamPoints: Int
    @Binding var chinaPoints: Int
    @Binding var thailandPoints: Int

    @Binding var page: Page

    var body: some View {
        VStack(alignment: .trailing) {
            textLabel(text: "\(vietnamPoints) 🌿", focus: .vietnam)
            textLabel(text: "\(chinaPoints) 🐼", focus: .china)
            textLabel(text: "\(thailandPoints) 🗺️", focus: .bangkok)
        }
        .font(.title)
    }

    @ViewBuilder
    func textLabel(text: String, focus: Page) -> some View {
        if page == focus {
            Text(text)
                .bold()
                .padding(.vertical, 5)
                .padding(.horizontal, 8)
                .background {
                    Color.accentColor
                        .opacity(0.7)
                        .cornerRadius(5)
                }
                .padding(.top, -10)
        } else {
            Text(text)
                .opacity(0.5)
        }
    }
}

struct PointsView_Previews: PreviewProvider {
    static var previews: some View {
        PointsView(vietnamPoints: .constant(15),
                   chinaPoints: .constant(50),
                   thailandPoints: .constant(20),
                   page: .constant(.bangkok))
    }
}
