//
//  StoreItemView.swift
//  Habeet
//
//  Created by TEC on 2023/8/15.
//

import SwiftUI

struct StoreItemView: View {
    @EnvironmentObject private var userData: UserData
    
    let storeName: String
    let storeDescribe: String
    let storePoint: String
    let storeHour: String
    let storeMinute: String
    
    let storeDataManager = StoreDataManager()
    
    @Binding var storeWithTime:[StoreWithTime]
    @Binding var storeNum:Int
    @Binding var ifEnough:Bool
        
    let storeIndex:Int
    
    @Binding var textContant:String
    @Binding var deleteSuccess:Bool
    
    @Binding var ifshowStoreWithTimeNull:Bool

    
    var body: some View {
        VStack{
            //商品界面的第一个色块
            VStack{
                
            }
                .frame(width: 300,height: 230)
                .background(Color(red: 160/255, green: 215/255, blue: 231/255))
                .cornerRadius(22.5)
                
            VStack(){
                Text(storeName)
                    .bold()
                    .font(.title)
                    .foregroundColor(Color.indigo)
                Text(storeDescribe)
                    .foregroundColor(Color.secondary)
                    .padding(.bottom,10)
                Text("\(storeHour)小时\(storeMinute)分钟")
                    .font(.footnote)
                    .padding(.bottom,10)
                
                Button{
                    deleteStore(storeName: storeName, storeIndex: storeIndex)
                }label: {
                    HStack{
                        Image("Coin")
                        Text("X\(storePoint)")
                            .foregroundColor(Color.white)
                    }
                    .frame(width: 100,height: 30)
                    .background(
                        LinearGradient(
                            gradient: Gradient(
                                colors: [
                                    Color(red: 142/255, green: 150/255, blue: 255/255),
                                    Color(red: 108/255, green: 93/255, blue: 211/255)
                                ]
                            ),
                            startPoint: .trailing,
                            endPoint: .leading
                        )
                    )
                    .cornerRadius(22.5)

                }
                
            }
            
            .frame(width: 280,height: 250)
        }
        .background(Color(UIColor(red: 250/255, green: 250/255, blue: 255/255, alpha: 1)))
        .cornerRadius(22.5)
        .padding(.top,40)
        .overlay {
            Image("storeLogo")
                .resizable()
                .scaledToFit()
                .frame(width: 400,height: 400)
                .padding(.bottom,210)
        }.shadow(color: Color.black.opacity(0.3), radius: 10, x: 0, y: 5) // 添加阴影效果
    }
    func deleteStore(storeName:String,storeIndex:Int){
        storeDataManager.deleteStore(storeName: storeName) { fetchedData,error in
            if let fetchedData = fetchedData {
                if fetchedData.ifEnough!=="1"{
                    storeNum-=1
                    if storeNum==0{
                        ifshowStoreWithTimeNull=true
                    }
                    ifEnough=true
                    print(storeIndex)
                    storeWithTime.remove(at: storeIndex)
                    deleteSuccess=true
                    textContant="兑换成功"
                    userData.point-=Int(storePoint)!
                }else{
                    ifEnough=false
                    deleteSuccess=true
                    textContant="分数不足"
                }
                print(ifEnough)
                
            } else {
                print("Error fetching data: \(error?.localizedDescription ?? "Unknown error")")
            }

        }
    }

}

struct StoreItemView_Previews: PreviewProvider {
    static var previews: some View {
        let storeName="text"
        let storeDescribe="text"
        let storePoint="1"
        let storeHour="2"
        let storeMinute="30"
        
        let storeWithTimeDefault=StoreWithTime(id: "DefaultValue", storeId: "DefaultValue", storeName: "DefaultValue", storeDescribe: "DefaultValue", storePoint: "DefaultValue", storeHour: "DefaultValue", storeMinute: "DefaultValue", ifStoreNull: "DefaultValue", ifEnough: "DefaultValue",ifRepeat:"DefaultValue")
        let storeWithTime=Binding.constant([storeWithTimeDefault])
        let storeNum=Binding.constant(1)
        let ifEnough=Binding.constant(true)
        
        let storeIndex=1
        
        let textContant=Binding.constant("兑换成功")
        let deleteSuccess=Binding.constant(false)
        
        let ifshowStoreWithTimeNull=Binding.constant(false)
        StoreItemView(storeName:storeName,storeDescribe:storeDescribe,storePoint:storePoint,storeHour:storeHour,storeMinute:storeMinute,storeWithTime:storeWithTime,storeNum:storeNum,ifEnough:ifEnough,storeIndex:storeIndex,textContant:textContant,deleteSuccess:deleteSuccess,ifshowStoreWithTimeNull:ifshowStoreWithTimeNull).environmentObject(UserData())
    }
}
