//
//  ContentView.swift
//  InstaFilter
//
//  Created by saj panchal on 2021-08-03.
//

import SwiftUI

struct ContentView: View {
    @State var blurAmount: CGFloat = 0 {
        didSet {
            print("New value is \(blurAmount)")
        }
    }
    var body: some View {
        let blur = Binding<CGFloat>(get: {
            self.blurAmount
        }, set: {
            self.blurAmount = $0
            print("New value is \(self.blurAmount)")
        })
        return VStack {
            Text("Hello, world!\(blurAmount)")
                .blur(radius: blurAmount)
            Slider(value: blur, in: 0...20)
        }
     
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
