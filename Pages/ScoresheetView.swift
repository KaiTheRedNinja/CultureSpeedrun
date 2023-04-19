//
//  ScoresheetView.swift
//  
//
//  Created by Kai Quan Tay on 19/4/23.
//

import SwiftUI

struct ScoresheetView: View {
    @Binding var vietnamPoints: Int
    @Binding var chinaPoints: Int
    @Binding var thailandPoints: Int

    var totalPoints: Int {
        vietnamPoints + chinaPoints + thailandPoints
    }

    var body: some View {
        List {
            Section {
                HStack {
                    Spacer()
                    Image(systemName: "trophy.fill")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.yellow)
                        .frame(width: 200, height: 200)
                        .overlay {
                            Text("\(totalPoints)")
                                .offset(y: -40)
                                .font(.title)
                        }
                    Spacer()
                }
                .listRowBackground(Color.clear)
            }

            Section("Game points") {
                HStack {
                    Text("Vietnam Bun Chua Challenge Points:")
                    Spacer()
                    Text("\(vietnamPoints)")
                }
                .font(.title2)
                HStack {
                    Text("China Panda Dash Points:")
                    Spacer()
                    Text("\(vietnamPoints)")
                }
                .font(.title2)
                HStack {
                    Text("Thailand Temple Run Points:")
                    Spacer()
                    Text("\(vietnamPoints)")
                }
                .font(.title2)

                HStack {
                    Text("Total Points")
                    Spacer()
                    Text("\(totalPoints)")
                }
                .font(.title2)
            }

            Section {
                Text("Thanks for playing 😊")
                    .font(.title)
                    .frame(maxWidth: .infinity)
                    .listRowBackground(Color.clear)
            }
        }
    }
}
