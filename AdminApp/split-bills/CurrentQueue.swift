//
//  CurrentQueue.swift
//  split-bills
//
//  Created by wimba prasiddha on 09/08/20.
//  Copyright © 2020 wimba prasiddha. All rights reserved.
//

import SwiftUI
import FirebaseFirestore

struct CurrentQueue: View {
    
    @State var queueName: String = ""
    @State var nextQueue: String = ""
    @State var isLoading = false
    @State var checkInDidTapped: Bool = false
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    var notification = PushNotificationService()
    var networkService = AlamofireNetworkingService()
    var doctor: DoctorModel
    let image = "Register"
    var body: some View {
        
        ZStack{
            
            ActivityIndicator(isAnimating: $isLoading, style: .large)
            
            VStack {
                Image(image)
                    .padding(.top, 100)
                
                listQueue(queueName: $queueName, nextQueue: $nextQueue, checkInDidTapped: $checkInDidTapped.didSet(execute: { (_) in
                    self.requestCheckIn()
                }))
                
            }
            
            
        }
            
            
        .onAppear {
            self.requestListPatient()
        }
    }
    
    
    private func requestListPatient(){
        Firestore.firestore().collection("patient").document(doctor.name).getDocument { (snapshot, err) in
            
            if let err = err{
                print(err.localizedDescription)
                return
            }
        
        let curentPatient = snapshot!.data()?["patients"] as! [String]
            self.queueName = curentPatient.first?.slice(from: "name:", to: "+") ?? ""
            
            self.nextQueue = curentPatient[safe: 1]?.slice(from: "name:", to: "+") ?? ""
            
        }
    }
    
    private func requestCheckIn(){
        isLoading = true
        Firestore.firestore().collection("patient").document(doctor.name).getDocument { (snapshot, err) in
                
                if let err = err{
                    print(err.localizedDescription)
                    return
                }
            
            
            
            var curentPatient = snapshot!.data()?["patients"] as! [String]
            let numberQueue = curentPatient.first?.slice(from: "no:", to: "+") ?? ""
            
            // sisa antrian pasien
            let patientLeft = curentPatient.firstIndex(where: {$0.slice(from: "no:", to: "+") == numberQueue})
            
            curentPatient.removeFirst()
            
            
            // update patient
            Firestore.firestore().collection("patient").document(self.doctor.name).updateData([
                "patients": curentPatient
            ])
            
            
            
            self.isLoading = false
            self.notification.sendPushNotification(
                title: "Sisa antrian",
                body: "Sisa antrian saat ini: \(patientLeft ?? 0)",
                topics: .splitBill)
//            self.toHome()
        }
    }
    
    
    
    private func toHome(){
        self.mode.wrappedValue.dismiss()
        self.mode.wrappedValue.dismiss()
    }
}


struct listQueue: View {
    @Binding var queueName: String
    @Binding var nextQueue: String
    @Binding var checkInDidTapped: Bool
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
                    
                Button(action: {
                    self.checkInDidTapped.toggle()
                }) {
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
//
//struct CurrentQueue_Previews: PreviewProvider {
//    static var previews: some View {
//        CurrentQueue(doctor: DoctorModel(id: UUID(), name: "doctorname", schedule: "10:00", queueNumber: 2, polyID: 2, polyName: "polyname"))
//    }
//}
