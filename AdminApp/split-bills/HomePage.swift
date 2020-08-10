//
//  HomePage.swift
//  split-bills
//
//  Created by wimba prasiddha on 24/07/20.
//  Copyright © 2020 wimba prasiddha. All rights reserved.
//

import SwiftUI

struct HomePage: View {
    
    @State var open = false
    
    let image =  "Home"
   
    var body: some View {
        
        ZStack{
            ZStack{
                VStack{
                    Spacer()
                    .padding(.vertical)
                      Image("Footer")
                } .edgesIgnoringSafeArea(.vertical)
                  
            VStack{
               
                HStack{
                    VStack {
                    Button(action: {self.open.toggle()}){
                        Image(systemName: "line.horizontal.3")
                            .font(.system(size:28, weight: .bold))
                            .foregroundColor(Color.init(#colorLiteral(red: 0.1176470588, green: 0.262745098, blue: 0.5137254902, alpha: 1)))
                            .padding(.horizontal, 30)
                    }
                    .padding(.bottom,70)
                        
                    }
                    Spacer()
                    Image(image)
                }
                
                Greetings()
 
                Search()
                
                Poliklinik()
                    
                
                Spacer()
                .padding(.vertical)
            }
            .edgesIgnoringSafeArea(.vertical)
                
            ZStack{
                    if open == true {
                        ZStack {
                            Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.6754334332))
                            .blur(radius: 0)
                            .animation(.default)
                        }
                    }
                } .edgesIgnoringSafeArea(.vertical)
            Menu(open: $open)
                
            }
        }

    }
}

