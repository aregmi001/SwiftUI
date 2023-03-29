//
//  GuessTheFlag.swift
//  SwiftySwift
//
//  Created by Amit on 2023-03-28.
//

import SwiftUI

struct FlagImage: ViewModifier {
    var countryName: String
    var countryImageName: String

    func body(content: Content) -> some View {
        ZStack(alignment: .bottomTrailing) {

            content

            Image(countryImageName)
                .renderingMode(.original)
                .shadow(radius: 12)
                .clipShape(RoundedRectangle(cornerRadius: 10))

            Text(countryName)
                .font(.caption)
                .foregroundColor(.white)
                .padding(15)
                .background(.black)
        }
    }
}

struct GuessTheFlag: View {

    @State private var showResetDialog = false
    @State private var iterationCounter = 0

    @State private var showingScore = false
    @State private var scoreValue = 0
    @State private var scoreTitle = ""

    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US" ].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)

    var body: some View {

        ZStack {
            //Color.blue
            LinearGradient(gradient: Gradient(colors: [.black, .gray]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()

            VStack (spacing: 30) {
                Text("Tap the flag")
                    .foregroundColor(.white)
                Text(countries[correctAnswer])
                    .foregroundColor(.white)

                ForEach(0..<3) { number in
                    Button {
                        flagTapped(number)
                    } label: {

                        Image(countries[number])
                            .renderingMode(.original)
                            .shadow(radius: 12)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                    //.modifier(FlagImage(countryName: "", countryImageName: countries[number]))
                }

                Text("Score is \(scoreValue)")
                    .foregroundColor(.white)

            }
        }
        .alert(scoreTitle, isPresented: $showingScore){
            Button("Continue", action:askQuestion)

        } message: {
            Text("Your score is \(scoreValue)")
        }

        .alert("Game Reset", isPresented: $showResetDialog){
            Button("Continue", action:askQuestion)

        } message: {
            Text("Your score is \(scoreValue)")
        }
    }

    func flagTapped(_ number: Int) {

        iterationCounter += 1

        if  number == correctAnswer {
            scoreTitle = "Correct"
            scoreValue += 1
        } else {
            scoreTitle = "Wrong"
        }

        if  iterationCounter >= 8 {

            showResetDialog = true
            iterationCounter = 0
            scoreValue = 0

        } else {
            showingScore = true
        }
    }

    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }

    func resetGame() {
        scoreValue = 0
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct GuessTheFlag_Previews: PreviewProvider {
    static var previews: some View {
        GuessTheFlag()
    }
}
