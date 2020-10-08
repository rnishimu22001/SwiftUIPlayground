//
//  RemoveThreePointLeaderPlayground.swift
//  SwiftUIPlayground
//
//  Created by rnishimu on 2020/10/08.
//  Copyright © 2020 rnishimu22001. All rights reserved.
//

import SwiftUI

struct RemoveThreePointLeaderPlayground: View {
    let text = "Hello, World!"
    var body: some View {
        VStack(spacing: 50) {
            // 3点リーダーあり
            Text(text)
                .colorInvert()
                .frame(width: 50, height: 20, alignment: .top)
                .background(Color.red)
            // fixedSizeを指定してalignment指定なし
            Text(text)
                .fixedSize(horizontal: false, vertical: true)
                .colorInvert()
                .frame(width: 50, height: 20)
                .background(Color.blue)
            // fixedSizeを指定してalignment指定なし
            Text(text)
                .fixedSize(horizontal: false, vertical: true)
                .colorInvert()
                .frame(width: 50, height: 20, alignment: .top)
                .background(Color.green)
        }

    }
}

struct RemoveThreePointLeaderPlayground_Previews: PreviewProvider {
    static var previews: some View {
        RemoveThreePointLeaderPlayground()
    }
}
