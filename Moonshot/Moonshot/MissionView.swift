//
//  MissionView.swift
//  Moonshot
//
//  Created by Dmitry on 10.06.2021.
//

import SwiftUI

struct MissionView: View {
    struct CrewMember {
        let role: String
        let astronaut: Astronaut
    }
    
    let mission: Mission
    let missions: [Mission]
    let astronauts: [CrewMember]
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: geometry.size.width * 0.7)
                        .padding(.top)
                    Text("Mission date: \(mission.formattedLaunchDate)")
                        .font(.title2)
                    
                    Text(mission.description)
                        .padding()
                    
                    ForEach(astronauts, id: \.role) { crewMember in
                        NavigationLink(destination: AstronautView(missions: missions,
                                                                  astronaut: crewMember.astronaut)) {
                            HStack {
                                Image(crewMember.astronaut.id)
                                    .resizable()
                                    .frame(width: 83, height: 60)
                                    .clipShape(Capsule())
                                    .overlay(Capsule().stroke(Color.primary,
                                                              lineWidth: 1))
                                
                                VStack(alignment: .leading) {
                                    Text(crewMember.astronaut.name)
                                        .font(.headline)
                                    Text(crewMember.role)
                                        .foregroundColor(.secondary)
                                }
                                
                                Spacer()
                            }
                            .padding(.horizontal)
                        }
                        .buttonStyle(PlainButtonStyle()) //Отображение навигационых кнопок как обычное представление
                    }
                    
                    Spacer(minLength: 25)
                }
            }
        }
        .navigationBarTitle(Text(mission.displayName), displayMode: .inline)
    }
    
    //даем инициализатор нашим свойствам
    //self.mission = mission
    //self.astronauts = mathces. Проверяем на совпадение имен в двух джейсонах
    //И добавляем добавляем в массив [CrewMember]()
    init(mission: Mission, astronauts: [Astronaut], missions: [Mission]) {
        self.mission = mission
        self.missions = missions
        var mathces = [CrewMember]()
        
        for member in mission.crew {
            if let match = astronauts.first(where: { $0.id == member.name}) {
                mathces.append(CrewMember(role: member.role, astronaut: match))
            } else {
                fatalError("Missing \(member)")
            }
        }
        self.astronauts = mathces
    }
}

//struct MIssionView_Previews: PreviewProvider {
//    static let misssions: [Mission] = Bundle.main.decode("missions.json")
//    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
//    static var previews: some View {
//        MissionView(mission: misssions[0], astronauts: astronauts)
//    }
//}
