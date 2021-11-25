//
//  test.swift
//  UI-337 (iOS)
//
//  Created by nyannyan0328 on 2021/10/22.
//

import SwiftUI

struct test: View {
    var body: some View {
        Path{path in
            
            path.move(to: .zero)
            path.addCurve(to: CGPoint(x: 100, y:100), control1: CGPoint(x: 100, y: 0), control2: CGPoint(x: 0, y: 100))
        }
        .stroke()
    }
}

struct test_Previews: PreviewProvider {
    static var previews: some View {
        test()
    }
}
