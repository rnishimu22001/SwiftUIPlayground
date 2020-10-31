//
//  TextByClipping.swift
//  SwiftUIPlayground
//
//  Created by rnishimu on 2020/10/31.
//  Copyright © 2020 rnishimu22001. All rights reserved.
//

import SwiftUI

struct ParentView: View {
    var body: some View {
        GeometryReader { reader in
            Text("Hello!! World")
                .lineLimit(1)
                .fixedSize(horizontal: true, vertical: false)
                .alignmentGuide(.leading, computeValue: { dimension in
                    // 親ViewとTextの横幅の差分をとる
                    let difference = reader.size.width - dimension.width
                    if difference > 0 {
                        // 親Viewの方が大きい場合
                        return -(difference / 2)
                    } else {
                        // Textの方が大きい場合
                        return 0
                    }
                })
                .frame(width: reader.size.width, alignment: .leading)
                .clipped()
        }
    }
}

struct TextByClipping_Previews: PreviewProvider {
    static var previews: some View {
        ParentView()
            .frame(width: 60, height: 20)
            .background(Color.red)
    }
}
