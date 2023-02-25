//
//  Content1View.swift
//  Minders
//
//  Created by Wang, Yun on 12/8/22.
//

import Foundation
import SwiftUI
enum URLError: Error {
    case BadURL, BadData}


struct Content1View: View {
    @EnvironmentObject var itemsVM: JokeVM
    @Environment(\.dismiss) var dismiss
    @ObservedObject var notificationMgr = NotificationMgr()
    private var typeArray =  ["animal","career","celebrity","dev","explicit","fashion","food","history","money","movie","music","political","religion","science","sport","travel"]
    @AppStorage("name") var typeSelection = "animal"
    @State private var addPresenting = false
    @State private var showProgress: Bool = false
    @State private var result: element?
    @AppStorage("isHoliday") var isHoliday = false
    @State private var Created_at = ""
    @State private var Icon_url = ""
    @State private var Id = ""
    @State private var Updated_at = ""
    @State private var Value = ""
    @State private var Url = ""
    @State private var date = Date()
    let urlHelper = URLHelper()
        var body: some View {
            NavigationView {
            ZStack{
                if(isHoliday){
                    Image("Tree")
                        .resizable()
                        .scaledToFill()
                        .edgesIgnoringSafeArea(.all)
                        .opacity(0.3)
                        .offset(x:-80)
                }
                
            VStack{
            Text("Let's explore some jokes")
                    .font(.system(size:30))
                Spacer()
            //Section("ACTIVITY TYPE") {
                
                    //Text("Let's pick a category at first")
                    //    .font(.system(size: 10 ))
                    Picker(selection: $typeSelection, label: Text("CATRGORY")) {
                                ForEach(typeArray, id:\.self) { index in
                                    Text(index)
                                        .font(.body)
                                        .multilineTextAlignment(.center)
                                    
                                }
                            }.pickerStyle(WheelPickerStyle())
                            .frame(width: 200, height: 30, alignment: .center)

                
                    //}
                Spacer()
            if showProgress == true {
                    Spacer()
                    ProgressView()
                    Spacer()
                    } else {
                    if(result? .value ?? "" == ""){
                        Text("No activity found with the specified parameters")
                            .font(.title )
                            .multilineTextAlignment(.center)
                            Spacer()
                    }
                            //https://api.chucknorris.io
                        //https://betterprogramming.pub/swiftui-alerts-pickers-and-gradients-29b9ee5ff8f3
                        else{
                        Text(result? .value ?? "")
                        Text(Value)
                            //Text(result? .id ?? "")
                            //Text(result? .icon_url ?? "")
                            //Text(result? .updated_at ?? "")
                            //Text(result? .created_at ?? "")
                            //Text(result? .url ?? "")
                                .font(.system(size:10))
                                .multilineTextAlignment(.center)
                            Spacer()
                        }
                    }
                Button(action: {
                    Task{
                    showProgress = true
                    result = nil
                    await load1Symbol()
                    showProgress = false
                        Created_at = result? .created_at ?? ""
                        Icon_url = result? .icon_url ?? ""
                        Id = result? .id ?? ""
                        Value = result? .value ?? ""
                        Updated_at = result? .updated_at ?? ""
                        Url = result? .url ?? ""
                        
                        itemsVM.add(createdAt: Created_at, iconUrl: Icon_url , id: Id,updatedAt: Updated_at, value: Value, url: Url, type: typeSelection, alert: date )
                        dismiss()
                }
                }, label: {
                    Text("Create a joke")                })
                
                Spacer()
            }}
            }}

func load1Symbol() async {
    do {
        print("begin load\n")
        let parameterArray = ["name" : typeSelection]
        result = try await urlHelper.fetchResult(params:parameterArray)
        print("end load\n")
    } catch {
        print(String(describing: error))
    }}
}

struct Content1View_Previews: PreviewProvider {
    static var previews: some View {
        Content1View()
    }
}


