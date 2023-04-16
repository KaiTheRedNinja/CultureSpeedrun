//
//  SwiftUIView.swift
//  
//
//  Created by Kai Quan Tay on 16/4/23.
//

import SwiftUI

struct TextImageView: View {
    let string: String
    let imageMaxHeight: CGFloat
    let textAlignment: HorizontalAlignment

    init(_ string: String,
         imageMaxHeight: CGFloat = .infinity,
         textAlignment: HorizontalAlignment = .center) {
        self.string = string
        self.imageMaxHeight = imageMaxHeight
        self.textAlignment = textAlignment
    }

    enum TextOrImage: Hashable, Identifiable {
        case text(String)
        case image(String, String?)

        var id: String {
            switch self {
            case .text(let str): return "text_\(str)"
            case .image(let str, let desc): return "image_\(str)_\(desc ?? "nil")"
            }
        }
    }

    var content: [TextOrImage] {
        let imageStarterIndexes = string.indicesOf(string: "<image>")
        let imageEnderIndexes = string.indicesOf(string: "</image>")
        guard imageStarterIndexes.count == imageEnderIndexes.count else { return [.text(string)] }

        var components: [TextOrImage] = []

        var everyOtherIndex = [0]
        for index in 0..<imageStarterIndexes.count {
            everyOtherIndex.append(imageStarterIndexes[index])
            everyOtherIndex.append(imageEnderIndexes[index])
        }
        everyOtherIndex.append(string.count)

        for group in 0..<(everyOtherIndex.count-1) {
            let startIndex = everyOtherIndex[group]
            let endIndex = everyOtherIndex[group+1]
            let groupStr = string[string.index(string.startIndex,
                                               offsetBy: startIndex) ..<
                                  string.index(string.startIndex,
                                               offsetBy: endIndex)]
            let groupFinal = String(groupStr)
                                .replacingOccurrences(of: "<image>", with: "")
                                .replacingOccurrences(of: "</image>", with: "")
            guard !groupFinal.replacingOccurrences(of: "\n", with: "").isEmpty else { continue }
            if group%2 == 0 {
                components.append(.text(groupFinal))
            } else {
                let parts = groupFinal.split(separator: "|")
                let name = parts[0]
                let description = parts.count > 1 ? String(parts.last!) : nil
                components.append(.image(String(name), description))
            }
        }

        return components
    }

    var body: some View {
        VStack(alignment: textAlignment) {
            ForEach(content) { item in
                switch item {
                case .text(let string):
                    Text(string)
                case .image(let name, let description):
                    GroupBox {
                        VStack(alignment: textAlignment) {
                            Image(name)
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: .infinity, maxHeight: imageMaxHeight)
                            if let description {
                                Text(description)
                                    .font(.caption)
                            }
                        }
                    }
                }
            }
        }
    }
}

extension String {
    func indicesOf(string: String) -> [Int] {
        var indices = [Int]()
        var searchStartIndex = self.startIndex

        while searchStartIndex < self.endIndex,
              let range = self.range(of: string, range: searchStartIndex..<self.endIndex),
              !range.isEmpty
        {
            let index = distance(from: self.startIndex, to: range.lowerBound)
            indices.append(index)
            searchStartIndex = range.upperBound
        }

        return indices
    }
}

struct TextImageView_Previews: PreviewProvider {
    static var previews: some View {
        List {
            TextImageView("""
<image>broccoli|A broccoli</image>
this is a test of the image stuff
<image>bamboo|A bamboo</image>
bye bye
<image>tofu</image>
""", imageMaxHeight: 400, textAlignment: .leading)
        }
    }
}
