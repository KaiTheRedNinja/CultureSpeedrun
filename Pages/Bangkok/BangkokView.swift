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

    @State var showingGuide: Bool = false
    @State var showResults: Bool = false

    @State var temples: [TempleData] = TempleData.temples
    @State var templeIndex: Int = -1
    @State var showTemple: Bool = false

    var colors: [Color] = [.blue, .purple, .green, .yellow]
    var shapes: [String] = ["circle", "triangle", "square", "hexagon"]

    @State var pathPoint: CGFloat = 0.01

    var body: some View {
        ZStack {
            Color.purple
                .overlay {
                    thailandView
                        .padding(20)
                }
                .sheet(isPresented: $showTemple) {
                    templeView
                }
            GuideView(showingGuide: $showingGuide,
                      gameName: "Temple Run",
                      instructions: """
Thailand is a largely buddhist country, and as such temples are a large part \
of the country's culture.

[instructions]
""")
        }
    }

    var thailandView: some View {
        VStack {
            GeometryReader { geom in
                ZStack {
                    Color.purple
                    Color.purple
                        .frame(width: 500, height: 700)
                        .overlay {
                            Image("thailand")
                                .resizable()
                                .scaledToFit()
                        }
                        .overlay {
                            ZStack(alignment: .topLeading) {
                                TemplePathShape()
                                    .stroke(.blue, style: .init(lineWidth: 10))
                                Image(systemName: "airplane")
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .offset(x: -25, y: -25)
                                    .modifier(
                                        FollowEffect(pct: pathPoint,
                                                     path: TemplePathShape()
                                            .path(in: .init(origin: .zero,
                                                            size: .init(width: 500,
                                                                        height: 700))),
                                                     rotate: true)
                                    )
                            }
                        }
                        .scaleEffect(scaleForThailand(size: geom.size))
                }
            }
            if templeIndex == -1 {
                Button("Open first temple") {
                    withAnimation {
                        templeIndex += 1
                    }
                    showTemple = true
                }
                .buttonStyle(.borderedProminent)
                .tint(.primary)
                .padding(10)
            }
        }
    }

    func scaleForThailand(size: CGSize) -> CGSize {
        let widthScale = size.width / 500
        let heightScale = size.height / 700
        let lowerScale = min(widthScale, heightScale)
        return CGSize(width: lowerScale, height: lowerScale)
    }

    func nextTemple() {
        showTemple = false
        selectedOption = nil
        templeIndex += 1
        // TODO: Animate the movement
        if templeIndex >= temples.count {
            showResults = true
            return
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            withAnimation(.easeInOut(duration: 1.8)) {
                pathPoint = temples[templeIndex].location
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            showTemple = true
        }
    }

    @State var selectedOption: Int?

    @ViewBuilder
    var templeView: some View {
        let temple = temples[templeIndex]
        NavigationView {
            List {
                Section {
                    TextImageView(temple.description, imageMaxHeight: 400)
                }

                Section {
                    NavigationLink("Quiz") {
                        List {
                            templeQuizView
                        }
                        .navigationTitle("Quiz")
                    }
                }
            }
            .navigationTitle(temple.name)
        }
    }

    @ViewBuilder
    var templeQuizView: some View {
        let temple = temples[templeIndex]

        Section {
            TextImageView(temple.question.question)
            LazyVGrid(columns: .init(repeating: .init(), count: 2)) {
                ForEach(Array(temple.question.options.enumerated()),
                        id: \.offset) { (offset, option) in
                    Button {
                        guard selectedOption == nil else { return }
                        selectedOption = offset
                    } label: {
                        ZStack {
                            if let selectedOption {
                                if offset == temple.question.correctOption {
                                    Color.green
                                } else if selectedOption == offset {
                                    Color.red
                                } else {
                                    Color.gray
                                }
                            } else {
                                colors[offset]
                            }
                            HStack {
                                Image(systemName: "\(shapes[offset]).fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 35, height: 35)
                                Text(option)
                                    .frame(maxWidth: .infinity)
                                    .multilineTextAlignment(.leading)
                            }
                            .padding(.horizontal, 40)
                        }
                        .frame(minHeight: 100)
                        .cornerRadius(10)
                    }
                    .buttonStyle(.plain)
                }
            }
        }

        if let selectedOption {
            Section {
                Text(selectedOption == temple.question.correctOption ?
                     "Correct" : "Incorrect")
                    .font(.largeTitle)
                TextImageView(temple.question.explanation)
                HStack {
                    Spacer()
                    Button {
                        nextTemple()
                    } label: {
                        Text("Next Temple")
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

struct TemplePathShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: .init(x: rect.width * 0.44,
                            y: rect.height * 0.5))
        path.addLine(to: .init(x: rect.width * 0.8,
                               y: rect.height * 0.4))
        path.addLine(to: .init(x: rect.width * 0.35,
                               y: rect.height * 0.47))
        path.addLine(to: .init(x: rect.width * 0.42,
                               y: rect.height * 0.4))
        path.addLine(to: .init(x: rect.width * 0.35,
                               y: rect.height * 0.02))
        return path
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
