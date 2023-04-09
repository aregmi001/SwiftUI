//
//  SampleUIView.swift
//  SwiftySwift
//
//  Created by Amit on 2023-04-08.
//

import SwiftUI

struct SampleUIView: View {
  @StateObject var viewModel = ViewModel()

  var body: some View {
    VStack {
      Image(systemName: "globe")
        .imageScale(.large)
        .foregroundColor(.accentColor)
      Text(viewModel.title)
        .font(.title)
    }
    .padding()
  }
}

extension SampleUIView {
  final class ViewModel: ObservableObject {
    @Published var style: Style = .hello

    var title: String {
      switch style {
      case .hello: return "Hello World!"
      case .welcome: return "Welcome World!"
      }
    }
  }

  enum Style {
    case hello, welcome
  }
}

struct SampleUIView_Previews: PreviewProvider {
    static var previews: some View {
        SampleUIView()
    }
}


