//
//  TargetNav1View.swift
//  Habeet
//
//  Created by TEC on 2023/8/19.
//
import SwiftUI

struct TargetNav1View: View {
    let selectedDate: Date=Date() // 接收初始日期的参数
    
    private let calendar = Calendar.current
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "E" // 日期格式化器，用于获取星期几的缩写
        return formatter
    }()
    
    @State private var selectedDayIndex = 0 // 当前选中的VStack索引
    
    var onDateSelected: ((Date) -> Void)? // 用于接收选中日期的闭包
    // 初始化时执行计算逻辑

    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 18) {
                ForEach(0..<30) { index in
                    VStack {
                        Text(self.dayName(for: index))
                            .foregroundColor(
                                self.selectedDayIndex == index ? .black : .secondary
                            )
                            .font(.system(size: 12)) // 设置星期几文本的字体大小
                        Text(self.dayNumber(for: index))
                            .frame(width: 36, height: 36)
                            .foregroundColor(Color(rgba: (207, 200, 255, 1)))
                            .background(
                                LinearGradient(
                                    gradient: Gradient(
                                        colors: self.gradientColors(for: index)
                                    ),
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                            )
                            .cornerRadius(22.5)
                        
                            // 添加点击手势
                            .onTapGesture {
                                self.selectedDayIndex = index // 更新选中的索引
                                if let selectedDate = self.calendar.date(byAdding: .day, value: index, to: Date()) {
                                    self.onDateSelected?(selectedDate) // 调用闭包，并传递选中的日期
                                }
                                
                            }
                    }
                    .cornerRadius(22.5) // 设置VStack的圆角
                }
            }
            .padding(.top, 20) // 设置顶部内边距
        }.padding([.leading,.trailing],20)
    }
    
    private func dayName(for index: Int) -> String {
        let currentDate = calendar.date(byAdding: .day, value: index, to: Date()) ?? Date()
        return dateFormatter.string(from: currentDate) // 获取星期几的缩写文本
    }
    
    private func dayNumber(for index: Int) -> String {
        let currentDate = calendar.date(byAdding: .day, value: index, to: Date()) ?? Date()
        let day = calendar.component(.day, from: currentDate) // 获取日期的天数部分
        return "\(day)" // 将天数转换为字符串
    }
    
    private func gradientColors(for index: Int) -> [Color] {
        if self.selectedDayIndex == index {
            return [
                Color(red: 142/255, green: 150/255, blue: 255/255),
                Color(red: 108/255, green: 93/255, blue: 211/255)
            ] // 如果选中，返回选中时的渐变色
        } else {
            return [
                Color.clear,
                Color.clear
            ] // 如果未选中，返回透明颜色
        }
    }
}
struct TargetNav1View_Previews: PreviewProvider {
    static var previews: some View {
        TargetNav1View()
    }
}
