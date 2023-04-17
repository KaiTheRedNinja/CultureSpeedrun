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

struct TempleData: Identifiable {
    var name: String
    var description: String
    var question: MCQuestion
    var id = UUID()

    static let temples: [TempleData] = [
        .init(name: "Sanctuary of Truth",
              description: """
The Sanctuary of Truth (Thai: ปราสาทสัจธรรม) is an unfinished museum in the Pattaya province. \
The museum structure is a hybrid of a temple and a castle, themed on the Ayutthaya Kingdom and of \
Buddhist and Hindu beliefs.

Notably, the building is constructed entirely out of wood, with wood-carved idols and sculptures. \
The temple houses an internal space of 2,115 m2, with the tallest spire reaching to a staggering 30 metres (98 feet).
""",
              question: .init(question: "What is the inspiration behind the Sanctuary of Truth's architecture?",
                              options: [
                                "Greek and Roman Mythology",
                                "Buddhist and Hindu Traditions",
                                "Mayan Culture",
                                "Chinese Architecture"
                              ],
                              correctOption: 1,
                              explanation: """
The Sanctuary of Truth's architecture is heavily influenced by Buddhist and Hindu traditions. \
The temple features intricate carvings and sculptures that depict scenes from Buddhist and Hindu \
mythology. The temple's design is meant to represent the ancient philosophy of Earth, Wind, Fire, and Water.
""")
              ),
        .init(name: "Wat Pa Maha Chedi Kaew (Temple of a Million Bottles)",
              description: """
Wat Pa Maha Chedi Kaew, also known as the Temple of a Million \
Bottles, is a Buddhist temple in Khun Han district of Sisaket province, Thailand. \
The temple is made of over 1.5 million empty Heineken and Chang beer bottles. By 2009,
some 20 buildings had been similarly constructed.

The China Daily has said that "The Thai Buddhist temple has found an environmentally \
friendly way to utilize discarded bottles to reach nirvana (a form of buddhist inner peace)"
""",
              question: .init(question: "Who was the primary driving force behind the construction of the Temple of a Million Bottles?",
                              options: [
                                "A Buddhist monk",
                                "A local artist",
                                "A group of environmental activists",
                                "A government official"
                              ],
                              correctOption: 0,
                              explanation: """
The Temple of a Million Bottles was the brainchild of a Buddhist monk named Pra Khru Vijai, \
who saw the abundance of discarded glass bottles in his community as an opportunity to create \
something unique and environmentally friendly. With the help of his followers and local volunteers, \
he collected over a million bottles and used them to build the temple. The temple has since become \
a popular attraction and a symbol of sustainable architecture.
""")
              ),
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
              question: .init(question: "What is the most striking feature of Wat Ban Kung?", // TODO: Verify this
                              options: [
                                "The Buddha Image",
                                "The Garden",
                                "The Wood Carvings",
                                "The Traditional Motifs"
                              ],
                              correctOption: 0,
                              explanation: """
Explanation: The most prominent feature of Wat Ban Kung is its ordination hall, which houses a \
large and highly revered Buddha image. The hall is made of wood and decorated with intricate \
traditional motifs, but the Buddha image is the main attraction for visitors and pilgrims.
""")
              ),
        .init(name: "Wat Chaiwatthanaram (Temple of Long Reign and Glorious Era)",
              description: """
Located in Ayutthaya, the old capital of Siam (old Thailand), Wat Chaiwatthanaram (Thai: วัดไชยวัฒนาราม) is a \
Buddhist temple on the west bank of the Chao Phraya River, outside Ayutthaya island. It is one of \
Ayutthaya's best known temples and a major tourist attraction.
""",
              question: .init(question: "What is the significance of the number of smaller prangs surrounding the central prang at Wat Chaiwatthanaram?",
                              options: [
                                "It represents the 12 animals of the Thai zodiac",
                                "It symbolizes the 8-fold path of Buddhism",
                                "It corresponds to the 16 provinces of Ayutthaya",
                                "It mirrors the 9 levels of the Buddhist heaven"
                              ],
                              correctOption: 1,
                              explanation: """
The number of smaller prangs surrounding the central prang at Wat Chaiwatthanaram corresponds \
to the 9 levels of the Buddhist heaven. The temple's design is meant to represent Mount Meru, \
which is considered to be the center of the universe in Buddhist cosmology. The prangs, chedis, \
and viharas surrounding the central prang are meant to represent the mountains and continents \
that surround Mount Meru in Buddhist mythology.
""")
              ),
        .init(name: "White Temple",
              description: """
The temple was constructed in 1630 by the king, Prasat Thong, as the first temple of his reign, \
as a memorial of his mother's residence in that area. The temple's name literally means the Temple \
of long reign and glorious era. It was designed in Khmer style to gain Buddhist merit and as a \
memorial to his mother, however Prince Damrong believed it was built to celebrate Ayutthaya \
Kingdom's victory over Longvek.
""",
              question: .init(question: "What does the bridge leading up to the temple represent?",
                              options: [
                                "Attaining enlightment",
                                "The way to happyness",
                                "The path to the afterlife",
                                "Raising oneself above others"
                              ],
                              correctOption: 1,
                              explanation: """
The main building at the white temple, the ubosot, is reached by crossing a bridge over a small lake. \
In front of the bridge are hundreds of outreaching hands that symbolize unrestrained desire. The bridge \
proclaims that the way to happiness is by foregoing temptation, greed, and desire.
""")
              )
    ]
}

struct MCQuestion {
    var question: String
    var options: [String]
    var correctOption: Int
    var explanation: String
}
