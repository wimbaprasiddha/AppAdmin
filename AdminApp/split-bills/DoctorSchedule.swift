//
//  DoctorSchedule.swift
//  split-bills
//
//  Created by wimba prasiddha on 26/07/20.
//  Copyright © 2020 wimba prasiddha. All rights reserved.
//

import SwiftUI
import FirebaseFirestore

struct DoctorSchedule: View {
    
    @EnvironmentObject var viewRouter: ViewRouter
    
    @State var doctorsToView: [DoctorModel] = []
    @State var doctors: [DoctorModel] = []
    @State var searchText: String = ""
    private var poly: PolyModel
    
    init(poly: PolyModel) {
        self.poly = poly
    }
    
    var body: some View {
        
        //        NavigationView{
        VStack{
            ZStack {
                Color(#colorLiteral(red: 0.8, green: 0.8392156863, blue: 0.9254901961, alpha: 0.1621628853))
                    .edgesIgnoringSafeArea(.vertical)
                VStack{
                    
                    SearchBar(text: $searchText.didSet(execute: { (query) in
                        self.filterDoctor(with: query)
                    }))
                    
                    List(doctorsToView, id: \.id) { doctor in
                        NavigationLink(destination: CurrentQueue(doctor: doctor)) {
                            listDoctor(imageDoctor: "person", nameDoctor: doctor.name, currentQueue: "\(doctor.queueNumber)", schedule: doctor.schedule, polyName: doctor.polyName)
                        }
                        
                    }
                }
                
            }
            .navigationBarTitle(Text(poly.name), displayMode: .inline)
            .onAppear {
                self.fetchDoctors()
                UITableView.appearance().separatorStyle = .none
            }
            
        }
    }
    
    
    private func fetchDoctors(){
        Firestore.firestore().collection("doctor")
            .whereField("polyID", isEqualTo: self.poly.id)
            .getDocuments { (snapshot, err) in
                if let err = err{
                    print("\(err)")
                    return
                }
                var doctors: [DoctorModel] = []
                snapshot?.documents.forEach({ (item) in
                    let data = item.data()
                    doctors.append(DoctorModel(
                        name: data["name"] as! String,
                        schedule: data["schedule"] as! String,
                        queueNumber: data["queueNumber"] as! Int,
                        polyID: data["polyID"] as! Int,
                        polyName: data["polyName"] as! String))
                })
                

                
                
            
                doctors.forEach { (doctor) in
                    Firestore.firestore().collection("patient").document(doctor.name).getDocument { (snapshot, err) in
                        
                        if let err = err{
                            fatalError(err.localizedDescription)
                        }
                        let curentpatient = snapshot!.data()!["patients"] as! [String]
                        var newDoctor = doctor
                        newDoctor.queueNumber = curentpatient.count
                        
                        self.doctors.removeAll(where: {$0.name == doctor.name})
                        self.doctors.append(newDoctor)
                        self.filterDoctor(with: "")
                    }
                    
                }
                    
//                self.doctors = doctors
        }
    }
    
    private func filterDoctor(with query: String){
        if query == ""{
            self.doctorsToView = doctors
        }else{
            self.doctorsToView = doctors.filter({$0.name.lowercased().contains(query.lowercased())})
        }
    }
}


struct listDoctor: View {
    
    var imageDoctor = ""
    var nameDoctor = ""
    var currentQueue = ""
    var schedule = ""
    var polyName = ""
    
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
                                .lineLimit(2)
                            Text(polyName)
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

//struct DoctorSchedule_Previews: PreviewProvider {
//    static var previews: some View {
////        DoctorSchedule(poly: "Poly a")
//    }
//}

struct DoctorSchedule_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
