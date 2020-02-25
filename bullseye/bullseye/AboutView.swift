//
//   AboutView.swift
//  bullseye
//
//  Created by Kilyan SOCKALINGUM on 25/02/2020.
//  Copyright © 2020 Kilyan SOCKALINGUM. All rights reserved.
//

import SwiftUI

let vstackBgColor = Color(red: 255.0/255.0, green: 214.0/255.0, blue: 179.0/255.0)

struct blackText: ViewModifier {
    func body(content: Content) -> some View {
        return content.foregroundColor(Color.black)
    }
}

struct headerText: ViewModifier {
    func body(content: Content) -> some View {
        return content
            .modifier(blackText())
            .font(Font.custom("Arial Rounded MT Bold", size: 30))
            .padding(.vertical, 20)
    }
}

struct descriptionText: ViewModifier {
    func body(content: Content) -> some View {
        return content
            .modifier(blackText())
            .font(Font.custom("Arial Rounded MT Bold", size: 16))
            .padding(.horizontal, 60)
            .padding(.bottom, 20)
            .multilineTextAlignment(.center)
    }
}

struct AboutView: View {
    var body: some View {
        Group {
            VStack {
                Text("Bullseye").modifier(headerText())
                Text("This is Bullseye, the game where you can win points and earn fame by dragging a slider.").modifier(descriptionText())
                Text("Your goal is to place the slider as close as possible to the target value. The closer you are the more points you score.").modifier(descriptionText())
                Text("Enjoy !").modifier(descriptionText())
            }
            .navigationBarTitle("About Bullseye")
            .background(vstackBgColor)
        }
        .background(Image("Background"))
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView().previewLayout(.fixed(width: 896, height: 414))
    }
}
