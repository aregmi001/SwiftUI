//
//  WordScramble.swift
//  SwiftySwift
//
//  Created by Amit on 2023-03-29.
//

import SwiftUI

struct WordScramble: View {

    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""

    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showError = false


    var body: some View {
        NavigationView {
            List {
                Section {
                    TextField("Enter your word", text: $newWord)
                        .textInputAutocapitalization(.never)
                }

                Section {
//                    ForEach(usedWords, id: \.self) { word in
//                        Text(word)
//                    }

                    ForEach(usedWords, id: \.self) { word in
                        HStack {
                            Image(systemName: "\(word.count).circle")
                            Text(word)
                        }
                    }
                }
            }
            .navigationTitle(rootWord)
            .onSubmit(addNewWord)
            .onAppear(perform: startGame)
            .alert(errorTitle, isPresented: $showError) {
                Button("OK", role: .cancel, action: {
                })
            } message: {
                Text(errorMessage)
            }
            .toolbar {
                Button("Refresh", action: startGame)
            }
        }
    }

    func addNewWord() {
        // lowercase and trim the word, to make sure we don't add duplicate words with case differences
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)

        // exit if the remaining string is empty
        guard answer.count >= 3 else {
            wordError(title: "Size Error", message: "Minimum 3 chars required")
            return
        }

        guard isOriginal(word: answer) else {
            wordError(title: "Word used already", message: "be more original plz")
            return
        }

        guard isPossible(word: answer) else {
            wordError(title: "Word not possible", message: "You can't spell that world from \(rootWord)")
            return
        }

        guard isReal(word: answer) else {
            wordError(title: "Word not recognized", message: "You can't just make them up")
            return
        }

        withAnimation {
            usedWords.insert(answer, at: 0)
        }
        newWord = ""
    }

    func startGame() {
        if let fileURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: fileURL) {

                let allWords = startWords.components(separatedBy: "\n")
                rootWord = allWords.randomElement() ?? "randomtext"
                return
            }
        }

        /* If we are here , file not found */
        fatalError("Could not load start.txt from bundle");
    }

    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }

    func isPossible(word: String) -> Bool {
        var tempWord = rootWord
        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }
        return true
    }

    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")

        return misspelledRange.location == NSNotFound
    }

    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showError = true
    }
}

struct WordScramble_Previews: PreviewProvider {
    static var previews: some View {
        WordScramble()
    }
}
