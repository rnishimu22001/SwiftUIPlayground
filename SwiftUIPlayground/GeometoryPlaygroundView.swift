//
//  ZStackPlaygroundView.swift
//  SwiftUIPlayground
//
//  Created by rnishimu on 2020/08/15.
//  Copyright © 2020 rnishimu22001. All rights reserved.
//

import SwiftUI

struct Cell: View {
    var body: some View {
        VStack(alignment: .center) {
            Spacer()
            HStack(alignment: .center) {
                Spacer()
                Text("Cell")
                Spacer()
            }
            Spacer()
        }.border(Color.black)
    }
}

struct LabelGridDisplayData {
    static let numberOfCell = 5
    let rows: [LabelRowDisplayData]
    
    static var sample: LabelGridDisplayData {
        
        let row1 = LabelRowDisplayData(labels: [
            LabelDisplayData(range: 0..<2, colorLabel: ColorLabelDisplayData(color: .red), shouldShow: true),
            LabelDisplayData(range: 2..<4, colorLabel: ColorLabelDisplayData(color: .red), shouldShow: false),
            LabelDisplayData(range: 4..<numberOfCell, colorLabel: ColorLabelDisplayData(color: .blue), shouldShow: true)
        ])
        let row2 = LabelRowDisplayData(labels: [
            LabelDisplayData(range: 0..<1, colorLabel: ColorLabelDisplayData(color: .red), shouldShow: false),
            LabelDisplayData(range: 1..<4, colorLabel: ColorLabelDisplayData(color: .gray), shouldShow: true),
            LabelDisplayData(range: 4..<numberOfCell, colorLabel: ColorLabelDisplayData(color: .purple), shouldShow: true)
        ])
        let row3 = LabelRowDisplayData(labels: [
            LabelDisplayData(range: 0..<numberOfCell, colorLabel: ColorLabelDisplayData(color: .green), shouldShow: true)
        ])
        
        return LabelGridDisplayData(rows: [
            row1, row2, row3
        ])
    }
}

struct LabelRowDisplayData {
    let labels: [LabelDisplayData]
}

struct LabelDisplayData: Identifiable {
    let id = UUID()
    /// 塗り潰すセルの範囲
    let range: Range<Int>
    let colorLabel: ColorLabelDisplayData
    let shouldShow: Bool
}

struct ColorLabelDisplayData {
    let color: Color
    let text: String = "Label"
}

struct ColorLabel: View {
    
    var displayData: ColorLabelDisplayData
    
    var body: some View {
        HStack {
            Spacer()
            Text(displayData.text)
                .colorInvert()
            Spacer()
        }
        .background(displayData.color)
    }
}

/// ラベルの行を表示するView
struct LabelRow: View {
    
    var rowDisplayData: LabelRowDisplayData
    
    var body: some View {
        GeometryReader { geometory in
            HStack {
                ForEach (self.rowDisplayData.labels) { data in
                    // 表示する場合はColorLabel、表示させない場合はSpacerを入れる
                    if data.shouldShow {
                        ColorLabel(displayData: data.colorLabel)
                            .frame(width: self.width(in: geometory,
                                                     range: data.range,
                                                     maxCount: LabelGridDisplayData.numberOfCell),
                                   alignment: .leading)
                    } else {
                        Spacer()
                            .frame(width: self.width(in: geometory,
                                                     range: data.range,
                                                     maxCount: LabelGridDisplayData.numberOfCell),
                                   alignment: .leading)
                    }
                }
            }
        }
    }
}

extension LabelRow {
    
    /// Labelの横幅を計算する
    /// - Parameters:
    ///   - geometory: LabelRowのレイアウト情報を持っているGeomeotry
    ///   - range: Lableで塗りつぶしたいセルの範囲
    ///   - maxCount: LabelRowで表示できるセルの数
    /// - Returns: Labelに割り当てる横幅
    func width(in geometory: GeometryProxy, range: Range<Int>, maxCount: Int) -> CGFloat {
        return geometory.size.width / CGFloat(maxCount) * CGFloat(range.count)
    }
}

/// ラベルの行列を表示するView
struct LabelGrid: View {
    
    var gridDisplayData: LabelGridDisplayData
    
    var body: some View {
        // 行を積み上げて、行列にする
        VStack (alignment: .center, spacing: 4) {
            ForEach (0..<gridDisplayData.rows.count) { index in
                LabelRow(rowDisplayData: self.gridDisplayData.rows[index])
            }
        }
    }
}

struct GeometoryPlaygroundView: View {
    
    var data: LabelGridDisplayData
    
    var body: some View {
        ZStack {
            // Cellを配置する親ViewとLabelを貼り付ける親Viewを同一階層に配置する
            HStack {
                ForEach (0..<LabelGridDisplayData.numberOfCell) { _ in
                    Cell()
                }
            }
            LabelGrid(gridDisplayData: data)
        }
    }
}


struct GeometoryPlaygroundView_Previews: PreviewProvider {
    static var previews: some View {
        GeometoryPlaygroundView(data: LabelGridDisplayData.sample)
    }
}
