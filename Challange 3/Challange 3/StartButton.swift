//
//  StartButton.swift
//  Challange 3
//
//  Created by Dmitry on 03.06.2021.
//

import SwiftUI

struct StartButton: View {
    let text: String
    let action: () -> Void
    
    var body: some View {
        Button(text, action: action)
            .font(.system(size: 30))
            .foregroundColor(.blue)
            .frame(width: 150, height: 50)
            .background(Color.yellow)
            .clipShape(RoundedRectangle(cornerRadius: 30))
    }
}

struct TextOfNumber_Previews: PreviewProvider {
    static var previews: some View {
        StartButton(text: "Start", action: {})
    }
}
