//
//  CurrentQueue.swift
//  split-bills
//
//  Created by wimba prasiddha on 09/08/20.
//  Copyright © 2020 wimba prasiddha. All rights reserved.
//

import SwiftUI

struct CurrentQueue: View {
    let image = "Register"
    var body: some View {
      
       
        VStack {
        Image(image)
            .padding(.top, 100)
            
        listQueue()
        
        }
    }
}


struct listQueue: View {
    var queueName = "Samantha"
    var nextQueue = "Muhammad Rasyad"
    var body: some View {
        ZStack(){
            VStack{
                HStack{
                    Text("Antrian Saat Ini")
                        .padding(20)
                    Spacer()
                    Button(action: {}) {
                        Text("Lihat Semua")
                    }
                .padding(20)
    
                }
                .padding(.top,25)
              
                
                Text(queueName)
                .font(.title)
                .bold()
                .frame(width: 350, height: 60)
                .foregroundColor(Color.init(#colorLiteral(red: 0.3294117647, green: 0.737254902, blue: 0.4941176471, alpha: 1)))
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.init(#colorLiteral(red: 0.3294117647, green: 0.737254902, blue: 0.4941176471, alpha: 1)), lineWidth: 2)
                )
                    .padding(.top, 20)
                
                Text("Antrian Selanjutnya")
                    .foregroundColor(Color.init(#colorLiteral(red: 0.4274509804, green: 0.4470588235, blue: 0.4705882353, alpha: 0.6523972603)))
                    .padding(.top, 30)
                
                Text(nextQueue)
                    .font(.title)
                    .foregroundColor(Color.init(#colorLiteral(red: 0.3215686275, green: 0.3411764706, blue: 0.3607843137, alpha: 0.7549497003)))
                    .padding()
                    
                Button(action: {}) {
                    Text("Check In")
                    .foregroundColor(.white)
                        .frame(width: 330, height: 25)
                        .padding()
                        .background(Color.init(#colorLiteral(red: 0.06666666667, green: 0.3019607843, blue: 0.5882352941, alpha: 1)))
                        .cornerRadius(15)
                        .shadow(color: Color.init(#colorLiteral(red: 0.8, green: 0.8392156863, blue: 0.9254901961, alpha: 1)), radius: 8, x: 0, y: 6)
                }
                .padding(.top,60)
                
                Button(action: {}) {
                    Text("Skip")
                        .foregroundColor(Color.init(#colorLiteral(red: 0.8784313725, green: 0.1254901961, blue: 0.1254901961, alpha: 1)))
                    .frame(width: 100, height: 30)
                    }
                .padding(.top,30)
                
                Spacer()
            }
            
        }
        .edgesIgnoringSafeArea(.bottom)
        .background(Color.init(.white))
        .clipShape(rounded())
    .shadow(color: Color.init(#colorLiteral(red: 0.8, green: 0.8392156863, blue: 0.9254901961, alpha: 0.2607662671)), radius: 8, x: 0, y: -6)
    }
}

struct rounded: Shape {
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: 40, height: 40))
        return Path(path.cgPath)
    }
    
    }

struct CurrentQueue_Previews: PreviewProvider {
    static var previews: some View {
        CurrentQueue()
    }
}
