//
//  TargetWithTimeItemView.swift
//  Habeet
//
//  Created by TEC on 2023/8/18.
//

import SwiftUI

struct TargetItemView: View {
    @EnvironmentObject private var userData: UserData
    
    let targetName: String
    let targetDescribe: String
    let targetId:String
    let targetPoint:String
    let targetStatus:String
    
    @Binding var ifshowTargetNoTimeNull:Bool
    @Binding var ifshowTargetWithTimeNull:Bool
    @Binding var ifshowTargetCompletedNull:Bool
    @Binding var ifshowTargetExpireNull:Bool
    
    @Binding var targetNoTimeNum:Int
    @Binding var targetWithTimeNum:Int
    @Binding var targetCompletedNum:Int
    @Binding var targetExpireNum:Int
    
    @Binding var ifDelete:Bool
    @Binding var deleteSuccess:Bool
    
    @Binding var targetTime:[TargetTime]
    
    @State private var isShowingAlert=false
    
    let targetDataManager = TargetDataManager()
    
    let targetTimeIndex:Int
    
    @Binding var textContant:String
    @Binding var targetCompleted:[TargetTime]
    
    @Binding var dayDifference:Int
    @Binding var timeString:String
    
    @Binding var targetDateInfo:TargetView.TargetDateInfo    
    
    var body: some View {
        HStack{
            Image("targetLogo")
                .resizable()
                .scaledToFit()
                .frame(width: 60,height: 60)
                .padding(.leading,20)
            Button{
                userData.ifTargetUpdate=1                
            }label: {
                VStack(alignment: .leading){
                    Text(targetName)
                        .bold()
                        .font(.title2)
                        .foregroundColor(.black)
                    Text(targetDescribe)
                        .foregroundColor(Color.secondary)
                }.frame(width: 150,height: 120,alignment: .leading)
                    .padding(.leading,10)

            }
            
            Spacer()
            if ifDelete{
                Button{
                    isShowingAlert = true // 点击按钮时设置弹窗显示状态为 true
                }label: {
                    Image("x")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 12,height: 12)
                        .padding(11)
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
                        .shadow(color: Color.black.opacity(0.3), radius: 10, x: 0, y: 5) // 添加阴影效果
                        .padding(.trailing,45)
                }.alert(isPresented: $isShowingAlert) {
                    Alert(
                        title: Text("确定要删除吗？"), // 弹窗标题
                        message: Text("删除后将会从您的目标移除数据"), // 弹窗消息
                        primaryButton: .default(Text("确定"), action: {
                            // 在确定按钮点击时执行的操作
                            deleteTarget(targetName: targetName, ifPoints: 0, targetId: Int(targetId)!, targetStatus: targetStatus,targetTime:targetTime)
                        }),
                        secondaryButton: .cancel(Text("取消")) // 弹窗的取消按钮
                    )
                }
                
            }else{
                VStack{
                    Button{
                        // 在兑换按钮点击时执行的操作
                        if targetStatus=="0"||targetStatus=="1"{
                            deleteTarget(targetName: targetName, ifPoints: 1, targetId: Int(targetId)!, targetStatus: targetStatus,targetTime:targetTime)
                            userData.point+=Int(targetPoint)!
                        }else if targetStatus=="2"{
                            deleteSuccess=true
                            textContant="已经完成啦"
                        }else if targetStatus=="3"{
                            deleteSuccess=true
                            textContant="已经过期啦"
                        }
                        
                    }label: {
                        HStack{
                            Image("Coin")
                            Text("X\(targetPoint)")
                                .bold()
                                .font(.footnote)
                                .foregroundColor(Color.secondary)
                        }.padding([.leading,.trailing],12)
                            .padding([.top,.bottom],6)
                            .background(Color(rgba: (255, 162, 192, 1)))
                            .cornerRadius(22.5)
                        
                    }
                    if targetStatus=="0"{
                        Text("任意时间")
                            .font(.subheadline)
                            .foregroundColor(Color.secondary)
                        
                    }else if targetStatus=="1"{
                        if targetDateInfo.dayDifference<=0{
                            Text(targetDateInfo.timeString)
                                .font(.subheadline)
                                .foregroundColor(Color.secondary)
                        }else{
                            Text("\(targetDateInfo.dayDifference)天")
                                .font(.subheadline)
                                .foregroundColor(Color.secondary)
                            
                        }
                        
                    }else if targetStatus=="2"{
                        Text("完成")
                            .font(.subheadline)
                            .foregroundColor(Color.secondary)
                    }else if targetStatus=="3"{
                        Text("过期")
                            .font(.subheadline)
                            .foregroundColor(Color.secondary)
                    }
                    
                }.frame(width: 100,height: 100,alignment: .leading)
                
            }
            
        }
        .background(Color(UIColor(red: 250/255, green: 250/255, blue: 255/255, alpha: 1)))
        .cornerRadius(22.5)
        .padding([.leading,.trailing],15)
        .padding([.top,.bottom],10)
    }
    func deleteTarget(
        targetName:String,ifPoints:Int,targetId:Int,targetStatus:String,targetTime:[TargetTime]){
            targetDataManager.deleteTarget(userEmail:userData.userEmail,targetName: targetName, ifPoints: ifPoints, targetId: targetId) { error in
                if error == nil {
                    deleteSuccess=true
                    if targetStatus=="0"{
                        targetNoTimeNum-=1
                        if targetNoTimeNum==0{
                            ifshowTargetNoTimeNull=true
                        }
                    }else if targetStatus=="1"{
                        targetWithTimeNum-=1
                        if targetWithTimeNum==0{
                            ifshowTargetWithTimeNull=true
                        }
                    }else if targetStatus=="2"{
                        targetCompletedNum-=1
                        if targetCompletedNum==0{
                            ifshowTargetCompletedNull=true
                        }
                    }else if targetStatus=="3"{
                        targetExpireNum-=1
                        if targetExpireNum==0{
                            ifshowTargetExpireNull=true
                        }
                    }
                    print(targetTimeIndex)
                    self.targetTime.remove(at: targetTimeIndex)
                    if ifPoints==0{
                        textContant="删除目标"
                    }else{
                        targetCompleted.append(targetTime[targetTimeIndex])
                        textContant="完成目标"
                    }
                    print("删除目标成功")
                } else {
                    print("删除目标失败")
                }
            }
        }
}


