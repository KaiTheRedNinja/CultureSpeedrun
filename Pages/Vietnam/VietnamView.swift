//
//  VietnamView.swift
//  CultureSpeedrun
//
//  Created by Kai Quan Tay on 6/4/23.
//

import SwiftUI

/**
 Bun Cha Challenge: The player must use their finger to move a bowl of bun cha (Vietnamese
 noodles with grilled pork) around a maze, collecting herbs and avoiding obstacles.

 Bún chả is made up of many ingredients, which include:

 - Meat: minced pork shoulder to make meatballs, pork belly.
 - Rice vermicelli
 - Dipping sauce: diluted fish sauce with sugar, lemon juice, vinegar, stock, crushed garlic, chilli, etc.
 - Pickled vegetables: green papaya (or carrots, onion, kohlrabi).
 - Fresh herbs: cabbage, Láng basil, rice paddy herb (ngổ), beansprout, Vietnamese balm (kinh giới).
 - Side dishes: crushed garlic, crushed chilli, vinegar, ground pepper, sliced limes.

 The correct dishes are dotted along the path to the finish, and incorrect ones are dotted around every wrong turn.
 Explanations for what the ingredient does will pop up as they are collected.

 | Category | Includes | Excludes |
 | ------------ | ----------- | -------------|
 | Meat | Minced pork | Beef |
 | Carb | Rice vermicelli | Tofu |
 | Sauce | Fish sauce | Soya sauce |
 | Veg | Cabbage | Potatoes |
 | Side dishes | Sliced limes | Salad |
 */
struct VietnamView: View {
    @Binding var timeLeft: CGFloat
    @Binding var pauseTime: Bool
    @Binding var showTimeAndScore: Bool
    @Binding var points: Int

    var nextPage: () -> Void

    @State var showingGuide: Bool = false
    @State var showResults: Bool = false

    @State var playerCoordinates: MazeGridElement.Coordinate = .init(x: 0, y: 5)

    @State var obtainedFoods: [MazeGridElement.FoodItem] = []
    @State var correctFoods: Int = 0
    @State var wrongFoods: Int = 0

    @State var showFood: Bool = false
    @State var displayedFood: MazeGridElement.FoodItem!

    @Namespace var namespace

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
                .disabled(showingGuide)
            GuideView(showingGuide: .init(get: {
                showingGuide
            }, set: { newValue in
                showingGuide = newValue
                pauseTime = newValue
                showTimeAndScore = !newValue
            }), gameName: "🇻🇳 Bun Chua Challenge 🍜", instructions: Guide.vietnam.rawValue)
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

    func showResultSheet() {
        print("Showing results sheet!")

        displayedFood = nil
        showFood = false
        showResults = true
        pauseTime = true
        showTimeAndScore = false

        points = correctFoods*5 - wrongFoods*1 + Int(timeLeft)
    }

