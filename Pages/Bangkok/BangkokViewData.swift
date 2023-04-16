//
//  BangkokViewData.swift
//  
//
//  Created by Kai Quan Tay on 16/4/23.
//

import Foundation

/*
 Temples with images:
 - Sanctuary of Truth
 - Wat Ban Kung (temple in a tree)
 - White temple

 Temples that should be included:
 - Temple of a million bottles
 - Wat Chaiwatthanaram (Temple of Long Reign and Glorious Era)
 */

struct TempleData {
    var name: String
    var description: String
    var questions: [MCQuestion]

    static let temples: [TempleData] = [
        .init(name: "Sanctuary of Truth",
              description: """
The Sanctuary of Truth (Thai: ปราสาทสัจธรรม) is an unfinished museum in Pattaya, \
Thailand designed by Thai businessman Lek Viriyaphan.[1] The museum structure is \
a hybrid of a temple and a castle that is themed on the Ayutthaya Kingdom and of \
Buddhist and Hindu beliefs. The building is notably constructed entirely out of \
wood, specifically Mai Deang, Mai Takien, Mai Panchaat, and Teak. It contains only \
wood-carved idols and sculptures. Construction first began in 1981 and is still in \
construction, though visitors are permitted inside with hard hats. Located on 13 \
hectares of land, the temple houses an internal space of 2,115 m2, with the tallest \
spire reaching to 30 m.[2]
""",
              questions: [
                .init(question: <#T##String#>,
                      options: <#T##[String]#>,
                      correctOption: <#T##Int#>)
              ]),
        .init(name: "Wat Pa Maha Chedi Kaew (Temple of a Million Bottles)",
              description: "",
              questions: [
                .init(question: <#T##String#>,
                      options: <#T##[String]#>,
                      correctOption: <#T##Int#>)
              ]),
        .init(name: "Wat Ban Kung (Temple in a tree)",
              description: "",
              questions: [
                .init(question: <#T##String#>,
                      options: <#T##[String]#>,
                      correctOption: <#T##Int#>)
              ]),
        .init(name: "Wat Chaiwatthanaram (Temple of Long Reign and Glorious Era)",
              description: "",
              questions: [
                .init(question: <#T##String#>,
                      options: <#T##[String]#>,
                      correctOption: <#T##Int#>)
              ]),
        .init(name: "White Temple",
              description: "",
              questions: [
                .init(question: <#T##String#>,
                      options: <#T##[String]#>,
                      correctOption: <#T##Int#>)
              ])
    ]
}

struct MCQuestion {
    var question: String
    var options: [String]
    var correctOption: Int
}
