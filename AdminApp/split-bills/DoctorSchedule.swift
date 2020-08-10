//
//  DoctorSchedule.swift
//  split-bills
//
//  Created by wimba prasiddha on 26/07/20.
//  Copyright © 2020 wimba prasiddha. All rights reserved.
//

import SwiftUI

struct DoctorSchedule: View {
    var body: some View {
        ZStack {
            Color(#colorLiteral(red: 0.8, green: 0.8392156863, blue: 0.9254901961, alpha: 0.1621628853))
            .edgesIgnoringSafeArea(.vertical)
            ScrollView(.vertical, showsIndicators: false) {
            VStack{
                ForEach(0..<25,id: \.self){ _ in
            listDoctor(imageDoctor: "person", nameDoctor: "Dr. Ahmad", currentQueue: "20", schedule: "")
            }
            }
        }
        }
    }
}

struct listDoctor: View {
    
    var imageDoctor = ""
    var nameDoctor = ""
    var currentQueue = ""
    var schedule = ""
   
    var body: some View {
        VStack {
            Button(action: {}) {
            VStack{
                HStack{
                    Image(systemName: imageDoctor)
                        .foregroundColor(Color.init(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)))
                        .frame(width: 50, height: 50)
                        .background(Color.init(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)))
                        .cornerRadius(10)
                        .padding(.top,2)
                    
                    VStack(alignment: .leading){
                        Text(nameDoctor)
                        .font(.headline)
                        .foregroundColor(Color.init(#colorLiteral(red: 0.1450980392, green: 0.1568627451, blue: 0.168627451, alpha: 1)))
                        .padding(.vertical, 4)
                        
                        Text("Dokter Umum")
                        .font(.subheadline)
                        .foregroundColor(Color.init(#colorLiteral(red: 0.6274509804, green: 0.6431372549, blue: 0.6588235294, alpha: 1)))

                    }
                        .padding(.leading,5)
                        
                        Spacer()
                    
                    }
                Divider()
                
                HStack{
                Text("Antrian Saat Ini")
                    .font(.body)
                    .foregroundColor(Color.init(#colorLiteral(red: 1, green: 0.5647058824, blue: 0.4, alpha: 1)))
                    .padding(.vertical, 4)
                
                Spacer()
                    
                Text("\(currentQueue) pasien")
                    .font(.body)
                    .bold()
                    .foregroundColor(Color.init(#colorLiteral(red: 1, green: 0.5647058824, blue: 0.4, alpha: 1)))
                    .padding(.vertical, 4)
                    }
            }
        }
            .frame(width: UIScreen.main.bounds.width - 68, height: 90)
            .padding()
            .background(Color.init(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
            .cornerRadius(15)
            .shadow(color: Color.init(#colorLiteral(red: 0.8, green: 0.8392156863, blue: 0.9254901961, alpha: 0.1853799229)), radius: 8, x: 0, y: 0)
            
        }
}
}

struct DoctorSchedule_Previews: PreviewProvider {
    static var previews: some View {
        DoctorSchedule()
    }
}
