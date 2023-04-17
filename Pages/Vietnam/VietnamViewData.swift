//
//  VietnamViewData.swift
//  
//
//  Created by Kai Quan Tay on 7/4/23.
//

import Foundation

struct MazeGridElement: Hashable {
    var blockedEdges: [Edges]
    var foodItem: FoodItem?
    var isEndPoint: Bool

    init(
        blockedEdges: [Edges],
        foodItem: FoodItem? = nil,
        isEndPoint: Bool = false
    ) {
        self.blockedEdges = blockedEdges
        self.foodItem = foodItem
        self.isEndPoint = isEndPoint
    }

    struct Coordinate: Hashable {
        var x: Int
        var y: Int
    }

    enum Edges: Hashable {
        case top, bottom, leading, trailing
    }

    enum FoodItem: Hashable, Identifiable {
        var id: Int {
            switch self {
            case .included(let data): return data.hashValue
            case .excluded(let data): return data.hashValue
            }
        }

        struct FoodData: Hashable {
            var name: String
            var description: String
            var icon: String
        }

        case included(FoodData)
        case excluded(FoodData)

        var icon: String {
            switch self {
            case .included(let data): return data.icon
            case .excluded(let data): return data.icon
            }
        }

        // included (x7)
        static let included1: FoodItem = .included(.init(name: "Minced pork", description: """
Minced pork is the main protein in Vietnamese Bun Cha. The minced pork is typically seasoned with fish \
sauce, sugar, garlic, and black pepper before being shaped into small meatballs and grilled over charcoal.
""", icon: "mincedpork"))
        static let included2: FoodItem = .included(.init(name: "Rice vermicelli", description: """
Rice vermicelli is a type of thin rice noodle that is commonly used in Vietnamese cuisine, including in dishes like Bun Cha
""", icon: "vermicelli"))
        static let included3: FoodItem = .included(.init(name: "Fish sauce", description: """
Fish sauce is a condiment made from fermented fish, salt, and water, that is widely used in Southeast \
Asian cuisine as a flavor enhancer and dipping sauce.
""", icon: "fishsauce"))
        static let included4: FoodItem = .included(.init(name: "Cabbage", description: """
Cabbage is a leafy vegetable that is low in calories and high in fiber, vitamin C, and vitamin K, \
and commonly used in salads, stir-fries, and soups.
""", icon: "cabbage"))
        static let included5: FoodItem = .included(.init(name: "Sliced limes", description: """
Sliced limes are citrus fruit that is high in vitamin C, and commonly used in Vietnamese cuisine \
as a garnish and source of acidity to balance out savory and spicy flavors.
""", icon: "lime"))
        static let included6: FoodItem = .included(.init(name: "Green papaya", description: """
Green papaya is an unripe papaya that is low in calories and high in vitamin C, and commonly used in \
salads and pickles in Southeast Asian cuisine.
""", icon: "papaya"))
        static let included7: FoodItem = .included(.init(name: "Beansprout", description: """
Beansprouts are vegetable commonly used in Asian cuisine that is low in calories and high in fiber,
vitamin C, and vitamin K, and adds crunch and freshness to dishes.
""", icon: "beansprout"))

