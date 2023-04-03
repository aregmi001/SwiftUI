//
//  DetailView.swift
//  SwiftySwift
//
//  Created by Amit on 2023-04-02.
//

import SwiftUI

struct DetailView: View {

    @Environment(\.dismiss) var dismissRR
    @Environment(\.managedObjectContext) var moc
    @State private var showingAddScreen = false

    let book:Book

    func deleteBook() {
        moc.delete(book)

        if moc.hasChanges {
            //try? moc.save()
        }
        dismissRR()
    }

    var body: some View {
        ScrollView {
            ZStack(alignment: .bottomTrailing) {
                Image(book.genre ?? "Fantasy")
                    .resizable()
                    .scaledToFit()

                Text(book.genre?.uppercased() ?? "FANTASY")
                    .font(.caption)
                    .fontWeight(.black)
                    .padding(6)
                    .foregroundColor(.white)
                    .background(.black.opacity(0.75))
                    .clipShape(Capsule())
            }

            Text(book.author ?? "Unknown Author")
                .font(.title)
                .foregroundColor(.secondary)

            Text(book.review ?? "No Review")
                .foregroundColor(.secondary)

            RatingView(rating: .constant(Int(book.rating)))
                .font(.largeTitle)
        }
        .navigationTitle(book.title ?? "Unknown Book")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Delete Book?", isPresented: $showingAddScreen) {
            Button("Delete", role: .destructive, action: deleteBook)
            Button("Cancel", role: .cancel) {

            }
        } message: {
            Text ("Sure are you ? ")
        }
        .toolbar {
            Button {
                showingAddScreen = true
            } label: {
                Label("Delete this book", systemImage: "trash")
            }
        }

    }
}

/* CoreData makes it difficult to easily do Preview as data access is complex */

//struct DetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailView()
//    }
//}