struct TargetItemView_Previews: PreviewProvider {

    static var previews: some View {
        let targetName="text"
        let targetDescribe="text"
        let targetId="1692785123469447170"
        let targetPoint="2"
        let targetStatus="0"
        
        let ifDelete=Binding.constant(false)
        let deleteSuccess=Binding.constant(false)
        
        let ifshowTargetNoTimeNull=Binding.constant(false)
        let ifshowTargetWithTimeNull=Binding.constant(false)
        let ifshowTargetCompletedNull=Binding.constant(false)
        let ifshowTargetExpireNull=Binding.constant(false)
        
        let targetNoTimeNum=Binding.constant(2)
        let targetWithTimeNum=Binding.constant(2)
        let targetCompletedNum=Binding.constant(2)
        let targetExpireNum=Binding.constant(2)
        
        let defaultTargetTime = TargetTime(targetName: "Default Name", targetDescribe: "Default Description", targetPoint: "0", deadline: "2023-08-19", status: "0", targetId: "defaultID",deadlineString:"defaultID")

        let targetTime=Binding.constant([defaultTargetTime])
        
        let targetTimeIndex=0
        let textContant=Binding.constant("删除目标")
        
        let targetCompleted=Binding.constant([defaultTargetTime])
        
        let dayDifference=Binding.constant(1)
        let timeString=Binding.constant("0")
        
        
        let targetDateInfo = Binding.constant(TargetView.TargetDateInfo(dayDifference: 1, timeString: "0"))
        let showWhichView=Binding.constant(0)
        let timerTriggered=Binding.constant(false)

        
        TargetItemView(targetName: targetName, targetDescribe: targetDescribe, targetId: targetId,targetPoint:targetPoint, targetStatus: targetStatus, ifshowTargetNoTimeNull: ifshowTargetNoTimeNull, ifshowTargetWithTimeNull: ifshowTargetWithTimeNull, ifshowTargetCompletedNull: ifshowTargetCompletedNull, ifshowTargetExpireNull: ifshowTargetExpireNull, targetNoTimeNum: targetNoTimeNum, targetWithTimeNum: targetWithTimeNum, targetCompletedNum: targetCompletedNum, targetExpireNum: targetExpireNum, ifDelete: ifDelete, deleteSuccess: deleteSuccess,targetTime:targetTime,targetTimeIndex:targetTimeIndex,textContant:textContant,targetCompleted:targetCompleted,dayDifference:dayDifference,timeString:timeString,targetDateInfo:targetDateInfo).environmentObject(UserData())
        
    }
}