        // excluded (x13)
        static let excluded1: FoodItem = .excluded(.init(name: "Beef", description: """
While beef is a common protein in Vietnamese cuisine, it is not typically used in Bun Cha, \
which traditionally features grilled pork meatballs.
""", icon: "beef"))
        static let excluded2: FoodItem = .excluded(.init(name: "Tofu", description: """
Tofu is not typically used in Bun Cha, as the dish relies on grilled pork meatballs as the main protein.
""", icon: "tofu"))
        static let excluded3: FoodItem = .excluded(.init(name: "Soya Sauce", description: """
While soy sauce is a common condiment in Vietnamese cuisine, it is not typically used in \
Bun Cha, which relies on fish sauce as the main seasoning.
""", icon: "soysauce"))
        static let excluded4: FoodItem = .excluded(.init(name: "Potatoes", description: """
Potatoes are not typically used in Vietnamese Bun Cha, which instead features rice noodles \
and fresh vegetables like cabbage and beansprouts.
""", icon: "potato"))
        static let excluded5: FoodItem = .excluded(.init(name: "Salad", description: """
While fresh herbs and vegetables like mint and bok choy are commonly used in Bun Cha, a traditional \
salad is not typically included in the dish.
""", icon: "salad"))
        static let excluded6: FoodItem = .excluded(.init(name: "Chicken", description: """
While chicken is a common protein in Vietnamese cuisine, it is not typically used in Bun Cha, \
which traditionally features grilled pork meatballs.
""", icon: "chicken"))
        static let excluded7: FoodItem = .excluded(.init(name: "Mushrooms", description: """
While mushrooms are a common ingredient in many Asian cuisines, they are not typically included \
in Vietnamese Bun Cha, which instead features fresh herbs and vegetables like mint and beansprouts.
""", icon: "mushroom"))
        static let excluded8: FoodItem = .excluded(.init(name: "Bok Choy", description: """
Bok choy is a leafy vegetable commonly used in Asian cuisine, but is not typically included \
in Vietnamese Bun Cha, which instead features fresh herbs and vegetables like mint and beansprouts.
""", icon: "bokchoy"))
        static let excluded9: FoodItem = .excluded(.init(name: "Edamame", description: """
Edamame, or soybeans, are not typically used in Vietnamese Bun Cha, which instead features fresh \
vegetables like beansprouts and green papaya.
""", icon: "edamame"))
        static let excluded10: FoodItem = .excluded(.init(name: "Bamboo shoots", description: """
While bamboo shoots are a common ingredient in Southeast Asian cuisine, they are not \
typically included in Vietnamese Bun Cha, which instead features fresh herbs and vegetables like mint and cabbage.
""", icon: "bamboo"))
        static let excluded11: FoodItem = .excluded(.init(name: "Cheese", description: """
Cheese is not typically used in Vietnamese cuisine, including Bun Cha, which instead features fresh \
herbs and vegetables, rice noodles, and grilled pork meatballs.
""", icon: "cheese"))
        static let excluded12: FoodItem = .excluded(.init(name: "Broccoli", description: """
Broccoli is not typically used in Vietnamese Bun Cha, which instead features fresh vegetables \
like cabbage and beansprouts.
""", icon: "broccoli"))
        static let excluded13: FoodItem = .excluded(.init(name: "Lotus root", description: """
Lotus root is not typically used in Vietnamese Bun Cha, which instead features fresh vegetables \
like beansprouts and green papaya.
""", icon: "lotus"))
    }

