//
//  ContentView.swift
//  bullseye
//
//  Created by Kilyan SOCKALINGUM on 12/02/2020.
//  Copyright © 2020 Kilyan SOCKALINGUM. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Hello, World!")
                .fontWeight(.semibold)
                .foregroundColor(Color.black)
                .multilineTextAlignment(.center)
            Button(action: {
                print("Button was pressed")
            }) {
                Text(/*@START_MENU_TOKEN@*/"Hit me"/*@END_MENU_TOKEN@*/)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
