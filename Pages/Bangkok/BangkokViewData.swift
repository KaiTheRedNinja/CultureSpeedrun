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
The Sanctuary of Truth (Thai: ปราสาทสัจธรรม) is an unfinished museum in the Pattaya province. \
The museum structure is a hybrid of a temple and a castle, themed on the Ayutthaya Kingdom and of \
Buddhist and Hindu beliefs.

Notably, the building is constructed entirely out of wood, with wood-carved idols and sculptures. \
The temple houses an internal space of 2,115 m2, with the tallest spire reaching to a staggering 30 metres (98 feet).
""",
              questions: [
                .init(question: "Something",
                      options: [
                        "option 1",
                        "option 2",
                        "option 3",
                        "option 4"
                      ],
                      correctOption: 1)
              ]),
        .init(name: "Wat Pa Maha Chedi Kaew (Temple of a Million Bottles)",
              description: """
Wat Pa Maha Chedi Kaew, also known as the Temple of a Million \
Bottles, is a Buddhist temple in Khun Han district of Sisaket province, Thailand. \
The temple is made of over 1.5 million empty Heineken and Chang beer bottles. By 2009,
some 20 buildings had been similarly constructed.

The China Daily has said that "The Thai Buddhist temple has found an environmentally \
friendly way to utilize discarded bottles to reach nirvana (a form of buddhist inner peace)"
""",
              questions: [
                .init(question: "Something",
                      options: [
                        "option 1",
                        "option 2",
                        "option 3",
                        "option 4"
                      ],
                      correctOption: 1)
              ]),
        .init(name: "Wat Ban Kung (Temple in a tree)",
              description: """
Wat Bang Kung (Thai: วัดบางกุ้ง) is an ancient temple in Samut Songkhram, Thailand. It was \
built in the Ayutthaya period, and was the site of the Battle of Bang Kung between the \
Konbaung Dynasty and the Thonburi Kingdom.

The Ubosot (Ordination Hall) is covered with roots of four plants, Pho (Bodhi), Sai (Banyan), Krai, and Krang. \
These roots help the hall to stay stable. There is a statue of the Buddha enshrined in the hall, \
commonly called Luang Phot Bot Noi. Inside the hall, there is a mural that shows a story about \
Buddha. The Fine Arts Department has registered Wat Bang Kung as a national archaeological \
site on December 18, 1996.
""",
              questions: [
                .init(question: "Something",
                      options: [
                        "option 1",
                        "option 2",
                        "option 3",
                        "option 4"
                      ],
                      correctOption: 1)
              ]),
        .init(name: "Wat Chaiwatthanaram (Temple of Long Reign and Glorious Era)",
              description: """
Located in Ayutthaya, the old capital of Thailand, Wat Chaiwatthanaram (Thai: วัดไชยวัฒนาราม) is a \
Buddhist temple on the west bank of the Chao Phraya River, outside Ayutthaya island. It is one of \
Ayutthaya's best known temples and a major tourist attraction.
""",
              questions: [
                .init(question: "Something",
                      options: [
                        "option 1",
                        "option 2",
                        "option 3",
                        "option 4"
                      ],
                      correctOption: 1)
              ]),
        .init(name: "White Temple",
              description: """
The temple was constructed in 1630 by the king, Prasat Thong, as the first temple of his reign, \
as a memorial of his mother's residence in that area. The temple's name literally means the Temple \
of long reign and glorious era. It was designed in Khmer style to gain Buddhist merit and as a \
memorial to his mother, however Prince Damrong believed it was built to celebrate Ayutthaya \
Kingdom's victory over Longvek.
""",
              questions: [
                .init(question: "Something",
                      options: [
                        "option 1",
                        "option 2",
                        "option 3",
                        "option 4"
                      ],
                      correctOption: 1)
              ])
    ]
}

struct MCQuestion {
    var question: String
    var options: [String]
    var correctOption: Int
}
