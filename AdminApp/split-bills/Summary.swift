//
//  Summary.swift
//  split-bills
//
//  Created by wimba prasiddha on 26/07/20.
//  Copyright © 2020 wimba prasiddha. All rights reserved.
//

import SwiftUI

struct Summary: View {
    @State var toggle = false
    var body: some View {
    ZStack{
        VStack{
        doctorDetail(doctorName: "Dr Samantha", poliklinikName: "Poliklinik Anak")
            ZStack{
                Color(#colorLiteral(red: 0.8, green: 0.8392156863, blue: 0.9254901961, alpha: 0.16))
                .frame(width: UIScreen.main.bounds.width, height: 10)
            }
        dataSummary(doctorSchedule: "08.00-14.00", queue: "20")
            ZStack{
                Color(#colorLiteral(red: 0.8, green: 0.8392156863, blue: 0.9254901961, alpha: 0.16))
                .frame(width: UIScreen.main.bounds.width, height: 10)
            }
        summaryPatient(patientData: "Samantha", toggle: self.$toggle)
            if toggle == true {
                Text("Pastikan anda sudah memiliki surat rujukan")
                    .font(.callout)
                    .foregroundColor(Color.init(#colorLiteral(red: 0.6274509804, green: 0.6431372549, blue: 0.6588235294, alpha: 1)))
                    .padding(.trailing, 26)
                } else {
                Text("")
                }
            ZStack{
                Color(#colorLiteral(red: 0.8, green: 0.8392156863, blue: 0.9254901961, alpha: 0.16))
                .frame(width: UIScreen.main.bounds.width, height: 10)
            }
 
        Spacer()
        .padding(.vertical)
            
        ambilAntrian()
            .padding(.vertical, 25)
        }
        
    }
    }
}

struct doctorDetail: View {
    var doctorName = ""
    var poliklinikName = ""
    var body: some View {

    VStack{
        HStack{
            Image(systemName: "person")
                .foregroundColor(Color.init(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)))
                .frame(width: 80, height: 80)
                .background(Color.init(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)))
                .cornerRadius(10)
                .padding(.top,2)
                        
            VStack(alignment: .leading){
                Text(doctorName)
                    .font(.system(size: 20))
                    .bold()
                    .foregroundColor(Color.init(#colorLiteral(red: 0.1450980392, green: 0.1568627451, blue: 0.168627451, alpha: 1)))
                    .padding(.vertical, 4)
                            
                Text(poliklinikName)
                    .font(.body)
                    .foregroundColor(Color.init(#colorLiteral(red: 0.6274509804, green: 0.6431372549, blue: 0.6588235294, alpha: 1)))

            }
            .padding(.leading,15)
        
            }
        .padding(.trailing, 140)
        .frame(width: UIScreen.main.bounds.width, height: 90)

    }
        
}
}

struct dataSummary: View {
var doctorSchedule = ""
var queue = ""

var body: some View {
        VStack{
                       
            HStack(spacing:15) {
                Text("Jam praktek")
                    .font(.body)
                    .foregroundColor(Color.init(#colorLiteral(red: 0.1450980392, green: 0.1568627451, blue: 0.168627451, alpha: 1)))
                
                Spacer()
                
                Text(doctorSchedule)
                    .font(.body)
                    .foregroundColor(Color.init(#colorLiteral(red: 0.1450980392, green: 0.1568627451, blue: 0.168627451, alpha: 1)))
                    .padding(.trailing, 20)
            }
                .padding(.vertical,10)
                Divider()
                       
            HStack(spacing: 15) {
                Text("Antrian saat ini")
                    .font(.body)
                    .foregroundColor(Color.init(#colorLiteral(red: 0.1450980392, green: 0.1568627451, blue: 0.168627451, alpha: 1)))
                
                Spacer()
                
                Text("\(queue) Pasien")
                    .font(.body)
                    .foregroundColor(Color.init(#colorLiteral(red: 0.1450980392, green: 0.1568627451, blue: 0.168627451, alpha: 1)))
                    .padding(.trailing, 20)
            }
                .padding(.vertical, 10)
                
        }
            
        .padding(.leading,40)
    }
}


struct summaryPatient: View {
    var patientData = ""
    @Binding var toggle: Bool
    
    var body: some View {
        VStack{
                       
            HStack(spacing:15) {
                Text("Nama pasien")
                    .font(.body)
                    .foregroundColor(Color.init(#colorLiteral(red: 0.1450980392, green: 0.1568627451, blue: 0.168627451, alpha: 1)))
                
                Spacer()
                
                Text(patientData)
                    .font(.body)
                    .foregroundColor(Color.init(#colorLiteral(red: 0.1450980392, green: 0.1568627451, blue: 0.168627451, alpha: 1)))
                    .padding(.trailing, 20)
            }
                .padding(.vertical,10)
            Divider()
            
         
            HStack(spacing: 15) {
                Text("Anda ingin menggunakan BPJS?")
                    .font(.body)
                    .foregroundColor(Color.init(#colorLiteral(red: 0.1450980392, green: 0.1568627451, blue: 0.168627451, alpha: 1)))
                
                Spacer()
                
                Toggle(isOn: $toggle){
                    //set data when toggle on
                    Text("")
                }
                
                .frame(width: 50)
                .padding(.trailing, 22)
               
            }
            .padding(.vertical, 10)

        }
        
        .padding(.leading,40)
        
    }
}

struct ambilAntrian: View {
    var body: some View {
        Text("Ambil Antrian")
            .foregroundColor(.white)
            .frame(width: 330, height: 25)
            .padding()
            .background(Color.init(#colorLiteral(red: 0.06666666667, green: 0.3019607843, blue: 0.5882352941, alpha: 1)))
            .cornerRadius(15)
            .shadow(color: Color.init(#colorLiteral(red: 0.8, green: 0.8392156863, blue: 0.9254901961, alpha: 1)), radius: 8, x: 0, y: 6)
    }
}


struct Summary_Previews: PreviewProvider {
    static var previews: some View {
        Summary()
    }
}

