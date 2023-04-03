//
//  Bookworm.swift
//  SwiftySwift
//
//  Created by Amit on 2023-04-01.
//

import SwiftUI

struct Bookworm: View {

    //@FetchRequest(sortDescriptors: []) var students: FetchedResults<Student>
    //@FetchRequest(sortDescriptors: []) var books: FetchedResults<Book>
    @FetchRequest(sortDescriptors: [
        SortDescriptor(\.title),
        SortDescriptor(\.author)
    ]) var books: FetchedResults<Book>


    @FetchRequest(sortDescriptors: []) var wizards: FetchedResults<Wizard>


//    @FetchRequest(sortDescriptors: [], predicate: NSPredicate(format: "universe == 'Star Wars'")) var ships: FetchedResults<Ship>

    @FetchRequest(sortDescriptors: [], predicate: NSPredicate(format: "universe == %@", "Star Wars")) var ships: FetchedResults<Ship>

    @FetchRequest(sortDescriptors: []) var countries: FetchedResults<Country>

    @Environment(\.managedObjectContext) var moc

    @State private var showingAddScreen = false

    @State  private var lastNameFilter = "A"

    func deleteBooks(at offsets: IndexSet) {
        for offset in offsets {
            let book = books[offset]
            moc.delete(book)
        }

        if  moc.hasChanges {
            //try? moc.save()
        }
    }

    var body: some View {

        NavigationView {

            VStack {

                VStack {
                    List {
                        ForEach(countries, id: \.self) { country in
                            Section(country.unwrappedFullName) {
                                ForEach(country.candyArray, id: \.self) { candy in
                                    Text(candy.wrappedName)
                                }
                            }
                        }
                    }

                    Button("Add") {
                        let candy1 = Candy(context: moc)
                        candy1.name = "Mars"
                        candy1.origin = Country(context: moc)
                        candy1.origin?.shortName = "UK"
                        candy1.origin?.fullName = "United Kingdom"

                        let candy2 = Candy(context: moc)
                        candy2.name = "KitKat"
                        candy2.origin = Country(context: moc)
                        candy2.origin?.shortName = "UK"
                        candy2.origin?.fullName = "United Kingdom"

                        let candy3 = Candy(context: moc)
                        candy3.name = "Twix"
                        candy3.origin = Country(context: moc)
                        candy3.origin?.shortName = "UK"
                        candy3.origin?.fullName = "United Kingdom"

                        let candy4 = Candy(context: moc)
                        candy4.name = "Toblerone"
                        candy4.origin = Country(context: moc)
                        candy4.origin?.shortName = "CH"
                        candy4.origin?.fullName = "Switzerland"

                        try? moc.save()
                    }
                }


                VStack {
                    // list of matching singers
                    FilteredList(filter: lastNameFilter)

                    Button("Add Examples") {
                        let taylor = Singer(context: moc)
                        taylor.firstName = "Taylor"
                        taylor.lastName = "Swift"

                        let ed = Singer(context: moc)
                        ed.firstName = "Ed"
                        ed.lastName = "Sheeran"

                        let adele = Singer(context: moc)
                        adele.firstName = "Adele"
                        adele.lastName = "Adkins"

                        try? moc.save()
                    }

                    Button("Show A") {
                        lastNameFilter = "A"
                    }

                    Button("Show S") {
                        lastNameFilter = "S"
                    }
                }

                VStack {
                    List(ships, id: \.self) { ship in
                        Text(ship.name ?? "Unknown name")
                    }

                    Button("Add Examples") {
                        let ship1 = Ship(context: moc)
                        ship1.name = "Enterprise"
                        ship1.universe = "Star Trek"

                        let ship2 = Ship(context: moc)
                        ship2.name = "Defiant"
                        ship2.universe = "Star Trek"

                        let ship3 = Ship(context: moc)
                        ship3.name = "Millennium Falcon"
                        ship3.universe = "Star Wars"

                        let ship4 = Ship(context: moc)
                        ship4.name = "Executor"
                        ship4.universe = "Star Wars"

                        try? moc.save()
                    }
                }

                VStack {
                    List (wizards, id:\.self) { wizard in
                        Text(wizard.name ?? "Unknown")
                    }
                    Button ("Add") {
                        let wizard = Wizard(context: moc)
                        wizard.name = "Random name"
                    }

                    Button ("Save") {
                        do {
                            try moc.save()
                        } catch {
                            print ("CoreData error \(error.localizedDescription)")
                        }
                    }
                }

                List {
                    ForEach(books) { book in

                        NavigationLink {
                            //Text(book.title ?? "Unknown Title")
                            DetailView(book: book)

                        } label: {
                            HStack {
                                EmojiRatingView(rating: book.rating)
                                    .font(.largeTitle)

                                VStack (alignment: .leading) {

                                    Text(book.title ?? "Unknown Title")
                                        .font(.headline)
                                        .foregroundColor(book.rating == 1 ? .red : .primary)

                                    Text(book.author ?? "Unknown Author")
                                        .foregroundColor(.secondary)
                                }
                            }
                        }

                    }
                    .onDelete(perform: deleteBooks)
                }
                .navigationTitle("BookWorms")
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        EditButton()
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {

                        Button{
                            showingAddScreen.toggle()
                        } label: {
                            Label("Add Book", systemImage: "plus")
                        }
                    }

                }
            }


//            Text("Count : \(books.count)")
//                .navigationTitle("Bookworm")
//                .toolbar {
//                    ToolbarItem(placement: .navigationBarTrailing) {
//                        Button {
//                            showingAddScreen.toggle()
//                        } label: {
//                            Label("Add Book ", systemImage: "plus")
//                        }
//                    }
//                }
//                .sheet(isPresented: $showingAddScreen) {
//                    AddBookView()
//                }
        }

//        VStack {
//
//            Button("Add") {
//                let firstNames = ["Ginny", "Harry", "Hermione", "Luna", "Ron"]
//                let lastNames = ["Granger", "Lovegood", "Potter", "Weasley"]
//
//                let chosenFirstName = firstNames.randomElement()!
//                let chosenLastName = lastNames.randomElement()!
//
//                let student = Student(context: moc)
//                student.id = UUID()
//                student.name = "\(chosenFirstName) \(chosenLastName)"
//
//
//                if  moc.hasChanges {
//                      //try? moc.save()
//                }
//
//            }
//
//            List(students) { student in
//                Text(student.name ?? "Unknown")
//            }
//        }
    }
}

struct Bookworm_Previews: PreviewProvider {
    static var previews: some View {
        Bookworm()
    }
}
