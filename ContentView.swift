import SwiftUI

let timePerGame = 30.0

enum Page {
    case start, openCutscene, vietnam, china, bangkok, scoresheet
}

struct ContentView: View {
    @State var currentPage: Page = .start
    @State var showPlane: Bool = false
    @State var airplaneX: CGFloat = 0
    @State var size: CGSize = .zero

    @State var timeLeft: CGFloat = timePerGame
    @State var pauseTime: Bool = true
    @State var showTimeAndScore: Bool = true

    @State var vietnamPoints: Int = 0
    @State var chinaPoints: Int = 0
    @State var thailandPoints: Int = 0

    @Namespace var namespace

    enum PlaneState {
        case predeparture
        case departure
        case flight
        case arrival
        case postarrival
    }

    var body: some View {
        ZStack {
            pageContent
                .ignoresSafeArea()
            if currentPage != .start && currentPage != .scoresheet && showTimeAndScore {
                HStack {
                    Spacer()
                    VStack {
                        TimerView(maxTime: timePerGame, timeLeft: $timeLeft, pauseTime: $pauseTime)
                            .frame(width: 80, height: 80)
                            .padding(20)
                        Spacer()
                        PointsView(vietnamPoints: $vietnamPoints,
                                   chinaPoints: $chinaPoints,
                                   thailandPoints: $thailandPoints,
                                   page: $currentPage)
                    }
                }
            }
        }
        .overlay {
            ZStack {
                PlaneTrail()
                    .fill(Color(uiColor: .systemBackground))
                    .padding(.trailing, -size.width)
                    .offset(x: airplaneX)
                    .ignoresSafeArea()
                Image(systemName: "airplane")
                    .resizable()
                    .frame(width: 220, height: 200)
                    .matchedGeometryEffect(id: "plane", in: namespace, properties: .position)
                    .offset(x: airplaneX)
            }
            .opacity(showPlane ? 1 : 0)
        }
        .background {
            GeometryReader { geom in
                Color.clear
                    .onAppear { size = geom.size }
                    .onChange(of: geom.size) { size = $0 }
            }
        }
    }

    @ViewBuilder
    var pageContent: some View {
        switch currentPage {
        case .start:
            StartView(nextPage: nextPage)
        case .openCutscene:
            OpeningCutsceneView(nextPage: nextPage)
        case .vietnam:
            VietnamView(timeLeft: $timeLeft,
                        pauseTime: $pauseTime,
                        showTimeAndScore: $showTimeAndScore,
                        points: $vietnamPoints,
                        nextPage: nextPage)
        case .china:
            ChengduView(timeLeft: $timeLeft,
                        pauseTime: $pauseTime,
                        showTimeAndScore: $showTimeAndScore,
                        points: $chinaPoints,
                        nextPage: nextPage)
        case .bangkok:
            BangkokView(timeLeft: $timeLeft,
                        pauseTime: $pauseTime,
                        showTimeAndScore: $showTimeAndScore,
                        points: $thailandPoints,
                        nextPage: nextPage)
        case .scoresheet:
            ZStack {
                Color.blue
                Text("scoresheet")
            }
        }
    }

    func nextPage() {
        switch currentPage {
        case .start: switchTo(page: .openCutscene)
        case .openCutscene: switchTo(page: .vietnam)
        case .vietnam: switchTo(page: .china)
        case .china: switchTo(page: .bangkok)
        case .bangkok: switchTo(page: .scoresheet)
        default: break // do nothing for the last page
        }
    }

    func switchTo(page: Page) {
        let boundary = size.width/2 + 300
        airplaneX = -boundary
        withAnimation(.easeIn(duration: 0.5)) {
            showPlane = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            showTimeAndScore = false
            timeLeft = timePerGame
            pauseTime = true

            withAnimation(.linear(duration: 3)) {
                airplaneX = boundary*2
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.55) {
            currentPage = page
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            withAnimation(.easeOut(duration: 0.5)) {
                showPlane = false
            }
        }
    }
}

struct PlaneTrail: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let indent = rect.height/2
        path.move(to: .init(x: rect.minX, y: rect.minY))
        // indent
        path.addLine(to: .init(x: rect.minX + indent, y: rect.midY))
        // complete the shape
        path.addLine(to: .init(x: rect.minX, y: rect.maxY))
        path.addLine(to: .init(x: rect.maxX, y: rect.maxY))
        path.addLine(to: .init(x: rect.maxX, y: rect.minY))
        path.addLine(to: .init(x: rect.minX, y: rect.minY))

        return path
    }
}
