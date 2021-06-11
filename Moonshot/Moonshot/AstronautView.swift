//
//  AstronautView.swift
//  Moonshot
//
//  Created by Dmitry on 10.06.2021.
//

import SwiftUI

struct AstronautView: View {
    let astronaut: Astronaut
    let missions: [Mission]
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack {
                    Image(astronaut.id)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width)
                    
                    Text(astronaut.description)
                        .padding()
                        .layoutPriority(1)
                    //может быть баг с показам всего содержимого текста в astronaut.description
                    // поэтому указываем приоритет в 1
                    Text("Missions:")
                        .multilineTextAlignment(.center)
                        .font(.title3)
                    List(missions) {
                        Text("Appolo \($0.id)")
                    }
                }
                
            }
        }
        .navigationBarTitle(Text(astronaut.name), displayMode: .inline)
    }
    
    init(missions: [Mission], astronaut: Astronaut) {
        self.astronaut = astronaut
        var mathces = [Mission]()
        
        for mission in missions {
            for member in mission.crew {
                if astronaut.id == member.name {
                    mathces.append(mission)
                }
            }
        }
        self.missions = mathces
    }
}

//struct AstronautView_Previews: PreviewProvider {
//    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
//    static var previews: some View {
//        AstronautView(astronaut: astronauts[0])
//    }
//}
