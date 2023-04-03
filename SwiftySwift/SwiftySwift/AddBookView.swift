//
//  AddBookView.swift
//  SwiftySwift
//
//  Created by Amit on 2023-04-02.
//

import SwiftUI

struct AddBookView: View {

    @Environment(\.dismiss) var dismissRR
    @FetchRequest(sortDescriptors: []) var students: FetchedResults<Student>
    @Environment(\.managedObjectContext) var moc

    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre = ""
    @State private var review = ""

    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]


    var body: some View {

        NavigationView {
            Form {
                Section {
                    TextField("Name of Book", text: $title)
                    TextField("Author of Book", text: $author)

                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id: \.self) {
                            Text($0)
                        }
                    }
                }

                Section {
                    TextEditor(text: $review)

                    RatingView(rating: $rating)

//                    Picker("Rating", selection: $rating) {
//                        ForEach(0..<6) {
//                            Text("\($0)")
//                        }
//                    }
                } header: {
                    Text("Write a review")
                }

                Section {
                    Button("Save") {
                        let newBook = Book(context: moc)
                        newBook.id = UUID()
                        newBook.title = title
                        newBook.author = author
                        newBook.rating = Int16(rating)
                        newBook.genre = genre
                        newBook.review = review

                        if  moc.hasChanges {
                            try? moc.save()
                        }

                        dismissRR()
                    }
                }
            }
            .navigationTitle("Add Book")
        }
    }
}

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView()
    }
}
