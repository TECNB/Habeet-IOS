//
//  TargetMenuItem.swift
//  Habeet
//
//  Created by TEC on 2023/8/22.
//

import SwiftUI


struct TargetMenuItem: View {
    @EnvironmentObject private var userData: UserData
    
    let targetName: String
    let targetId:String
    let targetPoint:String
    let targetStatus:String

    @Binding var target:[TargetTime]
    @Binding var targetDateInfo:TargetView.TargetDateInfo
    
    let targetDataManager = TargetDataManager()
    
    let targetIndex:Int
    
    @Binding var deleteSuccess:Bool
    @Binding var targetNoTimeNum:Int
    @Binding var targetWithTimeNum:Int
    @Binding var ifshowTargetMenuNull:Bool
    @Binding var textContant:String
    
    
    
    var body: some View {
        if targetStatus=="0"{
            Button{
                // 在确定按钮点击时执行的操作
                deleteTarget(targetName: targetName, ifPoints: 1, targetId: Int(targetId)!, targetStatus: targetStatus,targetTime:target)
                userData.point+=Int(targetPoint)!
            }label: {
                HStack{
                    Text(targetName)
                        .foregroundColor(.secondary)
                    Spacer()
                    Image("Coin")
                    Text("X\(targetPoint)")
                        .foregroundColor(.secondary)
                        .font(.footnote)
                        .padding(.leading,-5).padding(.trailing,5)
                    Text("任意时间")
                        .bold()
                        .foregroundColor(.secondary)
                        .font(.footnote)
                        .frame(width: 80,alignment: .leading)
                }.padding(.bottom,15)
                
            }
            
        }else{
            Button{
                // 在确定按钮点击时执行的操作
                deleteTarget(targetName: target[targetIndex].targetName ?? "0", ifPoints: 1, targetId: Int(target[targetIndex].targetId ?? "0") ?? 0, targetStatus: target[targetIndex].status ?? "0",targetTime:target)
                
            }label: {
                HStack{
                    Text(targetName)
                        .foregroundColor(.secondary)
                    Spacer()
                    Image("Coin")
                    Text("X\(targetPoint)")
                        .foregroundColor(.secondary)
                        .font(.footnote)
                        .padding(.leading,-5).padding(.trailing,5)
                    
                    if targetDateInfo.dayDifference<=0{
                        Text("今日\(targetDateInfo.timeString)")
                            .bold()
                            .foregroundColor(.secondary)
                            .font(.footnote)
                            .frame(width: 80,alignment: .leading)
                        
                    }else{
                        Text("还有\(targetDateInfo.dayDifference)天")
                            .bold()
                            .foregroundColor(.secondary)
                            .font(.footnote)
                            .frame(width: 80,alignment: .leading)
                    }
                }.padding(.bottom,15)
            }
        }
    }
    
    func deleteTarget(
        targetName:String,ifPoints:Int,targetId:Int,targetStatus:String,targetTime:[TargetTime]){
                        
            targetDataManager.deleteTarget(userEmail:userData.userEmail,targetName: targetName, ifPoints: ifPoints, targetId: targetId) { error in
                if error == nil {
                    deleteSuccess=true
                    
                    if targetStatus=="0"{
                        targetNoTimeNum-=1
                    }else if targetStatus=="1"{
                        targetWithTimeNum-=1
                    }
                    if targetNoTimeNum==0&&targetWithTimeNum==0{
                        ifshowTargetMenuNull=true
                    }
                    
                    print(targetIndex)
                    
                    target.remove(at: targetIndex)
                    
                    textContant="完成目标"
                    
                    print("删除目标成功")
                } else {
                    print("删除目标失败")
                    
                }
            }
        }
}

struct TargetMenuItem_Previews: PreviewProvider {
    static var previews: some View {
        let targetName="text"
        let targetId="0"
        let targetPoint="1"
        let targetStatus="1"

        
        let target=Binding.constant([TargetTime(targetName: "DefaultValue", targetDescribe: "DefaultValue", targetPoint: "1", deadline: "DefaultValue", status: "1", targetId: "DefaultValue",deadlineString: "DefaultValue")])
        let targetDateInfo = Binding.constant(TargetView.TargetDateInfo(dayDifference: 1, timeString: "22:05"))
        
        let targetIndex=0
        
        let deleteSuccess=Binding.constant(false)
        let targetNoTimeNum=Binding.constant(1)
        let targetWithTimeNum=Binding.constant(1)
        let ifshowTargetMenuNull=Binding.constant(false)
        let textContant=Binding.constant("完成目标")


        TargetMenuItem(targetName:targetName,targetId:targetId,targetPoint:targetPoint,targetStatus:targetStatus,target:target,targetDateInfo:targetDateInfo,targetIndex:targetIndex,deleteSuccess:deleteSuccess,targetNoTimeNum:targetNoTimeNum,targetWithTimeNum:targetWithTimeNum,ifshowTargetMenuNull:ifshowTargetMenuNull,textContant:textContant)
    }
}
