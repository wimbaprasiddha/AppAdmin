//
//  Summary.swift
//  split-bills
//
//  Created by wimba prasiddha on 26/07/20.
//  Copyright © 2020 wimba prasiddha. All rights reserved.
//

import SwiftUI
import FirebaseFirestore


struct Summary: View {
    
    @State var toggle = false
    @State var doctorName = ""
    @State var polyName = ""
    @State var doctorSchedule = ""
    @State var queue = ""
    @State var patienName = ""
    @State var isLoading = false
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    var doctor: DoctorModel
    
//    private var userDefault = UserDefaults.standard
    
    
//    init(doctor: DoctorModel) {
//        self.doctor = doctor
//
////        self.doctorName = doctor.name
////        self.polyName = doctor.polyName
////        self.doctorSchedule = doctor.schedule
////        self.queue = "\(doctor.queueNumber)"
//
//    }
    
    
    
    var body: some View {
    ZStack{
        VStack{
        doctorDetail(doctorName: $doctorName, poliklinikName: $polyName)
            ZStack{
                Color(#colorLiteral(red: 0.8, green: 0.8392156863, blue: 0.9254901961, alpha: 0.16))
                .frame(width: UIScreen.main.bounds.width, height: 10)
            }
        dataSummary(doctorSchedule: $doctorSchedule, queue: $queue)
            ZStack{
                Color(#colorLiteral(red: 0.8, green: 0.8392156863, blue: 0.9254901961, alpha: 0.16))
                .frame(width: UIScreen.main.bounds.width, height: 10)
            }
            summaryPatient(patientData: $patienName, toggle: self.$toggle)
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
            
            ZStack{
                
                Button(action: {
                    self.requestQueue()
                }) {
                    ambilAntrian()
                        .padding(.vertical, 25)
                }
                
                ActivityIndicator(isAnimating: $isLoading, style: .large)
                
            }
            
            
            
            
            
        }
        
        
    }.onAppear {
        self.requestPatientData()
        self.doctorName = self.doctor.name
        self.polyName = self.doctor.polyName
        self.doctorSchedule = self.doctor.schedule
        self.queue = "\(self.doctor.queueNumber)"
        }
    }
    
    
    
    // TODO: - Send request to backend, this is just a timer
    private func requestQueue(){
        isLoading = true
    
        
        let userID = UserDefaults.standard.value(forKey: UserDefaultKey.userID.rawValue) as! String
        
        
        // get current patiens
        Firestore.firestore().collection("patient").document(doctor.name).getDocument { (snapshot, err) in
                
                if let err = err{
                    print(err.localizedDescription)
                    return
                }
            
            var curentPatient = snapshot!.data()?["patients"] as! [String]
            curentPatient.append("\(userID)+\(self.patienName)")
            
            
            // update patient
            Firestore.firestore().collection("patient").document(self.doctor.name).updateData([
                "patients": curentPatient
            ])
            self.isLoading = false
            self.mode.wrappedValue.dismiss()
            self.mode.wrappedValue.dismiss()

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
                    self.patienName = patientName
                }else{
                   print("GAGAL MENGAMBIL DATA PASIEN")
                }
        }
        
        
    }
}

struct doctorDetail: View {
    @Binding var doctorName: String
    @Binding var poliklinikName: String
    
    var body: some View {
    VStack{
        HStack{
            Image(systemName: "person")
                .foregroundColor(Color.init(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)))
                .frame(width: 80, height: 80)
                .background(Color.init(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)))
                .cornerRadius(10)
                .padding([.leading, .trailing], 20)
                .padding(.top, 2)
                        
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
    @Binding var doctorSchedule: String
    @Binding var queue: String

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
    @Binding var patientData: String
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

//
struct Summary_Previews: PreviewProvider {
    static var previews: some View {
        Summary(doctor: DoctorModel(id: UUID(), name: "", schedule: "", queueNumber: 2, polyID: 0, polyName: ""))
    }
}

//
//struct Summary_Previews: PreviewProvider {
//    static var previews: some View {
//        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
//    }
//}
