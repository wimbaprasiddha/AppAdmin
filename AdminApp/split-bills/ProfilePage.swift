//
//  ProfilePage.swift
//  split-bills
//
//  Created by wimba prasiddha on 26/07/20.
//  Copyright © 2020 wimba prasiddha. All rights reserved.
//

import SwiftUI



struct ProfilePage: View {
    
   @State var popUp = false
    
    var body: some View {
        ZStack{
        VStack {
            dataAccount(accountName: "Samantha", accountEmail: "email@mail.com")
            ZStack{
                Color(#colorLiteral(red: 0.8, green: 0.8392156863, blue: 0.9254901961, alpha: 0.16))
                .frame(width: UIScreen.main.bounds.width, height: 10)
            }
            patientData(jenisKelamin: "Perempuan", BOD: "19-03-1990")

            ZStack{
                Color(#colorLiteral(red: 0.8, green: 0.8392156863, blue: 0.9254901961, alpha: 0.16))
                .frame(width: UIScreen.main.bounds.width, height: 10)
            }
            Spacer()
            .padding()
            

            queue()
            
            if self.popUp {
               
            }
        
            Spacer()
            .padding(.vertical)
            
        }
    
        }
    }
}

struct dataAccount: View {
    var accountName = ""
    var accountEmail = ""
    var body: some View {

    VStack{
        HStack{
            VStack(alignment: .leading){
                Text(accountName)
                    .font(.system(size: 20))
                    .bold()
                    .foregroundColor(Color.init(#colorLiteral(red: 0.1450980392, green: 0.1568627451, blue: 0.168627451, alpha: 1)))
                    .padding(.vertical, 4)
                            
                Text(accountEmail)
                    .font(.body)
                    .foregroundColor(Color.init(#colorLiteral(red: 0.6274509804, green: 0.6431372549, blue: 0.6588235294, alpha: 1)))

            }
            .padding(.leading,20)
            Spacer()
            
            Text("Edit")
            .foregroundColor(Color.init(#colorLiteral(red: 0.06666666667, green: 0.3019607843, blue: 0.5882352941, alpha: 1)))
            .bold()
            .padding(.trailing, 20)
            }
        .frame(width: UIScreen.main.bounds.width, height: 90)

    }
        
}
}

struct patientData: View {
var jenisKelamin = ""
var BOD = ""

var body: some View {
        VStack{
                       
            HStack(spacing:15) {
                Text("Jenis Kelamin")
                    .font(.body)
                    .foregroundColor(Color.init(#colorLiteral(red: 0.1450980392, green: 0.1568627451, blue: 0.168627451, alpha: 1)))
                
                Spacer()
                
                Text(jenisKelamin)
                    .font(.body)
                    .foregroundColor(Color.init(#colorLiteral(red: 0.1450980392, green: 0.1568627451, blue: 0.168627451, alpha: 1)))
                    .padding(.trailing, 20)
            }
                .padding(.vertical,10)
                Divider()
                       
            HStack(spacing: 15) {
                Text("Tanggal Lahir")
                    .font(.body)
                    .foregroundColor(Color.init(#colorLiteral(red: 0.1450980392, green: 0.1568627451, blue: 0.168627451, alpha: 1)))
                
                Spacer()
                
                Text(BOD)
                    .font(.body)
                    .foregroundColor(Color.init(#colorLiteral(red: 0.1450980392, green: 0.1568627451, blue: 0.168627451, alpha: 1)))
                    .padding(.trailing, 20)
            }
                .padding(.vertical, 10)
                
        }
            
        .padding(.leading,20)
    }
}

struct ProfilePage_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePage()
//        popDetailQueue(popUp: .constant(true))
    }
}


/*
=========================================================================
POP UP CURRENT QUEUE
=========================================================================
 */

struct queue: View {
    
    @State var popUp = false
    
    @State var sisaAntrian = "20"
    @State var estimate = "14.20"
    
    var body: some View {
        ZStack{
        Button(action: {self.popUp.toggle()}){
            dataQueue(sisaAntrian: $sisaAntrian, estimate: $estimate)
        }
        popDetailQueue(popUp: $popUp)
        }
 
    }
}

struct dataQueue: View {
    @Binding var sisaAntrian: String
    @Binding var estimate: String
    var body: some View {
        VStack{
            HStack{
            Text("Sisa Antrian")
                .bold()
                .foregroundColor(Color.init(#colorLiteral(red: 0.1450980392, green: 0.1568627451, blue: 0.168627451, alpha: 1)))
                Spacer()
                
            Text("\(sisaAntrian) Pasien")
                .bold()
                .foregroundColor(Color.init(#colorLiteral(red: 1, green: 0.5647058824, blue: 0.4, alpha: 1)))
            }
            .padding(.horizontal,10)
            .padding(.vertical,5)
            
            HStack{
            Text("Estimasi Dipanggil")
                .foregroundColor(Color.init(#colorLiteral(red: 0.6274509804, green: 0.6431372549, blue: 0.6588235294, alpha: 1)))
                Spacer()
                
            Text(estimate)
                .foregroundColor(Color.init(#colorLiteral(red: 0.6274509804, green: 0.6431372549, blue: 0.6588235294, alpha: 1)))
            }
            .padding(.horizontal,10)
            
        }
        .frame(width: 350, height: 60)
        .padding()
        .background(Color.init(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
        .cornerRadius(15)
        .shadow(color: Color.init(#colorLiteral(red: 0.8, green: 0.8392156863, blue: 0.9254901961, alpha: 0.2607662671)), radius: 8, x: 0, y: 0)
        
    }
}

struct popDetailQueue: View {
    @State var estimate = "14.00"
    @State var sisaAntrian = "20"
    @Binding var popUp: Bool
    
    var body: some View {
        ZStack{
            ZStack{
                if popUp == true {
                    ZStack {
                        Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.6754334332))
                        .blur(radius: 0)
                        .animation(.default)
                    }
                }
            }
        
            VStack(alignment: .leading){
       
            HStack{
            Text("Antrian")
            .font(.title)
            
            Spacer()
            
            Button(action: {self.popUp.toggle()}){
                Image(systemName: "xmark.square")
                .resizable()
                .frame(width: 20, height: 20)
            }
            
            }
            
            HStack{
                Image(systemName: "person")
                    .foregroundColor(Color.init(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)))
                    .frame(width: 70, height: 70)
                    .background(Color.init(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)))
                    .cornerRadius(10)
                    .padding(.top,2)
                                       
                VStack(alignment: .leading){
                    Text("Nama Dokter")
                        .font(.system(size: 20))
                        .bold()
                        .foregroundColor(Color.init(#colorLiteral(red: 0.1450980392, green: 0.1568627451, blue: 0.168627451, alpha: 1)))
                        .padding(.vertical, 4)
                                           
                    Text("Nama Poliklinik")
                        .font(.body)
                        .foregroundColor(Color.init(#colorLiteral(red: 0.6274509804, green: 0.6431372549, blue: 0.6588235294, alpha: 1)))
            }
            .padding(.horizontal, 8)
            .frame(width: 200, height: 80, alignment: .leading)
                
        }
            ZStack{
                Divider()
                .padding()
            }
            
            VStack{
            HStack{
                Text("Sisa Antrian")
                    .bold()
                    .foregroundColor(Color.init(#colorLiteral(red: 0.1450980392, green: 0.1568627451, blue: 0.168627451, alpha: 1)))
                Spacer()
            
                Text("\(sisaAntrian) Pasien")
                    .bold()
                    .foregroundColor(Color.init(#colorLiteral(red: 1, green: 0.5647058824, blue: 0.4, alpha: 1)))
                }
                    .padding(.horizontal,10)
                    .padding(.vertical,5)
        
            HStack{
                Text("Estimasi Dipanggil")
                    .foregroundColor(Color.init(#colorLiteral(red: 0.6274509804, green: 0.6431372549, blue: 0.6588235294, alpha: 1)))
                Spacer()
            
                Text(estimate)
                    .foregroundColor(Color.init(#colorLiteral(red: 0.6274509804, green: 0.6431372549, blue: 0.6588235294, alpha: 1)))
            }
                .padding(.horizontal, 10)
    
        Spacer()
            
        }
            
            checkinButton()
            .padding(.vertical, 25)
            Spacer()
            
        }
            .padding(.horizontal, 30)
            .padding(.top, 30)
            .frame(width: 360, height: 434)
            .background(Color.init(.white))
            .cornerRadius(30)
            .opacity(self.popUp ? 1 : 0)
            .animation(.default)
    }
        .edgesIgnoringSafeArea(.all)
        
}
}

struct checkinButton: View {
    var body: some View {
        Text("Check In")
            .foregroundColor(.white)
            .frame(width: 265, height: 25)
            .padding()
            .background(Color.init(#colorLiteral(red: 0.06666666667, green: 0.3019607843, blue: 0.5882352941, alpha: 1)))
            .cornerRadius(15)
    }
}


