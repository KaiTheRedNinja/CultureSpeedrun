//
//  ChengduViewData.swift
//  
//
//  Created by Kai Quan Tay on 13/4/23.
//

import SwiftUI

struct VehicleStrip: Identifiable {
    var vehicles: [Vehicle]
    var speed: CGFloat
    var information: String? = nil
    var mediumStyle: VehicleMedium = .road
    var invert: Bool = false
    var id = UUID()

    enum VehicleMedium {
        case road, rail
    }

    @ViewBuilder
    func stripView(index: Int) -> some View {
        switch mediumStyle {
        case .road:
            VStack {
                ForEach(0..<10) { _ in
                    Color.white
                        .frame(width: 30, height: 100)
                    Color.black
                        .frame(width: 30, height: 100)
                }
            }
            .offset(y: index%2 == 0 ? 50 : 0)
        case .rail:
            ZStack {
                VStack {
                    ForEach(0..<20) { _ in
                        Color.white
                            .frame(height: 10)
                        Color.clear
                            .frame(height: 50)
                    }
                }
                .offset(y: index%2 == 0 ? 50 : 0)
                HStack {
                    Color.brown.frame(width: 10)
                    Color.clear
                    Color.brown.frame(width: 10)
                }
                .padding(.horizontal, 10)
            }
            .padding(.horizontal, 15)
            .offset(y: index%2 == 0 ? 50 : 0)
        }
    }

    static let roads: [VehicleStrip] = [
        .init(vehicles: [
            .init(color: .cyan, verticalPosition: 0, style: .car),
            .init(color: .red, verticalPosition: 700, style: .car),
        ], speed: 2, information: pandaMessages[0]),

        .init(vehicles: [
            .init(color: .orange, verticalPosition: 30, style: .car),
            .init(color: .yellow, verticalPosition: 600, style: .truck)
        ], speed: 3, invert: true),

        .init(vehicles: [
            .init(color: .green, verticalPosition: 50, style: .bus),
            .init(color: .purple, verticalPosition: 400, style: .car),
            .init(color: .red, verticalPosition: 900, style: .truck),
        ], speed: 4, information: pandaMessages[1]),

        .init(vehicles: [
            .init(color: .pink, verticalPosition: 80, style: .bus),
        ], speed: 5, invert: true),

        .init(vehicles: [
            .init(color: .yellow, verticalPosition: 100, style: .train),
        ], speed: 6, information: pandaMessages[2], mediumStyle: .rail),

        .init(vehicles: [
            .init(color: .white, verticalPosition: 0, style: .bus),
            .init(color: .brown, verticalPosition: 500, style: .truck),
        ], speed: 7, invert: true),

        .init(vehicles: [
            .init(color: .indigo, verticalPosition: 100, style: .car),
            .init(color: .mint, verticalPosition: 750, style: .truck),
            .init(color: .teal, verticalPosition: 1300, style: .bus),
        ], speed: 8, information: pandaMessages[3]),

        .init(vehicles: [
            .init(color: .cyan, verticalPosition: 500, style: .train),
        ], speed: 9, mediumStyle: .rail, invert: true),

        .init(vehicles: [
            .init(color: .red, verticalPosition: 0, style: .bus),
            .init(color: .green, verticalPosition: 700, style: .bus),
        ], speed: 10, information: pandaMessages[4])
    ]
}

let pandaMessages: [String] = [
    "Try to reach the bamboo at the end!",
    "In China, infrastructure development is increasingly reducing panda populations.",
    "Dams, roads, and rails fragment and isolate groups of pandas.",
    "Due to these interruptions, pandas are prevented from finding bamboo, their food source.",
    "The isolation of panda populations also prevents pandas from finding potential mates."
]

struct Vehicle: Identifiable {
    var color: Color
    var verticalPosition: CGFloat
    var style: VehicleStyle
    var id = UUID()

    var size: CGSize {
        switch style {
        case .car: return .init(width: 100, height: 150)
        case .truck: return .init(width: 100, height: 200)
        case .bus: return .init(width: 100, height: 250)
        case .train: return .init(width: 100, height: 500)
        }
    }

