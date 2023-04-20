//
//  ChengduView.swift
//  CultureSpeedrun
//
//  Created by Kai Quan Tay on 6/4/23.
//

import SwiftUI

struct ChengduView: View {
    @Binding var timeLeft: CGFloat
    @Binding var pauseTime: Bool
    @Binding var showTimeAndScore: Bool
    @Binding var points: Int

    var nextPage: () -> Void

    @State var showingGuide: Bool = false
    @State var showResults: Bool = false

    @State var backgroundScroll: CGFloat = 300
    @State var screenHeight: CGFloat = 0

    @State var roads: [VehicleStrip] = VehicleStrip.roads
    @State var movingPlayer: Bool = false

    @State var roadsCrossed: Int = 0
    @State var mistakesMade: Int = 0

    var roadDistance: CGFloat = 400
    var roadWidth: CGFloat = 150

    init(timeLeft: Binding<CGFloat>,
         pauseTime: Binding<Bool>,
         showTimeAndScore: Binding<Bool>,
         points: Binding<Int>,
         nextPage: @escaping () -> Void) {
        self._timeLeft = timeLeft
        self._pauseTime = pauseTime
        self._showTimeAndScore = showTimeAndScore
        self._points = points
        self.nextPage = nextPage
    }

    var body: some View {
        ZStack {
            content
            GuideView(showingGuide: .init(get: {
                showingGuide
            }, set: { newValue in
                showingGuide = newValue
                pauseTime = newValue
                showTimeAndScore = !newValue
            }), gameName: "🇨🇳 Panda Dash 🐼", instructions: Guide.china.rawValue)
        }
        .onChange(of: timeLeft) { _ in
            if timeLeft == 0 {
                showResultSheet()
            }
        }
        .sheet(isPresented: $showResults) {
            results
        }
    }

    var content: some View {
        ZStack(alignment: .leading) {
            Color.clear
            ZStack {
                ForEach(0..<roads.count, id: \.self) { road in
                    vehicleStripView(strip: roads[road], index: road)
                }
                Image("bamboo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
                    .offset(x: roadDistance * CGFloat(roads.count+1))
            }
            .offset(x: -backgroundScroll)
            Text("🐼")
                .font(.system(size: 90))
                .frame(width: 100, height: 100)
        }
        .padding(.leading, roadDistance/2)
        .overlay(alignment: .bottomLeading) {
            let currentRoad = Int((backgroundScroll-300)/roadDistance)
            if currentRoad < roads.count {
                let info = roads[currentRoad].information ?? ""
                Text(info)
                    .font(.title2)
                    .padding(25)
                    .frame(maxWidth: 300, minHeight: 100)
                    .background {
                        ZStack {
                            Color.primary.colorInvert()
                            Color.accentColor.opacity(0.8)
                        }
                        .cornerRadius(10)
                    }
                    .opacity(info.isEmpty ? 0 : 1)
                    .animation(.default, value: info)
            }
        }
        .background {
            GeometryReader { geom in
                Color.green.opacity(0.5)
                    .onChange(of: pauseTime) { _ in
                        if !pauseTime {
                            updateCars(viewHeight: geom.size.height)
                        }
                    }
            }
        }
        .onTapGesture {
            movePlayer()
        }
    }

    @ViewBuilder
    func vehicleStripView(strip: VehicleStrip, index: Int) -> some View {
        ZStack(alignment: .top) {
            Color.black
                .overlay {
                    strip.stripView(index: index)
                }
                .overlay {
                    let isForward = !strip.invert
                    ZStack(alignment: isForward ? .top : .bottom) {
                        Color.clear
                        ForEach(strip.vehicles) { car in
                            car.look
                                .rotationEffect(.degrees(isForward ? 0 : 180))
                                .offset(y: (car.verticalPosition-car.size.height) * (isForward ? 1 : -1))
                        }
                    }
                }
        }
        .frame(width: roadWidth)
        .offset(x: roadDistance * CGFloat(index+1))
    }

    func roadView(index: Int) -> some View {
        VStack {
            ForEach(0..<10) { _ in
                Color.white
                    .frame(width: 30, height: 100)
                Color.black
                    .frame(width: 30, height: 100)
            }
        }
        .offset(y: index%2 == 0 ? 50 : 0)
    }

    var results: some View {
        List {
            Section("Points") {
                Text("Roads crossed: \(roadsCrossed) (+\(roadsCrossed*5) points)")
                    .font(.title2)
                    .frame(maxWidth: .infinity, alignment: .center)
                Text("Times hit by vehicles: \(mistakesMade) (-\(mistakesMade) points)")
                    .font(.title2)
                    .frame(maxWidth: .infinity, alignment: .center)
                Text("Time left: \(Int(timeLeft)) (+\(Int(timeLeft)) points)")
                    .font(.title2)
                    .frame(maxWidth: .infinity, alignment: .center)
                Text("Total: \(points) points")
                    .font(.title)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
            Section {
                TextImageView(Backstory.china.rawValue)
            }
            Section {
                Button("Fly to Thailand") {
                    showResults = false
                    nextPage()
                }
            }
        }
        .interactiveDismissDisabled()
    }
}

struct ChengduView_Previews: PreviewProvider {
    static var previews: some View {
        ChengduView(
            timeLeft: .constant(30),
            pauseTime: .constant(false),
            showTimeAndScore: .constant(true),
            points: .constant(5),
            nextPage: {}
        )
        .ignoresSafeArea()
    }
}