struct Greetings: View {
    var body: some View {
        VStack{
        Text("Hi Samantha")
            .font(.system(size: 40))
            .bold()
            .foregroundColor(Color.init(#colorLiteral(red: 0.1450980392, green: 0.1568627451, blue: 0.168627451, alpha: 1)))
            .frame(width: UIScreen.main.bounds.width, height: 50)
        Text("Lorem Ipsum et Dolor")
            .font(.headline)
            .foregroundColor(Color.init(#colorLiteral(red: 0.3215686275, green: 0.3411764706, blue: 0.3607843137, alpha: 1)))
        }
        
    }
}

struct Search: View {
   
    @State var searchSomething = ""
    
    var body: some View {
        HStack(spacing: 20){
            Image(systemName: "magnifyingglass")
                .foregroundColor(Color.init(#colorLiteral(red: 0.6274509804, green: 0.6431372549, blue: 0.6588235294, alpha: 1)))
            TextField("Cari Poliklinik atau dokter", text: $searchSomething)
        }
        .frame(width: 320, height: 25)
            .padding()
            .background(Color.init(#colorLiteral(red: 0.9529411765, green: 0.9568627451, blue: 0.9764705882, alpha: 1)))
            .cornerRadius(10)
        .padding()
    }
}



struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage()
//        Menu(open: .constant(true))
//        DetailPoli(detail: .constant(true))
    }
}

struct Menu: View {
    @Binding var open: Bool
    var body: some View {
        
        VStack{
            VStack{
                ListMenu(active: false, icon: "person", text: "Profile")
                ListMenu(active: false, icon: "hourglass", text: "Antrian")
                ListMenu(active: false, icon: "gear", text: "Settings")
                
                Spacer()
              
                ListMenu(active: false, icon: "escape", text: "Log Out")
                    .padding(.vertical,20)
                
            }
            .padding(.top, 30)
            
            HStack{
                Spacer()
            }
            
            Spacer()
        }
        .padding(.vertical,2)
        .background(Color.init(.white))
        .cornerRadius(30)
        .padding(.trailing, 90)
        .offset(x: open ? 0 : -UIScreen.main.bounds.width )
        .rotation3DEffect(Angle(degrees: open ? 0 : 45), axis: (x: 0 , y: 20, z: 0))
        .animation(.default)
        .onTapGesture {
            self.open.toggle()
        }
    }
}

struct ListMenu: View {
    
    var active: Bool
    var icon = "gear"
    var text = "Settings"
    
    var body: some View {
        HStack{
            Button(action: {}){
            Image(systemName: icon)
                .foregroundColor(active ? Color.init(#colorLiteral(red: 0.1176470588, green: 0.262745098, blue: 0.5137254902, alpha: 1)) : Color.init(#colorLiteral(red: 0.1450980392, green: 0.1568627451, blue: 0.168627451, alpha: 1)))
                .font(.system(size: 18, weight: active ? .bold : .regular))
                .frame(width: 48, height: 32)
            
            Text(text)
            .foregroundColor(active ? Color.init(#colorLiteral(red: 0.1176470588, green: 0.262745098, blue: 0.5137254902, alpha: 1)) : Color.init(#colorLiteral(red: 0.1450980392, green: 0.1568627451, blue: 0.168627451, alpha: 1)))
            .font(.system(size: 18, weight: active ? .bold : .regular))
            }
            Spacer()
        }
        .padding(8)
        .padding(.trailing, 20)
        
    }
}


struct Poliklinik: View {
 
    var body: some View {
        
    VStack{
        HStack{
            Text("List Poliklinik")
                .font(.headline)
            
            Spacer()
            
        }
        .padding(.vertical, 20)
        .padding(.horizontal, 30)
        
        HStack{
           
            ListPoli(imagePoli: "anak", titlePoli: "Anak")
     
            Spacer()
            
            ListPoli(imagePoli: "gigi umum", titlePoli: "Gigi Umum")
            
            Spacer()
            
            ListPoli(imagePoli: "THT", titlePoli: "THT")

        }
        .padding(.horizontal, 20)
        
        HStack{
            
                ListPoli(imagePoli: "mata", titlePoli: "Mata")
      
                Spacer()
                
                ListPoli(imagePoli: "kandungan", titlePoli: "Kandungan")
                
                Spacer()
                
              
                ListPoli(imagePoli: "more", titlePoli: "Lihat Lainnya", more: true)
            
            }
        
    .padding(20)
    }
    
    }
}

struct ListPoli: View {
    
    var imagePoli = "anak"
    var titlePoli = "Settings"
    var more = false
    @State var show = false
    
    var body: some View {
        HStack{
             
                if more == true {
                    ZStack{
                    VStack{
                    Image(imagePoli)
                    Text(titlePoli)
                        .frame(width: 100, height: 20)
                        .font(.system(size: 14))
                        .foregroundColor(Color.init(#colorLiteral(red: 0.1450980392, green: 0.1568627451, blue: 0.168627451, alpha: 1)))
                    
                    }
                    .frame(width: 80, height: 80)
                    .padding()
                    .background(Color.init(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                    .cornerRadius(15)
                    .shadow(color: Color.init(#colorLiteral(red: 0.8, green: 0.8392156863, blue: 0.9254901961, alpha: 0.2607662671)), radius: 8, x: 0, y: 6)
                    
                    
            Button(action: {self.show.toggle()}) {
                Text("")
                .frame(width: 80, height: 80)
            }
            }
                    .sheet(isPresented: $show){
                    DetailPoli(detail: .constant(true))
                    }
                }
                else {
                    ZStack{
                        VStack {
                        Image(imagePoli)
                        
                        Text(titlePoli)
                            .frame(width: 100, height: 20)
                            .font(.system(size: 14))
                            .foregroundColor(Color.init(#colorLiteral(red: 0.1450980392, green: 0.1568627451, blue: 0.168627451, alpha: 1)))
                        }
                    .frame(width: 80, height: 80)
                    .padding()
                    .background(Color.init(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                    .cornerRadius(15)
                    .shadow(color: Color.init(#colorLiteral(red: 0.8, green: 0.8392156863, blue: 0.9254901961, alpha: 0.2607662671)), radius: 8, x: 0, y: 6)
                        
                        Button(action: {}){
                        Text("")
                        .frame(width: 80, height: 80)
                        }
                  
                    }
            }
            Spacer()
        }
        
    }
}

struct DetailPoli: View {
    @Binding var detail: Bool
    var body: some View {
        ScrollView (.vertical, showsIndicators: false) {
        VStack{
            Spacer()
            .padding(.vertical)
            HStack{
                    ListPoli(imagePoli: "gear", titlePoli: "Poli A")
                    
                    Spacer()
                    
                    ListPoli(imagePoli: "gear", titlePoli: "Poli B")
                    
                    Spacer()
                    
                    ListPoli(imagePoli: "gear", titlePoli: "Poli C")
                }
                .padding(.horizontal, 20)
                
            HStack{
                    ListPoli(imagePoli: "gear", titlePoli: "Poli A")
                    
                    Spacer()
                    
                    ListPoli(imagePoli: "gear", titlePoli: "Poli B")
                    
                    Spacer()
                    
                    ListPoli(imagePoli: "gear", titlePoli: "Poli C")
                }
                
                
            .padding(20)
            
       
        }

        }
    }
}




