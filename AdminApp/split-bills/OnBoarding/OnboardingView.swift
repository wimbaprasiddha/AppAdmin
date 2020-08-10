//
//  OnboardingView.swift
//  split-bills
//
//  Created by wimba prasiddha on 23/07/20.
//  Copyright © 2020 wimba prasiddha. All rights reserved.
//

import SwiftUI

struct OnboardingView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @State var currentPageIndex = 0
    
    var userDefault: UserDefaults = UserDefaults()

    
    var subviews = [
            UIHostingController(rootView: Subview(image: "onboarding 1")),
            UIHostingController(rootView: Subview(image: "onboarding 2")),
            UIHostingController(rootView: Subview(image: "onboarding 3"))
    ]
    
    var titles = ["Cari Tahu Jadwal Dan Juga Jumlah Antrian Saat Ini","Tunggu Giliranmu Ditempat Ternyamanmu","Cukup Satu Akun Untuk Ambil Antrian Keluargamu"]
    
    var captions = ["kamu dapat mengambil antrian untuk rumah sakit terdekat maupun dokter langgananmu, darimanapun kamu berada.","Tenang saja giliranmu tidak akan terlewat, kami akan memberitahu kapan kamu dipanggil.","Tidak perlu khawatir, Kamu bisa mengambil antrian untuk keluarga atau kerabatmu yang tidak bisa menggunakan aplikasi sekalipun."]
    
    var body: some View {
        
        VStack {
            PageViewController(currentPageIndex: $currentPageIndex, viewController: subviews)
            .frame(height: 450)
            
            Group{
                Text(titles[currentPageIndex])
                    .font(.title)
                    .bold()
                    .frame(width: 365, height: 90, alignment: .leading)
                Text(captions[currentPageIndex])
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .frame(width: 365, height: 80, alignment: .topLeading)
                    .lineLimit(nil)
            }
            
            HStack{
                 PageControl(NumberOfpages: subviews.count, currentPageIndex: $currentPageIndex)
                
                Spacer()
                
                Button(action: {
                    if self.currentPageIndex + 1 == self.subviews.count {
                        self.currentPageIndex = 0
                       
                    } else {
                        self.currentPageIndex += 1
                    }
                }) {
                    if self.currentPageIndex == 2 {
                        Button(action: {
                            self.moveToLoginPage()
                        }) {
                            ButtonLogin()
                        }
                    }
                    else {
                        ButtonContent()
                    }
                }
            }
            .frame(width: 365, height:80)
        }
        
    }
    
    private func moveToLoginPage(){
        viewRouter.initialPage = AnyView(LoginScreen())
        userDefault.setValue(true, forKey: UserDefaultKey.onLoginPage.rawValue)
    }
}

struct ButtonContent: View {
    var body: some View {
        Text("LANJUT")
        .bold()
        .foregroundColor(Color.init(#colorLiteral(red: 0.06666666667, green: 0.3019607843, blue: 0.5882352941, alpha: 1)))
            .frame(width: 90, height: 40)
    }
}

struct ButtonLogin: View {
    var body: some View {
        Text("MASUK")
            .foregroundColor(.white)
            .frame(width: 130, height: 25)
            .padding()
            .background(Color.init(#colorLiteral(red: 0.06666666667, green: 0.3019607843, blue: 0.5882352941, alpha: 1)))
            .cornerRadius(15)
            .shadow(color: Color.init(#colorLiteral(red: 0.8, green: 0.8392156863, blue: 0.9254901961, alpha: 1)), radius: 8, x: 0, y: 6)
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
