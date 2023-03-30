//
//  Animations.swift
//  SwiftySwift
//
//  Created by Amit on 2023-03-29.
//

import SwiftUI

struct CornerRotateModifier: ViewModifier {
    let amount: Double
    let anchor: UnitPoint

    func body(content: Content) -> some View {
        content
            .rotationEffect(.degrees(amount), anchor: anchor)
            .clipped()
    }
}

extension AnyTransition {
    static var pivot: AnyTransition {
        .modifier(
            active: CornerRotateModifier(amount: -90, anchor: .topLeading),
            identity: CornerRotateModifier(amount: 0, anchor: .topLeading)
        )
    }
}

struct Animations: View {
    @State private var isShowingRed = false

    let letters = Array("Hello SwiftUI")
    @State private var enabled = false
    @State private var dragAmount = CGSize.zero

    var body: some View {
        ZStack {

            HStack(spacing: 0) {
                ForEach(0..<letters.count, id: \.self) { num in
                    Text(String(letters[num]))
                        .padding(5)
                        .font(.title)
                        .background(enabled ? .blue : .red)
                        .offset(dragAmount)
                        .animation(.default.delay(Double(num) / 20), value: dragAmount)
                }
            }
            .gesture(
                DragGesture()
                    .onChanged { dragAmount = $0.translation }
                    .onEnded { _ in
                        dragAmount = .zero
                        enabled.toggle()
                    }
            )

            VStack (spacing: 30) {

                Button("Tap Me 1") {
                    enabled.toggle()
                }
                .frame(width: 200, height: 200)
                .background(enabled ? .blue : .red)
                .animation(nil, value: enabled)
                .foregroundColor(.white)
                .clipShape(RoundedRectangle(cornerRadius: enabled ? 60 : 0))
                .animation(.interpolatingSpring(stiffness: 10, damping: 1), value: enabled)


                Button("Tap Me 2") {
                    // do nothing
                }

//                Rectangle()
//                    .fill(.red)
//                    .frame(width: 200, height: 200)

                if isShowingRed {

                    VStack {
                        Rectangle()
                            .fill(.red)
                            .frame(width: 200, height: 200)
                            .transition(.pivot)

                        Rectangle()
                            .fill(.yellow)
                            .frame(width: 200, height: 200)
                            .transition(.scale)
                    }
                }
            }

//            Rectangle()
//                .fill(.blue)
//                .frame(width: 200, height: 200)
        }
        .onTapGesture {
            withAnimation {
                isShowingRed.toggle()
            }
        }
    }
}

struct Animations_Previews: PreviewProvider {
    static var previews: some View {
        Animations()
    }
}
