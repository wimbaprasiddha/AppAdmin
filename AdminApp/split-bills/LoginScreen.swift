//
//  LoginScreen.swift
//  split-bills
//
//  Created by wimba prasiddha on 23/07/20.
//  Copyright © 2020 wimba prasiddha. All rights reserved.
//

import SwiftUI
import Combine
import FirebaseAuth

class LoginScreenFactory: ObservableObject{
    
    @EnvironmentObject var viewRouter: ViewRouter
    
    @Published var email = ""
    @Published var pass = ""
    @Published var pushToRegister: Bool = false
    @Published var showAlert: Bool = false
    var alertTitle: (String, String) = ("failed to login", "error login")
    
}


struct LoginScreen: View {
    
    @EnvironmentObject var viewRouter: ViewRouter
    @ObservedObject var factory = LoginScreenFactory()
    @State var isLoading: Bool = false
    private var userDefaults = UserDefaults.standard
    let image = "Login"
    
    var body: some View {
        
        NavigationView {
            VStack {
                
                NavigationLink(destination: Text("register").environmentObject(viewRouter), isActive: $factory.pushToRegister) {
                    EmptyView()
                }
                
                
                Image(image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipped()
                
                Text("Hi.. Selamat Datang")
                    .font(.title)
                Text("lorem ipsum et dolor")
                    .font(.subheadline)
                
                
                LoginForm()
                    .environmentObject(factory)
                
                
                HStack{
                    Text("Belum punya akun?")
                    
                    Button(action: {
                        self.factory.pushToRegister.toggle()
                    }) {
                        Register()
                    }
                    
                }
                ZStack{
                    
                    Button(action: {
                        self.loginConfirmation()
                    }) {
                        LogginButton()
                    }
                    .padding()
                
                    ActivityIndicator(isAnimating: $isLoading, style: .large)

                }
                
            }
        
            
        }
        .alert(isPresented: $factory.showAlert) { () -> Alert in
            Alert(
                title: Text(factory.alertTitle.0),
                message: Text(factory.alertTitle.1),
                dismissButton: .default(Text("OK")){
                    self.factory.showAlert = false
                })
        }
    }
    
    
    private func loginConfirmation(){
        isLoading = true
        

        Auth.auth().signIn(withEmail: factory.email, password: factory.pass) { (result, err) in
            self.isLoading = false

            if let err = err{
                self.factory.alertTitle = ("failed to login", "\(err.localizedDescription)")
                self.factory.showAlert.toggle()
                return
            }
            
            
            self.viewRouter.initialPage = AnyView(HomePage().environmentObject(self.viewRouter))
            self.userDefaults.setValue(true, forKey: UserDefaultKey.isUserLoggedIn.rawValue)
            
        }
        
    }
    
    struct ActivityIndicator: UIViewRepresentable {
        @Binding var isAnimating: Bool
        let style: UIActivityIndicatorView.Style

        func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
            let ai = UIActivityIndicatorView(style: style)
            ai.color = .white
            return ai
        }

        func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
            isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
        }
    }
    
    
    
  
    
    struct LoginForm: View {
        
        @EnvironmentObject var factory: LoginScreenFactory
    
        var body: some View {
            
            VStack{
                
                HStack(spacing:15) {
                    Image(systemName: "envelope")
                        
                        .foregroundColor(Color.init(#colorLiteral(red: 0.6274509804, green: 0.6431372549, blue: 0.6588235294, alpha: 1)))
                    TextField("Masukan Alamat Email", text: $factory.email )
                    
                }
                .padding(.vertical,20)
                Divider()
                
                HStack(spacing: 15) {
                    Image(systemName: "lock")
                        .resizable()
                        .frame(width: 15, height: 18)
                        .foregroundColor(Color.init(#colorLiteral(red: 0.6274509804, green: 0.6431372549, blue: 0.6588235294, alpha: 1)))
                    SecureField("Masukan Password", text: $factory.pass)
                    
                    Button(action: {
                        
                    }) {
                        Image(systemName: "eye")
                            .foregroundColor(Color.init(#colorLiteral(red: 0.1450980392, green: 0.1568627451, blue: 0.168627451, alpha: 1)))
                    }
                    .padding()
                }
                .padding(.vertical, 20)
                Divider()
            }
            .padding(.vertical)
            .padding(.leading,40)
        }
    }
    
    struct LogginButton: View {
        var body: some View {
            Text("MASUK")
                .foregroundColor(.white)
                .frame(width: 330, height: 25)
                .padding()
                .background(Color.init(#colorLiteral(red: 0.06666666667, green: 0.3019607843, blue: 0.5882352941, alpha: 1)))
                .cornerRadius(15)
                .shadow(color: Color.init(#colorLiteral(red: 0.8, green: 0.8392156863, blue: 0.9254901961, alpha: 1)), radius: 8, x: 0, y: 6)
        }
    }
    
    
    struct Register: View {
        var body: some View {
            HStack{
                
                Text("Daftar")
                    .foregroundColor(Color.init(#colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)))
                
            }.padding(.vertical, 30)
            
        }
    }
    
    struct LoginScreen_Previews: PreviewProvider {
        static var previews: some View {
            LoginScreen()
        }
    }
    
}

