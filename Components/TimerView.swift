//
//  TimerView.swift
//  CultureSpeedrun
//
//  Created by Kai Quan Tay on 6/4/23.
//

import SwiftUI
import Combine

struct TimerView: View {
    let maxTime: CGFloat
    let timer: Publishers.Autoconnect<Timer.TimerPublisher>

    @Binding var timeLeft: CGFloat
    @Binding var pauseTime: Bool

    init(maxTime: CGFloat,
         timeLeft: Binding<CGFloat>,
         pauseTime: Binding<Bool>) {
        self.maxTime = maxTime
        self._timeLeft = timeLeft
        self._pauseTime = pauseTime
        self.timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    }

    var body: some View {
        ZStack {
            Circle() // 2
                .stroke(Color.gray, lineWidth: 15)
            Circle()
                .trim(from: 0, to: 1-timeLeft/maxTime)
                .stroke(color, style: StrokeStyle(
                    lineWidth: 15,
                    lineCap: .round
                ))
            Text(Int(timeLeft).description)
                .animation(.none)
                .font(.title)
        }
        .onReceive(timer) { _ in
            print("Pause time: \(pauseTime)")
            if timeLeft-1 >= 0 && !pauseTime {
                withAnimation(.linear(duration: 1)) {
                    timeLeft -= 1
                }
            }
        }
    }

    var color: Color {
        let ratio = timeLeft/maxTime
        if ratio > 0.5 {
            return .green
        } else if ratio > 0.2 {
            return .yellow
        } else {
            return .red
        }
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack(alignment: .topLeading) {
            TimerView(maxTime: 10,
                      timeLeft: .constant(0),
                      pauseTime: .constant(false))
                .frame(width: 100, height: 100)
        }
    }
}
