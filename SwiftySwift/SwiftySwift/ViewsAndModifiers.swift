//
//  ViewsAndModifiers.swift
//  SwiftySwift
//
//  Created by Amit on 2023-03-28.
//

import SwiftUI

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.white)
            .padding()
            .background(.blue)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

extension View {
    func titleStyle() -> some View {
        modifier(Title())
    }
}

struct Watermark: ViewModifier {
    var text: String

    func body(content: Content) -> some View {
        ZStack(alignment: .bottomTrailing) {
            content
            Text(text)
                .font(.caption)
                .foregroundColor(.white)
                .padding(5)
                .background(.black)
        }
    }
}

extension View {
    func watermarked(with text: String) -> some View {
        modifier(Watermark(text: text))
    }
}


struct CapsuleText: View {
    var text: String

    var body: some View {
        Text(text)
            .font(.largeTitle)
            .padding()
            .background(.blue)
            .clipShape(Capsule())
    }
}

struct ViewsAndModifiers: View {

    @ViewBuilder var header: some View {
        VStack {
            Text("Header View Items 1")
            Text("Items 2")
        }
    }

    @ViewBuilder var footer: some View {
        HStack {
            Text("Footer View Items 1")
                .font(.subheadline)  // overrides Environment Modifier
            Text("Items 2")
        }
        .font(.title)  // Environment modifier -- Applies to all the children
    }

    var body: some View {
        VStack {
            header
            VStack{
                Button ("Hi button") {
                    print ("button clicked ")
                }

                CapsuleText(text: "First")
                    .foregroundColor(.white)
                CapsuleText(text: "Second")
                    .foregroundColor(.yellow)

                Text("Hell00 World")
                    //.modifier(Title())
                    .titleStyle()

                Color.blue
                    .frame(width: 300, height: 200)
                    .watermarked(with: "Hacking with Swift")

            }
            footer
        }
    }
}

struct ViewsAndModifiers_Previews: PreviewProvider {
    static var previews: some View {
        ViewsAndModifiers()
    }
}

