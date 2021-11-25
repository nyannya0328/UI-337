//
//  ContentView.swift
//  Shared
//
//  Created by nyannyan0328 on 2021/10/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Home()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Home : View{
    
    @State var offset : CGSize = .zero
    
    @State var showHome = false
    
    var body: some View{
        
        ZStack{
            
            Color("BG")
                .overlay(
                    
                    
                    VStack(alignment: .leading, spacing: 15, content: {
                        
                        
                        Text("For Gamers")
                            .font(.largeTitle.weight(.heavy))
                        
                        Text("Lorerm ipsum,or lipsum as it is sometimes knows,is dummy text used in laying out print,graphic or webddesigs.")
                            .font(.caption.weight(.bold))
                          
                        
                    })
                        .foregroundColor(.white)
                        .padding(.horizontal,30)
                        .offset(x: -15)
                
                
                
                
                )
                .clipShape(CustomShape(offset: offset))
                .ignoresSafeArea()
                .overlay(
                
                Image(systemName: "chevron.left")
                    .font(.largeTitle)
                    .frame(width: 50, height: 50)
                    .contentShape(Rectangle())
                    .gesture(
                    
                        DragGesture().onChanged({ value in
                            withAnimation(.interactiveSpring(response: 0.7, dampingFraction: 0.6, blendDuration: 0.7)){
                                
                                offset = value.translation
                            }
                            
                        })
                            .onEnded({ value in
                                
                                
                                let screen = UIScreen.main.bounds
                                withAnimation(.spring()){
                                    
                                    if -offset.width > screen.width / 2{
                                        
                                        offset.width = -screen.height//to up
                                        
                                        showHome.toggle()
                                    }
                                    else{
                                        
                                        offset = .zero
                                    }
                                }
                                
                                
                            })
                    
                    )
                    .offset(x : 15,y: 55)
                    .opacity(offset == .zero ? 1 : 0)
                
                ,alignment: .topTrailing
                )
               
                .padding(.trailing)
            
            if showHome{
                
                Text("Welcome")
                    .font(.largeTitle.weight(.heavy))
                    .foregroundColor(.red)
                    .onTapGesture {
                        
                        withAnimation(.spring()){
                            
                            showHome.toggle()
                            offset = .zero
                        }
                    }
            }
        }
    }
}

struct CustomShape : Shape{
    
    var offset : CGSize
    
    var animatableData: CGSize.AnimatableData{
        
        get{return offset.animatableData}
        set{offset.animatableData = newValue}
    }
    func path(in rect: CGRect) -> Path {
        return Path {path in
            
            let width = rect.width + (-offset.width > 0 ? offset.width : 0)//move
            //正方形
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: rect.width, y: 0))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: 0, y: rect.height))
            
            let from = 80 + (offset.width)
            path.move(to: CGPoint(x: rect.width, y: from > 80 ? 80 : from))
            
            var to = 180 + (offset.height) + (-offset.width)
            
            to = to < 180 ? 180 : to
           
            let mid : CGFloat = 80 + ((to - 80) / 2)
            
             //to -> どこに行く y->vertical //
            path.addCurve(to: CGPoint(x: rect.width, y: to), control1: CGPoint(x: width - 50, y: mid), control2: CGPoint(x: width - 50, y: mid))
            
        }
    }
}
