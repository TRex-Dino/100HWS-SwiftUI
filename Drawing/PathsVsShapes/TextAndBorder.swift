//
//  TextAndBorder.swift
//  PathsVsShapes
//
//  Created by Dmitry on 12.06.2021.
//

import SwiftUI

struct TextAndBorder: View {
    var body: some View {
        Text("Hello, World!")
            .frame(width: 300, height: 300)
// First           .border(Color.red, width: 30)
// Second           .background(Image("newF"))
            .border(ImagePaint(image: Image("newF"),sourceRect: CGRect(x: 0, y: 0, width: 1, height: 0.5) ,scale: 0.2), width: 30)
    }
}

struct TextAndBorder_Previews: PreviewProvider {
    static var previews: some View {
        TextAndBorder()
    }
}
