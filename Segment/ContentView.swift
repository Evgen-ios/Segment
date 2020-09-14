//
//  ContentView.swift
//  Segment
//
//  Created by Goncharov Evgenii on 14.09.2020.
//  Copyright © 2020 Gancha. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var segmentedindex = 0
    @State var offsetX = 0
    var company = ["Asics","Columbia","Salomon"]
    var sneakers = ["asics","columbia","salomon"]
    var price = ["129.00 $", "99.00 $", "115.00 $"]
    
    var body: some View {
        VStack {
            Text("Sneakers - \(company[segmentedindex])")
                .font(.largeTitle).frame(height: 100)
            Spacer()
            ZStack{
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.white)
                    .offset(x: CGFloat(offsetX))
                Image(sneakers[segmentedindex])
                    .resizable()
                    .frame(width: 300, height: 300)
                    .offset(x: CGFloat(offsetX))
            }
            .animation(.spring(response: 0.2, dampingFraction: 0.5, blendDuration: 0.3))
            
            Picker(selection: Binding(get: {
                self.segmentedindex
            }, set: { newValue in
                if (self.segmentedindex > newValue) {
                    self.offsetX = -500
                } else {
                    self.offsetX = 500
                }
                self.segmentedindex = newValue
                self.moveBack()
                
            }), label:
            Text("")) {
                ForEach(0..<company.count) {
                    Text(self.company[$0]).tag($0)
                }
            }.pickerStyle(SegmentedPickerStyle()).padding()
            HStack{
                Text("Price: \(price[segmentedindex])")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding()
                    .foregroundColor(.red)
                
            }
            
            Spacer().frame(height: 250)
        }
    }
    
    private func moveBack() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.offsetX = 0
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
