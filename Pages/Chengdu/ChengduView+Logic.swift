//
//  ChengduView+Logic.swift
//  
//
//  Created by Kai Quan Tay on 13/4/23.
//

import SwiftUI

extension ChengduView {
    func updateCars(viewHeight: CGFloat) {
        let dissapearSize: CGFloat = 500
        Timer.scheduledTimer(withTimeInterval: 1/120, repeats: true) { timer in
            screenHeight = viewHeight
            if pauseTime { // if end game, invalidate
                timer.invalidate()
            }

            for roadIndex in roads.indices {
                let road = roads[roadIndex]
                for carIndex in 0..<road.vehicles.count {
                    let car = road.vehicles[carIndex]
                    roads[roadIndex].vehicles[carIndex].verticalPosition = (
                        car.verticalPosition + road.speed
                    ).truncatingRemainder(dividingBy: viewHeight+dissapearSize)
                }
            }
        }
    }

    func movePlayer() {
        guard !movingPlayer && !showingGuide && !showingGuide && !pauseTime else { return }
        movingPlayer = true
        let startTime = Date()
        let duration: Double = 0.5
        let start = backgroundScroll
        let end = backgroundScroll + roadDistance

        let currentRoad = Int((start-300)/roadDistance)

        // determine the range where the panda is "on the road"
        let middleOffset = backgroundScroll + (roadDistance/2)
        let roadStart = middleOffset - (roadWidth/2)
        let roadEnd = middleOffset + (roadWidth/2)

        guard currentRoad < roads.count else { return }

        Timer.scheduledTimer(withTimeInterval: 1/120, repeats: true) { timer in
            let now = Date()
            let interval = now.timeIntervalSince(startTime)

            // if the time was paused, end the timer.
            if pauseTime {
                timer.invalidate()
                movingPlayer = false
            }

            // if the player made it to the other end successfully
            if interval >= duration {
                backgroundScroll = end
                timer.invalidate()
                movingPlayer = false
                playerReachedEnd(currentRoad: currentRoad)
            } else {
                backgroundScroll = start + CGFloat(Double(end - start)*(interval/duration))
            }

            // test for cars
            guard backgroundScroll > roadStart && backgroundScroll < roadEnd else { return }
            testForPlayerHitCar(currentRoad: currentRoad, timer: timer, start: start)
        }
    }

    func playerReachedEnd(currentRoad: Int) {
        roadsCrossed += 1
        points += 5
        if currentRoad+1 == roads.count {
            // reached the end!!!
            showResultSheet()
        }
    }

    func testForPlayerHitCar(currentRoad: Int, timer: Timer, start: CGFloat) {
        // determine the range where a car is in the panda's path
        let middleRoad = screenHeight/2

        let road = roads[currentRoad]
        let cars = road.vehicles
        for car in cars {
            let vPosition: CGFloat
            if !road.invert {
                vPosition = car.verticalPosition - car.size.height
            } else {
                vPosition = screenHeight-car.verticalPosition + car.size.height
            }
            let upperRoad = middleRoad-(road.invert ? 0 : car.size.height)
            let lowerRoad = middleRoad+(road.invert ? car.size.height : 0)
            if vPosition > upperRoad && vPosition < lowerRoad {
                // player hit car
                mistakesMade += 1
                points -= 1
                timer.invalidate()
                withAnimation {
                    backgroundScroll = start
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    movingPlayer = false
                }
            }
        }
    }

    func showResultSheet() {
        showResults = true
        pauseTime = true
        showTimeAndScore = false

        points += Int(timeLeft)
    }
}
