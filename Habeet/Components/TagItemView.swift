//
//  TagItemView.swift
//  Habeet
//
//  Created by TEC on 2023/8/14.
//

import SwiftUI



struct TagItemView: View {
    @EnvironmentObject private var userData: UserData
    
    @Binding var ifshowTagDetailBNull:Bool
    @Binding var tagNum:Int
    @Binding var deleteSuccess:Bool
    
    @Binding var ifDelete:Bool
    @State private var isShowingAlert:Bool=false // 控制弹窗显示状态
    
    let tagName: String
    let tagDescribe: String
    
    let tagDataManager = TagDataManager()
    
    @Binding var tagWithTime:[TagWithTime]
    
    let tagTimeIndex:Int

    
    var body: some View {
        HStack{
            Image("tagLogo")
                .resizable()
                .scaledToFit()
                .frame(width: 60,height: 60)
                .padding(.trailing,10)

            VStack(alignment: .leading){
                Text(tagName)
                    .bold()
                    .font(.headline)
                    .frame(width: 200,height: 20,alignment: .leading)
                Text(tagDescribe)
                    .frame(width: 200,height: 20,alignment: .leading)
            }
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
                }.alert(isPresented: $isShowingAlert) {
                    Alert(
                        title: Text("确定要删除吗？"), // 弹窗标题
                        message: Text("删除后将会从您的标签移除数据"), // 弹窗消息
                        primaryButton: .default(Text("确定"), action: {
                            // 在确定按钮点击时执行的操作
                            deleteTag(tagName: tagName,tagTimeIndex:tagTimeIndex)
                            
                        }),
                        secondaryButton: .cancel(Text("取消")) // 弹窗的取消按钮
                    )
                }
            }else{
                Button{
                    
                }label: {
                    Image("Edit")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 18,height: 18)
                        .padding(8)
                        .background(.cyan)
                        .cornerRadius(22.5)
                        .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5) // 添加阴影效果
                }
            }
        }
        .frame(width: 350,height: 90)
        .background(Color(UIColor(red: 250/255, green: 250/255, blue: 255/255, alpha: 1)))
        .cornerRadius(22.5)
        .padding(.top,30)
    }
    func deleteTag(tagName:String,tagTimeIndex:Int){
        tagDataManager.deleteTag(tagName: tagName) { error in
            if error == nil {
                deleteSuccess=true
                tagNum-=1
                if tagNum==0{
                    ifshowTagDetailBNull=true
                }
                tagWithTime.remove(at: tagTimeIndex)
                print("删除标签成功")
            } else {
                
                print("删除标签失败")
            }
            
        }
    }
}

struct TagItemView_Previews: PreviewProvider {
    static var previews: some View {
        let ifDelete = Binding.constant(false)
        let deleteSuccess=Binding.constant(false)
        let tagNum=Binding.constant(0)
        let ifshowTagDetailBNull=Binding.constant(false)
        
        let tagName="text"
        let tagDescribe="text"
        
        let defaultTagTime = TagWithTime(id: "defaultValue", tagName: "defaultValue", tagDescribe: "defaultValue", tagHour: "defaultValue", tagMinute: "defaultValue", tagPoint: "defaultValue", ifTagNull: "defaultValue",ifRepeat: "defaultValue")
        let tagTime=Binding.constant([defaultTagTime])
        let tagTimeIndex=0
        
        TagItemView(ifshowTagDetailBNull:ifshowTagDetailBNull,tagNum:tagNum,deleteSuccess:deleteSuccess,ifDelete:ifDelete,tagName:tagName,tagDescribe:tagDescribe,tagWithTime:tagTime,tagTimeIndex:tagTimeIndex).environmentObject(UserData())
    }
}
