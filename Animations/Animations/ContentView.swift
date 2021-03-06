//
//  ContentView.swift
//  Animations
//
//  Created by Dmitry on 02.06.2021.
//

import SwiftUI

struct CornerRotateModifier: ViewModifier {
    let amount: Double
    let anchor: UnitPoint
    
    func body(content: Content) -> some View {
        content.rotationEffect(.degrees(amount), anchor: anchor)
            .clipped()
    }
}

extension AnyTransition{
    static var pivot: AnyTransition{
        .modifier(
            active: CornerRotateModifier(amount: -90, anchor: .topTrailing),
            identity: CornerRotateModifier(amount: 0, anchor: .topTrailing))
    }
}

struct ContentView: View {
    @State private var isShowingNose = true
    @State private var animationAmount = 0.0
    var body: some View {
        VStack{
            Button("Corner Rotate") {
                withAnimation{
                    self.animationAmount += 360
                    
                    self.isShowingNose.toggle()
                }
            } .rotation3DEffect(.degrees(animationAmount), axis: (x:0, y:1, z:0))
            
            
            if isShowingNose {
                Rectangle()
                    .fill(Color.pink)
                    .frame(width: 200, height: 200)
                    .transition(.pivot)

            }
            
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
