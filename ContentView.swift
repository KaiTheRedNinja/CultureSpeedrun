import SwiftUI

let timePerGame = 30.0

enum Page {
    case start, vietnam, china, bangkok, scoresheet
}

struct ContentView: View {
    @State var currentPage: Page = .start
    @State var showPlane: Bool = false
    @State var showCutscene: Bool = false
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
                ZStack {
                    PlaneTrail()
                        .fill(Color(uiColor: .systemBackground))
                        .padding(.trailing, -size.width)
                    Image(systemName: "airplane")
                        .resizable()
                        .frame(width: 220, height: 200)
                        .matchedGeometryEffect(id: "plane", in: namespace, properties: .position)
                }
                .offset(x: airplaneX)

                cutsceneContent
                    .opacity(showCutscene ? 1 : 0)
            }
            .ignoresSafeArea()
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
            ScoresheetView(vietnamPoints: $vietnamPoints,
                           chinaPoints: $chinaPoints,
                           thailandPoints: $thailandPoints)
        }
    }

    @ViewBuilder
    var cutsceneContent: some View {
        switch currentPage {
        case .start:
            CutsceneView(nextPage: finaliseSwitch,
                         conversation: ChatItem.openingConversation,
                         endText: "Fly to Vietnam 🇻🇳")
        case .vietnam:
            CutsceneView(nextPage: finaliseSwitch,
                         conversation: [.init(sender: .boss, content: "Go to your next job")],
                         endText: "Fly to Chengdu 🇨🇳")
        case .china:
            CutsceneView(nextPage: finaliseSwitch,
                         conversation: [.init(sender: .boss, content: "Go to your next job")],
                         endText: "Fly to Thailand 🇹🇭")
        case .bangkok:
            CutsceneView(nextPage: finaliseSwitch,
                         conversation: ChatItem.closingConversation,
                         endText: "Go to scoresheet")
        default: Text("No cutscene")
        }
    }

    func nextPage() {
        switch currentPage {
        case .start: switchTo(page: .vietnam)
        case .vietnam: switchTo(page: .china)
        case .china: switchTo(page: .bangkok)
        case .bangkok: switchTo(page: .scoresheet)
        default: break // do nothing for the last page
        }
    }

    @State var pageToSwitch: Page?
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
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.55) {
            withAnimation {
                showCutscene = true
            }
        }
        pageToSwitch = page
    }

    func finaliseSwitch() {
        let boundary = size.width/2 + 300
        withAnimation(.linear(duration: 0.5)) {
            showCutscene = false
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            currentPage = pageToSwitch!
            pageToSwitch = nil
            withAnimation(.linear(duration: 3)) {
                airplaneX = boundary*2
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                withAnimation(.easeOut(duration: 0.5)) {
                    showPlane = false
                }
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
