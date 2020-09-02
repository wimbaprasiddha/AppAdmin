//
//  HomePage.swift
//  split-bills
//
//  Created by wimba prasiddha on 24/07/20.
//  Copyright © 2020 wimba prasiddha. All rights reserved.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct HomePage: View {
    
    
    init() {
    }
    
    @EnvironmentObject var viewRouter: ViewRouter
    @State var open = false
    
    @State var isLoggoutTapped: Bool = false
    @State var isProfileTapped: Bool = false
    @State var isAntrianTapped: Bool = false
    @State var isSettingsTapped: Bool = false
    @State var isLoading = false
    @State var isPolySelected = false
    @State var polySelected: PolyModel = PolyModel(name: "", image: "", id: 0)
    @State var navBarIsHidden: Bool = true
    @State var username: String = ""
    
    let image =  "Home"
    private let userDefault = UserDefaults.standard
    private let polies = [
        PolyModel(name: "Anak", image: "anak", id: 0),
        PolyModel(name: "Gigi Umum", image: "gigi umum", id: 1),
        PolyModel(name: "THT", image: "THT", id: 2),
        PolyModel(name: "Mata", image: "mata", id: 3),
        PolyModel(name: "Kandungan", image: "kandungan", id: 4),
        PolyModel(name: "Lihat Lainnya", image: "more", id: 5),
        PolyModel(name: "Anak", image: "anak", id: 0),
        PolyModel(name: "Gigi Umum", image: "gigi umum", id: 1),
        PolyModel(name: "THT", image: "THT", id: 2),
        PolyModel(name: "Mata", image: "mata", id: 3),
        PolyModel(name: "Kandungan", image: "kandungan", id: 4),
        PolyModel(name: "Kulit & Kelamin", image: "kulit&kelamin", id: 6),
        PolyModel(name: "Urology", image: "urology", id: 7),
        PolyModel(name: "Anesthesi", image: "anesthesi", id: 8),
        PolyModel(name: "Gigi Spesialis", image: "gigi spesialis", id: 9),
        PolyModel(name: "Jiwa", image: "jiwa", id: 10),
        PolyModel(name: "Fisioterapi", image: "fisioterapi", id: 11),
        PolyModel(name: "Radiologi", image: "radiologi", id: 12),
        PolyModel(name: "Jantung", image: "jantung", id: 13),
        PolyModel(name: "Paru-Paru", image: "paru-paru", id: 14),
        PolyModel(name: "Orthopedi", image: "orthopedi", id: 15),
        PolyModel(name: "Bedah", image: "bedah", id: 16),
        PolyModel(name: "Penyakit Dalam", image: "penyakit dalam", id: 17),
        PolyModel(name: "Syaraf", image: "syaraf", id: 18)
    ]
    
    var body: some View {
        
        NavigationView{
            
            
            ZStack{
                
                NavigationLink(destination: DoctorSchedule(poly: polySelected), isActive: $isPolySelected) {
                    EmptyView()
                }
                
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
                                .padding(.bottom)
                                
                            }
                            Spacer()
                            Image(image)
                        }
                        
                        Greetings(userName: $username)
                        
                        Search().isHidden(false, remove: false)
                            .onTapGesture {
                                self.polySelected = PolyModel(name: "", image: "", id: 0)
                                self.navBarIsHidden = false
                                self.isPolySelected = true
                        }
                        
                        Poliklinik(selectedPoly: $polySelected.didSet(execute: { (value) in
                            self.navBarIsHidden = false
                            self.isPolySelected = true
                        }), polies: polies)
                        
                        
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
                        
                        
                    }.edgesIgnoringSafeArea(.vertical)
                    
                    Menu(open: $open,
                         isLoggoutTapped: $isLoggoutTapped.didSet(execute: {(_) in
                            self.userLogout()
                         }),
                         isProfileTapped: $isProfileTapped,
                         isAntrianTapped: $isAntrianTapped,
                         isSettingsTapped: $isSettingsTapped)
                    
                    if isLoggoutTapped{
                        ZStack {
                            Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.6754334332))
                                .blur(radius: 0)
                                .animation(.default)
                            ActivityIndicator(isAnimating: $isLoggoutTapped, style: .large)
                        }
                    }
                }
            }
            .navigationBarHidden(navBarIsHidden)
            .navigationBarTitle(Text(""))
            .onDisappear {
                self.navBarIsHidden = false
            }
            .onAppear {
                self.navBarIsHidden = true
                self.requestPatientData()
            }
        }.environmentObject(viewRouter)
    }
    
    
    private func userLogout(){
        do{
            try Auth.auth().signOut()
            isLoggoutTapped = false
            userDefault.setValue(false, forKey: UserDefaultKey.isUserLoggedIn.rawValue)
            userDefault.setValue(nil, forKey: UserDefaultKey.userID.rawValue)
            viewRouter.initialPage = AnyView(LoginScreen().environmentObject(viewRouter))
        }catch (let err){
            print(err.localizedDescription)
            isLoggoutTapped = false
        }
        
    }
    
    
    
    private func requestPatientData(){
          
          
          let userID = UserDefaults.standard.value(forKey: UserDefaultKey.userID.rawValue) as! String
          
          Firestore.firestore().collection("user").document(userID)
              .getDocument { (snapshot, err) in
                  if let err = err{
                      print(err.localizedDescription)
                      return
                  }
                  
                  if snapshot?.data() != nil {
                      let patientName = snapshot?.data()?["name"] as! String
                      self.username = patientName
                  }else{
                     print("GAGAL MENGAMBIL DATA PASIEN")
                  }
          }
          
          
      }
    
    
    
    
    
    /*
     ================================
     Custom view builder
     ================================
     */
    
    
    struct Greetings: View {
        @Binding var userName: String
        var body: some View {
            VStack{
                Text("Hi \(userName)")
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
        @Binding var isLoggoutTapped: Bool
        @Binding var isProfileTapped: Bool
        @Binding var isAntrianTapped: Bool
        @Binding var isSettingsTapped: Bool
        
        var body: some View {
            
            VStack{
                VStack{
                    ListMenu(isTapped: $isProfileTapped, active: false, icon: "person", text: "Profile")
                    ListMenu(isTapped: $isAntrianTapped, active: false, icon: "hourglass", text: "Antrian")
                    ListMenu(isTapped: $isSettingsTapped, active: false, icon: "gear", text: "Settings")
                    
                    Spacer()
                    
                    ListMenu(isTapped: $isLoggoutTapped, active: false, icon: "escape", text: "Log Out")
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
        @Binding var isTapped: Bool
        var isTappedClousure: () -> Void = { }
        var active: Bool
        var icon = "gear"
        var text = "Settings"
        
        var body: some View {
            HStack{
                Button(action: {
                    self.isTapped = true
                    self.isTappedClousure()
                }){
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
        @Binding var selectedPoly: PolyModel
        
        var polies: [PolyModel]
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
                    ForEach(Range(0...2)) { index in
                        ListPoli(
                            selectedPoly: self.$selectedPoly,
                            imagePoli: self.polies[index].image,
                            titlePoli: self.polies[index].name,
                            poly: self.polies[index]
                        )
                        Spacer()
                    }
                    
                }
                .padding(.horizontal, 20)
                
                HStack{
                    
                    ForEach(Range(3...5)) { index in
                        if index == 5{
                            ListPoli(
                                selectedPoly: self.$selectedPoly,
                                imagePoli: self.polies[index].image,
                                titlePoli: self.polies[index].name,
                                poly: self.polies[index],
                                more: Array(self.polies[6..<self.polies.count]))
                        }else{
                            ListPoli(
                                selectedPoly: self.$selectedPoly,
                                imagePoli: self.polies[index].image,
                                titlePoli: self.polies[index].name,
                                poly: self.polies[index]
                            )
                        }
                    }
                }
                    
                .padding(20)
            }
            
        }
    }
    
    struct ListPoli: View {
        @Binding var selectedPoly: PolyModel
        var imagePoli = "gear"
        var titlePoli = "Settings"
        var poly: PolyModel
        var more = [PolyModel]()
        @State var show = false
        
        var body: some View {
            HStack{
                if more.isEmpty == false {
                    
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
                        DetailPoli(
                            selectedPoly: self.$selectedPoly.didSet(execute: { (_) in
                                self.show.toggle()
                            }),
                            detail: .constant(true),
                            polyReadyToDisplay: self.more.chunked(into: 3)
                        )
                    }
                }
                else {
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
                        
                    Button(action: {
                        self.selectedPoly = self.poly
                    }){
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
        
        
        @Binding var selectedPoly: PolyModel
        @Binding var detail: Bool
        
        var polyReadyToDisplay: [[PolyModel]]
        
        
        
        var body: some View {
            ScrollView (.vertical, showsIndicators: false) {
                VStack{
                    Spacer()
                        .padding(.vertical)
                    
                    ForEach(polyReadyToDisplay.indices) { index in
                        HStack(alignment: .center){
                            ForEach(self.polyReadyToDisplay[index].indices) { index2 in
                                ListPoli(
                                    selectedPoly: self.$selectedPoly,
                                    imagePoli: self.polyReadyToDisplay[index][index2].image,
                                    titlePoli: self.polyReadyToDisplay[index][index2].name,
                                    poly: self.polyReadyToDisplay[index][index2]
                                )
                                Spacer()
                            }
                            
                            if self.polyReadyToDisplay[index].count < 3{
                                Text("")
                                    .frame(width: 80, height: 80)
                                    .padding()
                                Spacer()
                            }
                            
                            
                            
                        }.padding(.horizontal, 20)
                        
                    }.padding(.bottom, 20)
                    
                }
                
            }
        }
    }
}