    var content: some View {
        ZStack {
            Color.brown
            VStack(spacing: 0) {
                maze
            }
            .padding(20)
            HStack {
                VStack {
                    Button {
                        showingGuide = true
                    } label: {
                        Image(systemName: showingGuide ? "play.fill" : "pause.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                    }
                    .popover(isPresented: $showFood) {
                        ZStack {
                            switch displayedFood {
                            case .included(let data):
                                Color.green.opacity(0.5)
                                VStack {
                                    Text("Correct ingrident: " + data.name + "!").bold()
                                    Text(data.description)
                                }
                            case .excluded(let data):
                                Color.red.opacity(0.5)
                                VStack {
                                    Text("Wrong ingredient: " + data.name).bold()
                                    Text(data.description)
                                }
                            case .none:
                                Text("none")
                            }
                        }
                        .frame(maxWidth: 300)
                    }
                    Spacer()
                }
                Spacer()
            }
            .padding(30)
        }
        .gesture(swipeGesture)
    }

    var maze: some View {
        ForEach(0..<MazeGridElement.maze.count, id: \.self) { row in
            HStack(spacing: 0) {
                ForEach(0..<MazeGridElement.maze[row].count, id: \.self) { col in
                    let item = MazeGridElement.maze[row][col]
                    ZStack {
                        Color.primary.colorInvert()
                            .overlay(alignment: .trailing) {
                                if item.blockedEdges.contains(.trailing) {
                                    Color.black.frame(width: 4)
                                }
                            }
                            .overlay(alignment: .leading) {
                                if item.blockedEdges.contains(.leading) {
                                    Color.black.frame(width: 4)
                                }
                            }
                            .overlay(alignment: .top) {
                                if item.blockedEdges.contains(.top) {
                                    Color.black.frame(height: 4)
                                }
                            }
                            .overlay(alignment: .bottom) {
                                if item.blockedEdges.contains(.bottom) {
                                    Color.black.frame(height: 4)
                                }
                            }
                            .aspectRatio(1, contentMode: .fit)
                            .padding(-4)
                        if let food = item.foodItem {
                            Circle()
                                .fill(.primary)
                                .overlay {
                                    Image(food.icon)
                                        .resizable()
                                        .scaledToFit()
                                        .padding(-3)
                                        .offset(x: 2)
                                }
                                .padding(2)
                                .opacity(obtainedFoods.contains(food) ? 0.5 : 1)
                        }
                        if playerCoordinates.y == row, playerCoordinates.x == col {
                            Image(systemName: "basket")
                                .resizable()
                                .scaledToFit()
                                .padding(5)
                                .matchedGeometryEffect(id: "basket", in: namespace)
                                .zIndex(10)
                        }
                        if item.isEndPoint {
                            Image(systemName: "trophy.fill")
                                .resizable()
                                .scaledToFit()
                                .padding(10)
                                .foregroundColor(.yellow)
                        }
                    }
                    .frame(maxWidth: 50, maxHeight: 50)
                }
            }
        }
    }

    var results: some View {
        List {
            Section("Points") {
                Text("Correct ingredients: \(correctFoods) (+\(correctFoods*5) points)")
                    .font(.title2)
                    .frame(maxWidth: .infinity, alignment: .center)
                Text("Incorrect ingredients: \(wrongFoods) (-\(wrongFoods) points)")
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
                TextImageView(Backstory.vietnam.rawValue)
            }
            Section {
                Button("Next Game") {
                    showResults = false
                    nextPage()
                }
            }
        }
        .interactiveDismissDisabled()
    }

    @State var lastTriggeredOffset: CGSize = .zero
    var actuationDistance: CGFloat = 40

    var swipeGesture: some Gesture {
        DragGesture()
            .onChanged{ value in
                // detect if value is larger than the actuation
                let widthDifference = lastTriggeredOffset.width - value.translation.width
                let heightDifference = lastTriggeredOffset.height - value.translation.height

                guard abs(widthDifference) > actuationDistance || abs(heightDifference) > actuationDistance else { return }
                lastTriggeredOffset = value.translation

                if abs(heightDifference) > abs(widthDifference) { // going vertically
                    if heightDifference > 0 { // up
                        moveInDirection(direction: .top)
                    } else { // down
                        moveInDirection(direction: .bottom)
                    }
                } else { // going horizontally
                    if widthDifference < 0 { // trailing
                        moveInDirection(direction: .trailing)
                    } else { // leading
                        moveInDirection(direction: .leading)
                    }
                }
            }
            .onEnded { value in
                lastTriggeredOffset = .zero
            }
    }

    func moveInDirection(direction: MazeGridElement.Edges) {
        let maze = MazeGridElement.maze
        let currentItem = maze[playerCoordinates.y][playerCoordinates.x]

        // determine how far in that direction the user can move
        var newCoordinates = playerCoordinates

        // determine if the movement is legal
        guard !currentItem.blockedEdges.contains(direction) else { return }

        switch direction {
        case .leading: newCoordinates.x -= 1
        case .trailing: newCoordinates.x += 1
        case .top: newCoordinates.y -= 1
        case .bottom: newCoordinates.y += 1
        }

        // determine if its out of bounds
        if newCoordinates.x < 0 || newCoordinates.x >= maze[0].count ||
            newCoordinates.y < 0 || newCoordinates.y >= maze.count {
            return
        }

        // move it to the new coordinates
        withAnimation {
            playerCoordinates = newCoordinates
            evaluateFood(newCoordinates: newCoordinates)
        }
    }

    func evaluateFood(newCoordinates: MazeGridElement.Coordinate) {
        let maze = MazeGridElement.maze
        if maze[newCoordinates.y][newCoordinates.x].isEndPoint {
            showResultSheet()
        }
        guard let food = maze[newCoordinates.y][newCoordinates.x].foodItem, !showResults else { return }
        switch food {
        case .included(_):
            // add points!
            points += 5
            displayedFood = food
            correctFoods += 1
        case .excluded(_):
            // remove points :(
            points -= 1
            displayedFood = food
            wrongFoods += 1
        }
        print("Displayed food (main): \(displayedFood)")
        DispatchQueue.main.async {
            print("Displayed food: \(displayedFood)")
            showFood = true
        }
        obtainedFoods.append(food)
    }
}

struct VietnamView_Previews: PreviewProvider {
    static var previews: some View {
        VietnamView(
            timeLeft: .constant(30),
            pauseTime: .constant(false),
            showTimeAndScore: .constant(true),
            points: .constant(5),
            nextPage: {}
        )
        .ignoresSafeArea()
    }
}
