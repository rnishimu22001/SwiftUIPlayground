//
//  ZStackPlaygroundView.swift
//  SwiftUIPlayground
//
//  Created by rnishimu on 2020/08/16.
//  Copyright © 2020 rnishimu22001. All rights reserved.
//

import SwiftUI

struct ZStackPlaygroundView: View {
    var body: some View {
        ZStack(alignment: .top) {
            GeometryReader { geometory in
                HStack {
                    ForEach (0..<2) { _ in
                        Cell()
                    }
                }
                HStack {
                    Spacer()
                    Text("Label").colorInvert()
                    Spacer()
                }
                .frame(width: geometory.size.width * 0.75)
                .background(Color.red)
                .padding(.top, 250)
            }
        }
    }
}

struct ZStackPlaygroundView_Previews: PreviewProvider {
    static var previews: some View {
        ZStackPlaygroundView()
    }
}
