//
//  ContentView.swift
//  Experience
//
//  Created by Adrien Surugue on 11/08/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var tabPageProperties: [TabPageModel: TabPageProperties] = [.page1: TabPageProperties(),
                                                                               .page2: TabPageProperties(),
                                                                               .page3: TabPageProperties()]
    @State private var offset : CGFloat = 0.0
    @State private var lastOffset: CGFloat = 0.0
    @State private var currentTab: TabPageModel = .page2
    @State private var smileysProperties: SmileyModel = SmileyModel(width: 100.0,
                                                                    height: 50.0,
                                                                    eyesDegrees: -20.0,
                                                                    smileDegrees: 0.0)
    
    var body: some View {
        NavigationView{
            ZStack{
                currentTab.color
                    .opacity(0.8)
                    .ignoresSafeArea()
                GeometryReader { geo in
                    VStack(alignment: .center){
                        HStack{
                            Spacer()
                            Text("How was your shopping experience?")
                                .font(.title2)
                                .multilineTextAlignment(.center)
                                .bold()
                            Spacer()
                        }
                        .padding()
                        Spacer()
                        Smiley()
                        Spacer()
                        TextContent(size: geo.size)
                        Spacer()
                        VStack{
                            HStack(spacing:0){
                                Spacer()
                                ForEach(TabPageModel.allCases, id: \.rawValue){tab in
                                    HStack(spacing:0){
                                        Circle()
                                            .frame(width: 20, height: 20, alignment: .center)
                                            .foregroundColor(.gray.opacity(0.6))
                                            .onTapGesture {
                                                withAnimation(){
                                                    
                                                    currentTab = tab
                                                    
                                                    switch tab {
                                                    case .page1:
                                                        offset = ((-geo.size.width/2) + (tabPageProperties[tab]!.circleMidX))
                                                        smileysProperties = SmileyModel(width: 90.0, height: 30.0, eyesDegrees: -20.0, smileDegrees: 0.0)
                                                        
                                                    case .page2:
                                                        offset = 0
                                                        smileysProperties = SmileyModel(width: 100.0, height: 50.0, eyesDegrees: 0, smileDegrees: 0.0)
                                                        
                                                    case .page3:
                                                        offset = (-(geo.size.width/2) + (tabPageProperties[tab]!.circleMidX))
                                                        smileysProperties = SmileyModel(width: 150, height: 150, eyesDegrees: 0.0, smileDegrees: 180.0)
                                                    }
                                                    lastOffset = offset
                                                }
                                            }
                                            .overlay(
                                                GeometryReader{ proxy in
                                                    Color.clear
                                                        .onAppear(){
                                                            tabPageProperties[tab]?.circleMidX = proxy.frame(in: .global).midX
                                                            tabPageProperties[tab]?.circleWidth = proxy.frame(in: .global).width
                                                        }
                                                })
                                        if tab.index != 2 {
                                            Rectangle()
                                                .frame(height: 7)
                                                .foregroundColor(.gray.opacity(0.6))
                                                .overlay(
                                                    GeometryReader{ proxy in
                                                        Color.clear
                                                            .onAppear(){
                                                                tabPageProperties[tab]?.rectMidX = proxy.frame(in: .global).midX
                                                            }
                                                    })
                                        }
                                    }
                                }
                                Spacer()
                            }
                            .padding()
                            .overlay {
                                ZStack{
                                    Capsule()
                                        .frame(width: 40, height: 40, alignment: .center)
                                        .foregroundColor(.black.opacity(1))
                                    Capsule()
                                        .frame(width: 40, height: 40, alignment: .center)
                                        .foregroundColor(.white.opacity(0.3))
                                        .shadow(color: .black.opacity(0.4), radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/, x: 1, y: 1)
                                    
                                }
                                .offset(x: offset)
                                .gesture(
                                    DragGesture()
                                        .onChanged { gesture in
                                            
                                            offset = gesture.translation.width + lastOffset
                                            
                                            // Limite de l'offset
                                            let minOffset = ((-geo.size.width/2) + (tabPageProperties[.page1]!.circleMidX))
                                            let maxOffset = (-(geo.size.width/2) + (tabPageProperties[.page3]!.circleMidX))
                                            
                                            // Limitation de l'offset entre minOffset et maxOffset
                                            offset = min(max(offset, minOffset), maxOffset)
                                            
                                            withAnimation(.easeInOut){
                                                if offset <= (((-geo.size.width/2) + (tabPageProperties[TabPageModel.page1]!.circleMidX))/2){
                                                    
                                                    currentTab = .page1
                                                    smileysProperties = SmileyModel(width: 90.0, height: 30.0, eyesDegrees: -20.0, smileDegrees: 0.0)
                                                    
                                                } else if offset >= (((-geo.size.width/2) + (tabPageProperties[.page1]!.circleMidX))/2) && offset <= 0 {
                                                    
                                                    currentTab = .page2
                                                    smileysProperties = SmileyModel(width: 100.0, height: 50.0, eyesDegrees: 0, smileDegrees: 0.0)
                                                    
                                                    
                                                }else if offset >= 0 && offset <= ((-(geo.size.width/2) + (tabPageProperties[.page3]!.circleMidX))/2){
                                                    
                                                    currentTab = .page2
                                                    smileysProperties = SmileyModel(width: 100.0, height: 50.0, eyesDegrees: 0, smileDegrees: 0.0)
                                                    
                                                } else {
                                                    currentTab = .page3
                                                    smileysProperties = SmileyModel(width: 150, height: 150, eyesDegrees: 0.0, smileDegrees: 180.0)
                                                }
                                            }
                                        }
                                        .onEnded { ended in
                                            
                                            withAnimation(.easeOut){
                                                if offset <= (((-geo.size.width/2) + (tabPageProperties[TabPageModel.page1]!.circleMidX))/2){
                                                    offset = ((-geo.size.width/2) + (tabPageProperties[.page1]!.circleMidX))
                                                    
                                                } else if offset >= (((-geo.size.width/2) + (tabPageProperties[.page1]!.circleMidX))/2) && offset <= 0 {
                                                    offset = 0
                                                    
                                                }else if offset >= 0 && offset <= ((-(geo.size.width/2) + (tabPageProperties[.page3]!.circleMidX))/2){
                                                    offset = 0
                                                    
                                                } else {
                                                    offset = (-(geo.size.width/2) + (tabPageProperties[.page3]!.circleMidX))
                                                }
                                            }
                                            lastOffset = offset
                                        })
                            }
                        }
                    }
                }
            }
            .toolbarBackground(.hidden, for: .navigationBar)
            .navigationBarItems(leading: Button(action: {
                print("close")
            }, label: {
                ZStack {
                    Circle()
                        .frame(width: 45, height: 45)
                        .foregroundColor(Color.gray.opacity(0.3))
                        .cornerRadius(10)
                    
                    Image(systemName: "xmark")
                        .foregroundColor(.black.opacity(0.5))
                        .bold()
                    
                }
            }), trailing: Button(action: {
                print("help")
            }, label: {
                ZStack {
                    Circle()
                        .frame(width: 45, height: 45)
                        .foregroundColor(Color.gray.opacity(0.3))
                        .cornerRadius(10)
                    
                    Image(systemName: "questionmark.circle")
                        .foregroundColor(.black.opacity(0.5))
                        .bold()
                }
            }))
        }
    }
    
    @ViewBuilder
    func Smiley()-> some View {
        VStack(spacing: smileysProperties.smileDegrees == 0 ? 50 : -50){
            HStack(spacing: 20){
                Capsule()
                    .frame(width: smileysProperties.width, height: smileysProperties.height)
                    .foregroundColor(.black.opacity(0.7))
                    .rotationEffect(.init(degrees: -(currentTab.index == 0 ? smileysProperties.eyesDegrees : 0.0)))
                Capsule()
                    .frame(width: smileysProperties.width, height: smileysProperties.height)
                    .foregroundColor(.black.opacity(0.7))
                    .rotationEffect(.init(degrees: ((currentTab.index == 0 ? smileysProperties.eyesDegrees : 0.0))))
            }
            Circle()
                .trim(from:0.65, to: 0.85)
                .stroke(Color.black.opacity(0.7), style: StrokeStyle(lineWidth: 20, lineCap: .round))
                .rotationEffect(.init(degrees: smileysProperties.smileDegrees))
        }
        .frame(width: 200, height: 200, alignment: .center)
    }
    
    @ViewBuilder
    func TextContent(size: CGSize) -> some View {
        VStack(spacing: 8){
            HStack(alignment: .top, spacing: 0){
                ForEach(TabPageModel.allCases, id: \.rawValue){page in
                    Text(page.title)
                        .font(Font.custom("PaytoneOne-Regular", size: 60))
                        .lineLimit(1)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .frame(width: size.width)
                        .opacity(0.3)
                }
            }
            .offset(x: CGFloat(-currentTab.index) * size.width)
            .animation(.interactiveSpring(response: 0.5, dampingFraction: 0.7, blendDuration: 0.7), value: currentTab)
        }
        .padding(.top, 15)
        .frame(width: size.width, alignment: .leading)
    }
}

#Preview {
    ContentView()
}
