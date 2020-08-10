//
//  RegisterAkun.swift
//  split-bills
//
//  Created by wimba prasiddha on 25/07/20.
//  Copyright © 2020 wimba prasiddha. All rights reserved.
//

import SwiftUI

struct RegisterAccount: View {
    let image = "Register"
    var body: some View {
        VStack{
          Image(image)
            .padding()
            Text("Register Akun Baru")
                .foregroundColor(Color.init(#colorLiteral(red: 0.1450980392, green: 0.1568627451, blue: 0.168627451, alpha: 1)))
                .font(.title)
                .bold()
            Text("Silahkan isi data dibawah")
                .foregroundColor(Color.init(#colorLiteral(red: 0.1450980392, green: 0.1568627451, blue: 0.168627451, alpha: 1)))
                .font(.subheadline)
                .padding(.vertical, 5)
            
            AccountForm()
            CreateAccountButton()
                .padding(.vertical, 25)
        }
        
    }
}

struct AccountForm: View {
    @State var newEmail = ""
    @State var newPass  = ""
    @State var rePass = ""
    var body: some View {
        VStack{
                       
            HStack(spacing:15) {
                Image(systemName: "envelope")
                    .foregroundColor(Color.init(#colorLiteral(red: 0.6274509804, green: 0.6431372549, blue: 0.6588235294, alpha: 1)))
                    TextField("Masukan Alamat Email", text: $newEmail)
            }
                .padding(.vertical,20)
                Divider()
                       
            HStack(spacing: 15) {
                Image(systemName: "lock")
                    .resizable()
                    .frame(width: 15, height: 18)
                    .foregroundColor(Color.init(#colorLiteral(red: 0.6274509804, green: 0.6431372549, blue: 0.6588235294, alpha: 1)))
                SecureField("Masukan Password", text: $newPass)
                
                Button(action: {
                }) {
                    Image(systemName: "eye")
                        .foregroundColor(Color.init(#colorLiteral(red: 0.6274509804, green: 0.6431372549, blue: 0.6588235294, alpha: 1)))
                    }
                .padding()
            }
                .padding(.vertical, 10)
                Divider()
            
            HStack(spacing: 15) {
                Image(systemName: "lock")
                    .resizable()
                    .frame(width: 15, height: 18)
                    .foregroundColor(Color.init(#colorLiteral(red: 0.6274509804, green: 0.6431372549, blue: 0.6588235294, alpha: 1)))
                SecureField("Masukan Ulang Password", text: $newPass)
                
                Button(action: {
                }) {
                    Image(systemName: "eye")
                        .foregroundColor(Color.init(#colorLiteral(red: 0.6274509804, green: 0.6431372549, blue: 0.6588235294, alpha: 1)))
                    }
                    .padding()
            }
            .padding(.vertical,10)
            Divider()
        }
            
        .padding(.vertical)
        .padding(.leading,40)
    }
}


struct CreateAccountButton: View {
       var body: some View {
           Text("Buat Akun")
               .foregroundColor(.white)
               .frame(width: 330, height: 25)
               .padding()
               .background(Color.init(#colorLiteral(red: 0.06666666667, green: 0.3019607843, blue: 0.5882352941, alpha: 1)))
               .cornerRadius(15)
               .shadow(color: Color.init(#colorLiteral(red: 0.8, green: 0.8392156863, blue: 0.9254901961, alpha: 1)), radius: 8, x: 0, y: 6)
       }
   }

struct RegisterAkun_Previews: PreviewProvider {
    static var previews: some View {
        RegisterAccount()
    }
}
