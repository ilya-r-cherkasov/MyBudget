//
//  SnapCarousel.swift
//  MyBudget
//
//  Created by Ilya Cherkasov on 18.06.2022.
//

import SwiftUI

struct SnapCarousel: View {
    
    let padding: CGFloat = 0
    let spacing: CGFloat = 50.0
    let size: CGSize = CGSize(width: 200, height: 300)
    
    @State var cards = (0...4).map { Card(id: $0) }
    @State var buffer: CGFloat = 0
    @State var offset: CGFloat = 0
    @State var currentIndex: Int = 0
    
    var body: some View {
        VStack {
            GeometryReader { proxy in
                HStack(spacing: spacing) {
                    ForEach(cards) { card in
                        GeometryReader { cardProxy in
                            Text(card.id.description)
                        }
                        .frame(width: size.width, height: size.height)
                        .padding(padding)
                    }
                    .background(.blue)
                }
                .offset(x: (proxy.size.width - size.width) / 2 - 2 * (size.width + spacing) + offset)
                .frame(maxHeight: .infinity)
                .gesture(
                    DragGesture()
                        .onChanged({ value in
                            offset = buffer + value.translation.width
                        })
                        .onEnded({ value in
                            onEnded(value)
                        })
                )
                .animation(.easeInOut, value: offset)
            }
        }
    }
    
    func onEnded(_ value: DragGesture.Value) {
        offset = 0
        if value.translation.width < 0 {
            let id = cards.last?.id ?? 0
            cards.append(Card(id: id + 1))
            cards.removeFirst()
        } else {
            let id = cards.first?.id ?? 0
            cards.insert(
                Card(id: id - 1),
                at: 0
            )
            cards.removeLast()
        }
    }
}

struct Card: Identifiable {
    
    let id: Int
    
}

struct SnapCarousel_Previews: PreviewProvider {
    static var previews: some View {
        SnapCarousel()
    }
}
