//
//  ProspectsView.swift
//  SwiftySwift
//
//  Created by Amit on 2023-04-06.
//

import SwiftUI
import CodeScanner

struct ProspectsView: View {

    enum FilterType {
        case none, contacted, uncontacted
    }

    let filter:FilterType
    @EnvironmentObject var prospects: Prospects
    @State private var isShowingScanner = false

    var body: some View {

        NavigationView {

            List {
                ForEach(filteredProspects) { prospect in
                    VStack(alignment: .leading) {
                        Text(prospect.name)
                            .font(.headline)
                        Text(prospect.emailAddress)
                            .font(.title)
                    }
                    .swipeActions {
                        if prospect.isConctacted {
                            Button {
                                prospects.toggle(prospect)
                                //prospect.isConctacted.toggle()
                            } label: {
                                Label("Mark Uncontacted", systemImage: "person.crop.circle.badge.xmark")
                            }
                            .tint(.blue)
                        } else {
                            Button {
                                //prospect.isConctacted.toggle()
                                prospects.toggle(prospect)
                            } label: {
                                Label("Mark Contacted", systemImage: "person.crop.circle.fill.badge.checkmark")
                            }
                            .tint(.green)

                            Button {
                                addNotification(for: prospect)
                            } label: {
                                Label("Remind Me", systemImage: "bell")
                            }
                            .tint(.orange)
                        }
                    }
                }
            }
            .navigationTitle(title)
            .toolbar {
                Button{
                    isShowingScanner = true

//                    let prospect = Prospect()
//                    prospect.name = "Paul Hud"
//                    prospect.emailAddress = "hellopaul@hud.com"
//                    prospects.people.append(prospect)

                } label: {
                    Label("Scan", systemImage: "qrcode.viewfinder")
                }
            }
            .sheet(isPresented: $isShowingScanner) {

                CodeScannerView(codeTypes: [.qr], simulatedData: "Hello John\nHellojohn@email.com", completion: handleScan)
            }
        }
    }

    var title: String {
        switch filter {
        case .none:
            return "Everyone"
        case .contacted:
            return "Contacted People"
        case .uncontacted:
            return "Uncontacted People"

        }
    }

    var filteredProspects: [Prospect] {

        switch filter {
        case .none:
            return prospects.people
        case .contacted:
            return prospects.people.filter { $0.isConctacted }
        case .uncontacted:
            return prospects.people.filter { !$0.isConctacted }
        }
    }

    func handleScan(result: Swift.Result<ScanResult, ScanError>) {
        isShowingScanner = false

        switch result {
        case .success(let result):
            let details = result.string.components(separatedBy: "\n")
            guard details.count == 2 else { return }

            let person = Prospect()
            person.name = details[0]
            person.emailAddress = details[1]

            prospects.add(person)

        case .failure(let error):
            print("Scanning failed: \(error.localizedDescription)")
        }
    }

    func addNotification(for prospect: Prospect) {
        let center = UNUserNotificationCenter.current()

        let addRequest = {
            let content = UNMutableNotificationContent()
            content.title = "Contact \(prospect.name)"
            content.subtitle = prospect.emailAddress
            content.sound = UNNotificationSound.default

            var dateComponents = DateComponents()
            dateComponents.hour = 9
            //let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)

            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            center.add(request)
        }

        center.getNotificationSettings { settings in
            if settings.authorizationStatus == .authorized {
                addRequest()
            } else {
                center.requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        addRequest()
                    } else {
                        print("D'oh")
                    }
                }
            }
        }
    }
}

struct ProspectsView_Previews: PreviewProvider {
    static var previews: some View {
        ProspectsView(filter: .none)
    }
}
