//
//  GuideView.swift
//  
//
//  Created by Kai Quan Tay on 7/4/23.
//

import SwiftUI

struct GuideView: View {
    @Binding var showingGuide: Bool
    @State var gameName: String
    @State var instructions: String

    @State var familyOffset: CGFloat

    init(showingGuide: Binding<Bool>, gameName: String, instructions: String) {
        self._showingGuide = showingGuide
        self.gameName = gameName
        self.instructions = instructions

        let screenSize = UIScreen.main.bounds

        self.familyOffset = screenSize.width * -1
    }

    @State var animating: Bool = false

    func animateGuideOpen() {
        guard !animating else { return }
        self.animating = true
        self.showingGuide = true
        self.familyOffset = UIScreen.main.bounds.width * -0.5
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            withAnimation(.easeOut(duration: 1)) {
                familyOffset = 0
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
            animating = false
        }
    }

    func animateGuideClose() {
        guard !animating else { return }
        animating = true
        withAnimation(.easeIn(duration: 0.7)) {
            self.familyOffset = UIScreen.main.bounds.width
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.4) {
            withAnimation(.easeIn(duration: 0.2)) {
                self.showingGuide = false
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.7) {
            animating = false
        }
    }

    var body: some View {
        Color.clear
            .sheet(isPresented: $showingGuide) {
                guide
                    .interactiveDismissDisabled()
                    .onTapGesture {
                        animateGuideClose()
                    }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.7) {
                    animateGuideOpen()
                }
            }
    }

    var guide: some View {
        VStack {
            VStack(alignment: .leading) {
                Text(gameName)
                    .bold()
                    .font(.largeTitle)
                Text(instructions)
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .padding(30)
            Spacer()
            HStack(alignment: .bottom) {
                Spacer()
                VStack {
                    HStack {
                        Image(systemName: "figure.and.child.holdinghands")
                            .resizable()
                            .scaledToFit()
                        Image(systemName: "figure.and.child.holdinghands")
                            .resizable()
                            .scaledToFit()
                    }
                    .frame(width: 230)
                }
                .offset(x: familyOffset)
                .zIndex(1)
                Spacer()
                VStack {
                    ZStack {
                        Color.green.opacity(0.8)
                            .frame(height: 50)
                        Text("ARRIVAL")
                            .font(.title)
                    }
                    Color.yellow
                }
                .frame(width: 180, height: 300)
                .zIndex(0)
            }
            .padding([.top, .bottom, .leading], 50) // not trailing
            .background {
                Color(red: 0.537, green: 0.812, blue: 0.941)
            }
            .overlay(alignment: .top) {
                Text("Tap to continue")
                    .font(.title2)
                    .padding(.top, 20)
            }
        }
    }
}

struct GuideView_Previews: PreviewProvider {
    static var previews: some View {
        GuideView(showingGuide: .constant(true),
                  gameName: "IDK man",
                  instructions: "TEST INSTRUCTIONS\nYEAAAA")
    }
}
