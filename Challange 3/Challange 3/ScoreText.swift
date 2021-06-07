//
//  ScoreText.swift
//  Challange 3
//
//  Created by Dmitry on 03.06.2021.
//

import SwiftUI

struct CheckAnswer: View {
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text("Check")
                .font(.title2)
                .bold()
                .foregroundColor(.white)
        }
        .frame(width: 75, height: 75)
        .background(Color.blue)
        .cornerRadius(50)
    }
}

struct CheckAnswer_Previews: PreviewProvider {
    static var previews: some View {
        CheckAnswer(action: {})
    }
}