    static let maze: [[MazeGridElement]] = [
        [ // row 1
            .init(blockedEdges: [.top, .leading]),
            .init(blockedEdges: [.top]),
            .init(blockedEdges: [.top, .trailing]),
            .init(blockedEdges: [.top, .leading]),
            .init(blockedEdges: [.top, .trailing]),
            .init(blockedEdges: [.top, .leading, .bottom]),
            .init(blockedEdges: [.top, .bottom]),
            .init(blockedEdges: [.top, .bottom]),
            .init(blockedEdges: [.top, .trailing]),
            .init(blockedEdges: [.top, .leading, .bottom]),
            .init(blockedEdges: [.top, .trailing]),
            .init(blockedEdges: [.top, .leading]),
            .init(blockedEdges: [.top, .bottom]),
            .init(blockedEdges: [.top]),
            .init(blockedEdges: [.top, .trailing]),
            .init(blockedEdges: [.top, .leading]),
            .init(blockedEdges: [.top, .bottom, .trailing])
        ],
        [ // row 2
            .init(blockedEdges: [.leading]),
            .init(blockedEdges: [.trailing, .bottom], foodItem: .excluded1),
            .init(blockedEdges: [.leading, .trailing, .bottom]),
            .init(blockedEdges: [.leading, .trailing]),
            .init(blockedEdges: [.leading, .bottom]),
            .init(blockedEdges: [.top, .bottom]),
            .init(blockedEdges: [.top, .bottom]),
            .init(blockedEdges: [.top, .bottom], foodItem: .excluded2),
            .init(blockedEdges: [.trailing, .bottom]),
            .init(blockedEdges: [.leading, .top]),
            .init(blockedEdges: [.trailing]),
            .init(blockedEdges: [.leading, .trailing]),
            .init(blockedEdges: [.leading, .top, .bottom]),
            .init(blockedEdges: [.trailing, .bottom], foodItem: .excluded3),
            .init(blockedEdges: [.leading, .trailing]),
            .init(blockedEdges: [.leading, .bottom]),
            .init(blockedEdges: [.top, .trailing])
        ],
        [ // row 3
            .init(blockedEdges: [.leading, .bottom]),
            .init(blockedEdges: [.top]),
            .init(blockedEdges: [.top]),
            .init(blockedEdges: [.trailing, .bottom], foodItem: .excluded4),
            .init(blockedEdges: [.leading, .trailing, .top]),
            .init(blockedEdges: [.leading, .top]),
            .init(blockedEdges: [.trailing, .top]),
            .init(blockedEdges: [.leading, .trailing, .top]),
            .init(blockedEdges: [.leading, .top]),
            .init(blockedEdges: [.trailing]),
            .init(blockedEdges: [.leading, .bottom], foodItem: .excluded5),
            .init(blockedEdges: [.trailing, .bottom]),
            .init(blockedEdges: [.leading, .top]),
            .init(blockedEdges: [.trailing, .top]),
            .init(blockedEdges: [.leading, .trailing, .bottom]),
            .init(blockedEdges: [.leading, .top]),
            .init(blockedEdges: [.trailing, .bottom]),
        ],
        [ // row 4,
            .init(blockedEdges: [.leading, .top]),
            .init(blockedEdges: [.trailing, .bottom]),
            .init(blockedEdges: [.leading, .trailing], foodItem: .included1),
            .init(blockedEdges: [.leading, .top]),
            .init(blockedEdges: [.bottom]),
            .init(blockedEdges: [.trailing, .bottom]),
            .init(blockedEdges: [.leading]),
            .init(blockedEdges: [.bottom], foodItem: .excluded6),
            .init(blockedEdges: [.trailing, .bottom]),
            .init(blockedEdges: [.leading, .bottom]),
            .init(blockedEdges: [.top]),
            .init(blockedEdges: [.trailing, .top]),
            .init(blockedEdges: [.leading, .trailing]),
            .init(blockedEdges: [.leading, .bottom]),
            .init(blockedEdges: [.trailing, .top]),
            .init(blockedEdges: [.leading, .bottom], foodItem: .excluded7),
            .init(blockedEdges: [.top, .trailing])
        ],
        [ // row 5,
            .init(blockedEdges: [.leading, .bottom]),
            .init(blockedEdges: [.trailing, .top]),
            .init(blockedEdges: [.leading, .bottom]),
            .init(blockedEdges: [.bottom]),
            .init(blockedEdges: [.top, .bottom], foodItem: .excluded8),
            .init(blockedEdges: [.trailing, .top]),
            .init(blockedEdges: [.leading, .bottom], foodItem: .included2),
            .init(blockedEdges: [.top]),
            .init(blockedEdges: [.top]),
            .init(blockedEdges: [.trailing, .top]),
            .init(blockedEdges: [.leading, .trailing]),
            .init(blockedEdges: [.leading, .bottom], foodItem: .excluded9),
            .init(blockedEdges: [.trailing, .bottom]),
            .init(blockedEdges: [.leading, .top, .bottom]),
            .init(blockedEdges: [.bottom]),
            .init(blockedEdges: [.trailing, .top]),
            .init(blockedEdges: [.leading, .trailing])
        ],
        [ // row 6,
            .init(blockedEdges: [.top, .bottom]), // START POINT
            .init(blockedEdges: [.trailing, .bottom], foodItem: .included3),
            .init(blockedEdges: [.leading, .top]),
            .init(blockedEdges: [.trailing, .top, .bottom]),
            .init(blockedEdges: [.leading, .top]),
            .init(blockedEdges: [.trailing, .bottom]),
            .init(blockedEdges: [.leading, .top]),
            .init(blockedEdges: [.trailing, .bottom]),
            .init(blockedEdges: [.leading, .trailing, .bottom]),
            .init(blockedEdges: [.leading, .trailing]),
            .init(blockedEdges: [.leading, .trailing]),
            .init(blockedEdges: [.leading, .trailing, .top]),
            .init(blockedEdges: [.leading, .top]),
            .init(blockedEdges: [.top, .bottom]),
            .init(blockedEdges: [.trailing, .top]),
            .init(blockedEdges: [.leading, .bottom]),
            .init(blockedEdges: [.bottom, .trailing])
        ],
        [ // row 7,
            .init(blockedEdges: [.leading, .top]),
            .init(blockedEdges: [.top, .bottom]),
            .init(blockedEdges: [.bottom], foodItem: .excluded10),
            .init(blockedEdges: [.trailing, .top, .bottom]),
            .init(blockedEdges: [.leading, .trailing, .bottom]),
            .init(blockedEdges: [.leading, .top]),
            .init(blockedEdges: [.trailing, .bottom]),
            .init(blockedEdges: [.leading, .top, .bottom]),
            .init(blockedEdges: [.top, .bottom]),
            .init(blockedEdges: [.trailing, .bottom]),
            .init(blockedEdges: [.leading, .bottom]),
            .init(blockedEdges: [.trailing, .bottom]),
            .init(blockedEdges: [.leading, .bottom]),
            .init(blockedEdges: [.trailing, .top]),
            .init(blockedEdges: [.leading]),
            .init(blockedEdges: [.top, .bottom], foodItem: .included4),
            .init(blockedEdges: [.top], isEndPoint: true) // END POINT
        ],
        [ // row 8,
            .init(blockedEdges: [.leading, .trailing]),
            .init(blockedEdges: [.leading, .trailing, .top]),
            .init(blockedEdges: [.leading, .top]),
            .init(blockedEdges: [.top]),
            .init(blockedEdges: [.trailing, .top, .bottom]),
            .init(blockedEdges: [.leading, .bottom]),
            .init(blockedEdges: [.top, .bottom]),
            .init(blockedEdges: [.top, .bottom]),
            .init(blockedEdges: [.trailing, .top]),
            .init(blockedEdges: [.leading, .top]),
            .init(blockedEdges: [.top, .bottom], foodItem: .excluded11),
            .init(blockedEdges: [.trailing, .top]),
            .init(blockedEdges: [.leading, .top, .bottom]),
            .init(blockedEdges: [.trailing, .bottom]),
            .init(blockedEdges: [.leading, .trailing], foodItem: .included5),
            .init(blockedEdges: [.leading, .top, .bottom]),
            .init(blockedEdges: [.trailing, .bottom])
        ],
        [ // row 9,
            .init(blockedEdges: [.leading, .trailing]),
            .init(blockedEdges: [.leading, .bottom]),
            .init(blockedEdges: [.trailing, .bottom]),
            .init(blockedEdges: [.leading, .trailing]),
            .init(blockedEdges: [.leading, .top]),
            .init(blockedEdges: [.top, .bottom], foodItem: .included6),
            .init(blockedEdges: [.top, .bottom]),
            .init(blockedEdges: [.top, .bottom]),
            .init(blockedEdges: [.trailing, .bottom]),
            .init(blockedEdges: [.leading, .trailing]),
            .init(blockedEdges: [.leading, .top, .bottom]),
            .init(blockedEdges: [.trailing, .bottom]),
            .init(blockedEdges: [.leading, .top]),
            .init(blockedEdges: [.top]),
            .init(blockedEdges: [.trailing]),
            .init(blockedEdges: [.leading, .top]),
            .init(blockedEdges: [.trailing, .top])
        ],
        [ // row 10,
            .init(blockedEdges: [.leading, .trailing]),
            .init(blockedEdges: [.leading, .top]),
            .init(blockedEdges: [.trailing, .top], foodItem: .excluded12),
            .init(blockedEdges: [.leading, .trailing]),
            .init(blockedEdges: [.leading, .bottom]),
            .init(blockedEdges: [.trailing, .top]),
            .init(blockedEdges: [.leading, .top]),
            .init(blockedEdges: [.top]),
            .init(blockedEdges: [.trailing, .top]),
            .init(blockedEdges: [.leading, .bottom]),
            .init(blockedEdges: [.trailing, .top], foodItem: .excluded13),
            .init(blockedEdges: [.leading, .top, .bottom]),
            .init(blockedEdges: [.trailing, .bottom]),
            .init(blockedEdges: [.leading, .trailing]),
            .init(blockedEdges: [.leading, .bottom]),
            .init(blockedEdges: [.trailing, .bottom]),
            .init(blockedEdges: [.leading, .trailing])
        ],
        [ // row 11
            .init(blockedEdges: [.leading, .bottom]),
            .init(blockedEdges: [.trailing, .bottom]),
            .init(blockedEdges: [.leading, .bottom]),
            .init(blockedEdges: [.trailing, .bottom]),
            .init(blockedEdges: [.leading, .top, .bottom]),
            .init(blockedEdges: [.bottom]),
            .init(blockedEdges: [.trailing, .bottom]),
            .init(blockedEdges: [.leading, .trailing, .bottom]),
            .init(blockedEdges: [.leading, .bottom]),
            .init(blockedEdges: [.top, .bottom]),
            .init(blockedEdges: [.bottom]),
            .init(blockedEdges: [.top, .bottom], foodItem: .included7),
            .init(blockedEdges: [.top, .bottom]),
            .init(blockedEdges: [.trailing, .bottom]),
            .init(blockedEdges: [.leading, .top, .bottom]),
            .init(blockedEdges: [.top, .bottom]),
            .init(blockedEdges: [.trailing, .bottom])
        ]
    ]
}
