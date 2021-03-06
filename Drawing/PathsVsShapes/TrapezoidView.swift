//
//  TrapezoidView.swift
//  PathsVsShapes
//
//  Created by Dmitry on 13.06.2021.
//

import SwiftUI

struct Trapezoid: Shape {
    var insetAmount: CGFloat
    
    var animatableData:  CGFloat {
        get { insetAmount }
        set { self.insetAmount = newValue}
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX - insetAmount, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX + insetAmount, y: rect.minY))
        return path
    }
}

struct TrapezoidView: View {
    @State private var insetAmount: CGFloat = 50
    private var trapezoidRect = CGRect(origin: CGPoint(x: 10, y: 20), size: CGSize(width: 40, height: 40))
    
    var body: some View {
        VStack{
            
            Trapezoid(insetAmount: insetAmount)
                .frame(width: 200, height: 100, alignment: .center)
                .onTapGesture {
                    withAnimation{
                        self.insetAmount = CGFloat.random(in: 20...70)
                    }
            }
            
        }
    }
}
struct TrapezoidView_Previews: PreviewProvider {
    static var previews: some View {
        TrapezoidView()
    }
}
