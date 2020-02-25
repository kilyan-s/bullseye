//
//  ContentView.swift
//  bullseye
//
//  Created by Kilyan SOCKALINGUM on 12/02/2020.
//  Copyright © 2020 Kilyan SOCKALINGUM. All rights reserved.
//

import SwiftUI

struct textStyle: ViewModifier {
    func body(content: Content) -> some View {
        return content
            .foregroundColor(Color.white)
            .font(Font.custom("Arial Rounded MT Bold", size: 18))
            .modifier(shadowStyle())
    }
}

struct valueStyle: ViewModifier {
    func body(content: Content) -> some View {
        return content
            .foregroundColor(Color.yellow)
            .font(Font.custom("Arial Rounded MT Bold", size: 24))
            .modifier(shadowStyle())
    }
}

struct buttonLargeTextStyle: ViewModifier {
    func body(content: Content) -> some View {
        return content
            .foregroundColor(Color.black)
            .font(Font.custom("Arial Rounded MT Bold", size: 18))
    }
}

struct buttonSmallTextStyle: ViewModifier {
    func body(content: Content) -> some View {
        return content
            .foregroundColor(Color.black)
            .font(Font.custom("Arial Rounded MT Bold", size: 12))
    }
}

struct shadowStyle: ViewModifier {
    func body(content: Content) -> some View {
        return content
            .shadow(color: Color.black, radius: 5, x: 2, y: 2)
    }
}

struct ContentView: View {
    
    @State var alertIsVisible = false
    @State var sliderValue = 50.0
    @State var targetValue = Int.random(in: 1...100)
    @State var userScore = 0
    @State var currentRound = 1
    
    let blueColor = Color(red: 0.0/255.0, green: 51.0/255.0, blue: 102.0/255.0)
    
    var body: some View {
        VStack {
            Spacer()
            //Target row
            HStack {
                Text("Put the bullseye as close as you can to:").modifier(textStyle())
                
                Text("\(targetValue)").modifier(valueStyle())
            }
            
            Spacer()
            //Slider row
            HStack {
                Text("1").modifier(textStyle())
                Slider(value: $sliderValue, in: 1...100).accentColor(Color.green)
                Text("100").modifier(textStyle())
            }
            
            Spacer()
            //Button row
            Button(action: {
                print("Button was pressed")
                self.alertIsVisible = true
            }) {
                Text("Hit me")
            }
            .alert(isPresented: $alertIsVisible) { () -> Alert in
                let intSliderValue = roundedSliderValue()
                let score = pointsForCurrentRound()
                return Alert(title: Text(alertTitle()), message: Text("The slider's value is \(intSliderValue).\nYou scored \(score) points this round."), dismissButton: .default(Text("Awesome")) {
                        self.userScore += self.pointsForCurrentRound()
                        self.targetValue = Int.random(in: 1...100)
                        self.currentRound += 1
                    })
            }.background(Image("Button")).modifier(buttonLargeTextStyle()).modifier(shadowStyle())
            
            Spacer()
            //Score row
            HStack {
                Button(action: {
                    self.startOverAction()
                }) {
                    HStack {
                        Image("StartOverIcon")
                        Text("Start over")
                    }
            }.background(Image("Button")).modifier(shadowStyle()).modifier(buttonSmallTextStyle())
                
                Spacer()
                
                Text("Score:").modifier(textStyle())
                Text("\(userScore)").modifier(valueStyle())
                
                Spacer()
                
                Text("Round:").modifier(textStyle())
                Text("\(currentRound)").modifier(valueStyle())
                
                Spacer()
                
                Button(action: {}) {
                    HStack {
                        Image("InfoIcon")
                        Text("Info")
                    }
                }.background(Image("Button")).modifier(shadowStyle()).modifier(buttonSmallTextStyle())
            }
            .padding(.bottom, 20)
            
        }
        .background(Image("Background"), alignment: .center)
        .accentColor(blueColor)
    }
    
    func roundedSliderValue() -> Int {
        return Int(self.sliderValue.rounded())
    }
    
    func amountOff() -> Int {
        return abs(roundedSliderValue() - targetValue)
    }
    
    func pointsForCurrentRound() -> Int {
        let maxScore = 100
        let diff = amountOff()
        var bonus = 0
        
        if diff == 0 {
            bonus = 100
        } else if diff == 1 {
            bonus = 50
        }
        
        let points = maxScore - diff + bonus
        
        return points
    }
    
    func alertTitle() -> String {
        let diff = amountOff()
        let title: String
        if diff == 0 {
            title = "Perfect"
        } else if diff <= 5 {
            title = "You almost had it"
        } else if diff <= 10 {
            title = "Not bad"
        } else {
            title = "Are you even trying ?"
        }
        return title
    }
    
    func startOverAction() {
        sliderValue = 50.0
        targetValue = Int.random(in: 1...100)
        userScore = 0
        currentRound = 1
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewLayout(.fixed(width: 896, height: 414))
    }
}
