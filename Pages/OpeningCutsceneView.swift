//
//  OpeningCutsceneView.swift
//  
//
//  Created by Kai Quan Tay on 19/4/23.
//

import SwiftUI

struct ChatItem: Identifiable {
    enum Sender {
        case family
        case boss
    }

    var sender: Sender
    var content: String
    var id = UUID()

    static let openingConversation: [ChatItem] = [
        .init(sender: .boss, content: "Hello Han Chong, we're offering you a senior executive position in Vietnam."),
        .init(sender: .family, content: "Thank you for your confidence in me, I’m really looking forward to taking on the role."),
        .init(sender: .family, content: "My family, especially my 2 young kids will also enjoy the new country."),
        .init(sender: .family, content: "Since they are so young, it’s easier for them to adapt. I’m also filled will anxiety knowing how tough it can be due to cultural and language differences."),
        .init(sender: .boss, content: "Don't worry, I'm sure you and your family will familiarise yourself with Vietnam well!")
    ]

    static let closingConversation: [ChatItem] = [
        .init(sender: .boss, content: "How was your journey?"),
        .init(sender: .family, content: "To spend more time with my family, I have decided to resign."),
        .init(sender: .boss, content: "We are sad to see you go. Thank you for your time spent with us."),
        .init(sender: .family, content: "Thank you for the opportunity to visit so many places!"),
    ]
}

struct CutsceneView: View {
    var nextPage: () -> Void

    var conversation: [ChatItem]

    var endText: String

    var body: some View {
        ZStack {
            Color.orange.opacity(0.2)
            content
        }
    }

    @State var textNumber = 1

    var content: some View {
        VStack {
            Spacer()
            ForEach(0..<textNumber, id: \.self) { index in
                let item = conversation[index]
                HStack {
                    if item.sender == .boss {
                        Spacer()
                        Text(item.content)
                            .frame(maxWidth: 300)
                            .padding(10)
                            .background {
                                Color.gray
                                    .cornerRadius(10)
                                    .overlay(alignment: .bottomTrailing) {
                                        Image(systemName: "triangle.fill")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 20, height: 20)
                                            .rotationEffect(.degrees(180))
                                            .foregroundColor(.gray)
                                            .offset(x: -40, y: 19)
                                    }
                                    .opacity(0.5)
                            }
                    } else {
                        Text(item.content)
                            .frame(maxWidth: 300)
                            .padding(10)
                            .background {
                                Color.green
                                    .cornerRadius(10)
                                    .overlay(alignment: .bottom) {
                                        Image(systemName: "triangle.fill")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 20, height: 20)
                                            .rotationEffect(.degrees(180))
                                            .foregroundColor(.green)
                                            .offset(x: 25, y: 19)
                                    }
                                    .opacity(0.5)
                            }
                        Spacer()
                    }
                }
                .padding(30)
            }
            HStack {
                VStack {
                    Text("My Dad")
                    HStack {
                        Image(systemName: "figure.and.child.holdinghands")
                            .resizable()
                            .scaledToFit()
                        Image(systemName: "figure.and.child.holdinghands")
                            .resizable()
                            .scaledToFit()
                    }
                }
                Spacer()
                Button(textNumber >= conversation.count ? endText : "Next") {
                    if textNumber >= conversation.count {
                        nextPage()
                    } else {
                        withAnimation {
                            textNumber += 1
                        }
                    }
                }
                .buttonStyle(.borderedProminent)
                Spacer()
                VStack {
                    Text("His boss")
                    Image(systemName: "figure.stand")
                        .resizable()
                        .scaledToFit()
                }
            }
            .frame(height: 160)
            .padding(50)
        }
    }
}

struct OpeningCutsceneView_Previews: PreviewProvider {
    static var previews: some View {
        CutsceneView(nextPage: {}, conversation: ChatItem.openingConversation, endText: "Fly to Vietnam")
    }
}
