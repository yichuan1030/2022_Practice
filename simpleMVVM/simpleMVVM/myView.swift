//
//  myView.swift
//  simpleMVVM
//
//  Created by raymondwang on 2022/3/29.
//

import Foundation

import SwiftUI
import SafariServices


struct myView : View {
            
    var body: some View {
        
        GeometryReader { geo in
            
            VStack(alignment: .center, spacing: 0, content: {
                Text("MVVM in SwiftUI practice")
                    .font(.title)
                    .frame(width: geo.size.width, height: 50, alignment: .center)
                    .background(Color.yellow)
//                Text("This VStack height: \(Int(geo.safeAreaInsets.top))")
//                Text("This VStack height: \(Int(geo.safeAreaInsets.bottom))")
                myVC().frame(width: geo.size.width,
                               height: geo.size.height - 50,
                               alignment: .topLeading)
            }).background(Color.blue)
        
        }
    }
}

struct myVC : UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> myTableViewVC {
        return myTableViewVC()
    }
    
    func updateUIViewController(_ uiViewController: myTableViewVC, context: Context) {
        
    }
    
    typealias UIViewControllerType = myTableViewVC
        
    
}

struct myView_Previews: PreviewProvider {
    
    static var previews: some View {

        GeometryReader { geo in
            
            VStack(alignment: .center, spacing: 0, content: {
                Text("MVVM in SwiftUI practice")
                    .font(.title)
                    .frame(width: geo.size.width, height: 50, alignment: .center)
                    .background(Color.yellow)
//                Text("This VStack height: \(Int(geo.safeAreaInsets.top))")
//                Text("This VStack height: \(Int(geo.safeAreaInsets.bottom))")
                myVC().frame(width: geo.size.width,
                               height: geo.size.height - 50,
                               alignment: .topLeading)
            }).background(Color.blue)
            
            
        }
    }
}
