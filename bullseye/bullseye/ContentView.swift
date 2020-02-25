//
//  ContentView.swift
//  bullseye
//
//  Created by Kilyan SOCKALINGUM on 12/02/2020.
//  Copyright © 2020 Kilyan SOCKALINGUM. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var alertIsVisible = false
    @State var sliderValue = 50.0
    @State var targetValue = Int.random(in: 1...100)
    @State var userScore = 0
    
    var body: some View {
        VStack {
            Spacer()
            //Target row
            HStack {
                Text("Put the bullseye as close as you can to:")
                Text("\(targetValue)")
            }
            
            Spacer()
            //Slider row
            HStack {
                Text("1")
                Slider(value: $sliderValue, in: 1...100)
                Text("100")
            }
            
            Spacer()
            //Button row
            Button(action: {
                print("Button was pressed")
                self.alertIsVisible = true
                
                let intSliderValue = self.roundedSliderValue()
                self.userScore += self.pointsForCurrentRound(sliderValue: intSliderValue)
            }) {
                Text("Hit me")
            }
            .alert(isPresented: $alertIsVisible) { () -> Alert in
                let intSliderValue = roundedSliderValue()
                let score = pointsForCurrentRound(sliderValue: intSliderValue)
                return Alert(title: Text("Hello there"), message: Text("The slider's value is \(intSliderValue).\nYou scored \(score) points this round."), dismissButton: .default(Text("Awesome")))
            }
            
            Spacer()
            //Score row
            HStack {
                Button(action: {}) {
                    Text("Start over")
                }
                Spacer()
                Text("Score:")
                Text("\(userScore)")
                Spacer()
                Text("Round:")
                Text("999")
                Spacer()
                Button(action: {}) {
                    Text("Info")
                }
            }
            .padding(.bottom, 20)
            
        }
    }
    
    func roundedSliderValue() -> Int {
        return Int(self.sliderValue.rounded())
    }
    
    func pointsForCurrentRound(sliderValue: Int) -> Int {
        let diff = sliderValue - targetValue
        let points = 100 - abs(diff)
        return points
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewLayout(.fixed(width: 896, height: 414))
    }
}
