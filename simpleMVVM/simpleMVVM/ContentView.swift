//
//  ContentView.swift
//  simpleMVVM
//
//  Created by raymondwang on 2022/3/21.
//

import SwiftUI



struct ContentView: View {
    var body: some View {
        
        Text("Hello, world!")
            .padding()

        if #available(iOS 15.0, *) {
            AsyncImage(url: URL(string: catUrl))
        } else {
            // Fallback on earlier versions
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
