//
//  ContentView.swift
//  InstaFilter
//
//  Created by saj panchal on 2021-08-03.
//

import SwiftUI

struct ContentView: View {
    @State var showingActionSheet = false
    @State var backgroundColor = Color.white
    var body: some View {
       Text("Hello World!")
        .frame(width: 300, height: 300)
        .background(backgroundColor)
        .onTapGesture {
            self.showingActionSheet = true
        }
        .actionSheet(isPresented: $showingActionSheet, content: {
            ActionSheet(title: Text("Change Background"), message: Text("Select a new Color"), buttons: [.default(Text("Red"), action: {self.backgroundColor = .red}), .default(Text("Green"), action: {self.backgroundColor = .green}), .default(Text("Blue"), action: {self.backgroundColor = .blue}), .cancel()])
        })
     
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
