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
    let range: Range<Int>
    let maxCount = 5
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

struct LabelRow: View {
    
    var rowDisplayData: LabelRowDisplayData
    
    var body: some View {
        GeometryReader { geometory in
            HStack {
                ForEach (self.rowDisplayData.labels) { data in
                    if data.shouldShow {
                        ColorLabel(displayData: data.colorLabel)
                            .frame(width: self.width(in: geometory, range: data.range, maxCount: data.maxCount), alignment: .leading)
                    } else {
                        Spacer()
                            .frame(width: self.width(in: geometory, range: data.range, maxCount: data.maxCount), alignment: .leading)
                    }
                }
            }
        }
    }
}

extension LabelRow {
    func width(in geometory: GeometryProxy, range: Range<Int>, maxCount: Int) -> CGFloat {
        return geometory.size.width / CGFloat(maxCount) * CGFloat(range.count)
    }
}

struct LabelGrid: View {
    
    var gridDisplayData: LabelGridDisplayData
    
    var body: some View {
        VStack {
            VStack (alignment: .center, spacing: 4) {
                ForEach (0..<gridDisplayData.rows.count) { index in
                    LabelRow(rowDisplayData: self.gridDisplayData.rows[index])
                }
            }
            Spacer()
        }
    }
}

struct ZStackPlaygroundView: View {
    
    var data: LabelGridDisplayData
    
    var body: some View {
        ZStack {
            HStack {
                ForEach (0..<5) { _ in
                    Cell()
                }
            }
            LabelGrid(gridDisplayData: data)
        }
    }
}


struct ZStackPlaygroundView_Previews: PreviewProvider {
    static var previews: some View {
        ZStackPlaygroundView(data: LabelGridDisplayData.sample)
    }
}