    enum VehicleStyle {
        case car, truck, bus, train
    }

    @ViewBuilder
    var look: some View {
        ZStack {
            switch style {
            case .car:
                color
                    .overlay(alignment: .bottom) {
                        HStack {
                            Color.yellow
                            Color.clear
                            Color.yellow
                        }
                        .padding(.horizontal, 10)
                        .frame(height: 10)
                    }
                    .cornerRadius(10)
                Color.black.opacity(0.2)
                    .overlay {
                        HStack {
                            Color.black.opacity(0.5).frame(width: 10)
                            Spacer()
                            Color.black.opacity(0.5).frame(width: 10)
                        }
                    }
                    .cornerRadius(10)
                    .padding(.vertical, 30)
            case .truck:
                color
                    .overlay(alignment: .bottom) {
                        HStack {
                            Color.yellow
                            Color.clear
                            Color.yellow
                        }
                        .padding(.horizontal, 10)
                        .frame(height: 10)
                    }
                    .cornerRadius(10)
                VStack {
                    Color.black.opacity(0.5)
                        .padding(10)
                    Color.black.opacity(0.2)
                        .overlay {
                            HStack {
                                Color.black.opacity(0.5).frame(width: 10)
                                Spacer()
                                Color.black.opacity(0.5).frame(width: 10)
                            }
                        }
                        .cornerRadius(5)
                        .padding(.bottom, 30)
                        .frame(height: 80)
                }
            case .bus:
                color
                    .overlay(alignment: .bottom) {
                        HStack {
                            Color.yellow
                            Color.clear
                            Color.yellow
                        }
                        .padding(.horizontal, 10)
                        .frame(height: 10)
                    }
                    .overlay {
                        VStack {
                            ForEach(0..<5) { index in
                                HStack {
                                    Color.black.opacity(0.5).frame(width: 10)
                                    if index%2 == 1 {
                                        Color.black.opacity(0.2).padding(.vertical, -10)
                                    } else {
                                        Color.clear
                                    }
                                    Color.black.opacity(0.5).frame(width: 10)
                                }
                            }
                            Color.black.opacity(0.5).frame(width: 80, height: 40)
                        }
                        .padding(.bottom, 30)
                        .padding(.top, 10)
                    }
                    .cornerRadius(10)
            case .train:
                color
                    .overlay(alignment: .bottom) {
                        HStack {
                            Color.yellow
                            Color.gray
                            Color.yellow
                        }
                        .padding(.horizontal, 10)
                        .frame(height: 10)
                    }
                    .overlay {
                        VStack {
                            Color.black.opacity(0.3)
                                .overlay {
                                    VStack {
                                        Color.clear
                                        Circle()
                                            .fill(.black)
                                            .opacity(0.6)
                                        Circle()
                                            .fill(.black)
                                            .opacity(0.6)
                                    }
                                    .padding(.vertical, 10)
                                }
                            Color.clear.frame(height: 60)
                            Color.black.opacity(0.3)
                                .overlay {
                                    VStack {
                                        Circle()
                                            .fill(.black)
                                            .opacity(0.6)
                                        Circle()
                                            .fill(.black)
                                            .opacity(0.6)
                                        Color.clear
                                    }
                                    .padding(.vertical, 10)
                                }
                        }
                        .frame(width: 70, height: 300)
                    }
                    .cornerRadius(10)
                VStack {
                    Color.black.opacity(0.2)
                        .overlay {
                            HStack {
                                Color.black.opacity(0.5).frame(width: 10)
                                Spacer()
                                Color.black.opacity(0.5).frame(width: 10)
                            }
                        }
                        .cornerRadius(10)
                        .frame(height: 50)
                        .padding(10)
                    Spacer()
                    Color.black.opacity(0.2)
                        .overlay {
                            HStack {
                                Color.black.opacity(0.5).frame(width: 10)
                                Spacer()
                                Color.black.opacity(0.5).frame(width: 10)
                            }
                        }
                        .cornerRadius(10)
                        .frame(height: 50)
                        .padding(10)
                }
            }
        }
        .frame(width: size.width, height: size.height)
    }
}
