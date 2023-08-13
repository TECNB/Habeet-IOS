//
//  TargetDataManager.swift
//  Habeet
//
//  Created by TEC on 2023/8/15.
//

import Foundation


struct TargetResponseData: Decodable {
    let data: [TargetTime]
}
struct TargetResponseData2: Decodable {
    let data: TargetTime
}


struct TargetTime: Decodable, Identifiable {
    let targetName: String?
    let targetDescribe: String?
    let targetPoint: String?
    let deadline:String?
    let status:String?
    let targetId:String?
    let deadlineString:String?
    
    var id: String? { // Add a computed property for Identifiable's id
        return targetId
    }
}

class TargetDataManager{
    // 获取目标数据的方法
    func fetchTargetData(userEmail:String,completion: @escaping ([TargetTime]?, Error?) -> Void) {
        // 定义请求的 URL
        guard let url = URL(string: "https://tengenchang.top/target/get") else {
            completion(nil, nil) // 处理错误情况
            return
        }
        
        // 准备请求参数
        let userEmail = userEmail
        let ifTargetUpdate=0
        
        //转化为JSON格式
        let parameters: [String: Any] = ["userEmail": userEmail, "ifTargetUpdate": ifTargetUpdate]
        // 将请求参数转换为 JSON 数据
        let jsonData = try? JSONSerialization.data(withJSONObject: parameters)
        // 创建一个 URL 请求
            
        var request = URLRequest(url: url)
            
        request.httpMethod = "POST" // 设置请求方法为 POST
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData // 设置请求体为 JSON 数据
            
        // 创建 URLSession 数据任务
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                do {
                    // 解码服务器响应的数据
                    let decodedResponse = try JSONDecoder().decode(TargetResponseData.self, from: data)
                        completion(decodedResponse.data, nil)
                } catch {
                    print("JSON decoding error: \(error)")
                    completion(nil, error)
                }
            } else if let error = error {
                completion(nil, error)
            }
        }.resume() // 启动数据任务
    }
    // 删除标签的方法
    func deleteTarget(userEmail:String,targetName: String,ifPoints:Int,targetId:Int, completion: @escaping (Error?) -> Void) {
        // 定义请求的 URL
        guard let url = URL(string: "https://tengenchang.top/target/delete") else {
            completion(nil) // 处理错误情况
            return
        }
        
        // 准备请求参数
        let userEmail = userEmail
        let targetName = targetName
        let ifPoints=ifPoints
        let targetId=targetId
        
        //转化为JSON格式
        let parameters: [String: Any] = ["userEmail": userEmail, "targetName": targetName,"ifPoints":ifPoints,"targetId":targetId]
        // 将请求参数转换为 JSON 数据
        let jsonData = try? JSONSerialization.data(withJSONObject: parameters)
        // 创建一个 URL 请求
            
        var request = URLRequest(url: url)
            
        request.httpMethod = "POST" // 设置请求方法为 POST
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData // 设置请求体为 JSON 数据
        // 创建 URLSession 数据任务
        URLSession.shared.dataTask(with: request) { _, _, error in
            if let error = error {
                completion(error)
            } else {
                completion(nil)
            }
        }.resume() // 启动数据任务
    }
    // 保存目标的方法
    func saveTarget(userEmail:String,targetName: String,targetDescribe:String,targetPoint:Int,deadlineString:String,ifTargetUpdate:Int, completion: @escaping (TargetTime?,Error?) -> Void) {
        // 定义请求的 URL
        guard let url = URL(string: "https://tengenchang.top/target/save") else {
            completion(nil,nil) // 处理错误情况
            return
        }
        
        // 准备请求参数
        let userEmail = userEmail
        
        //转化为JSON格式
        let parameters: [String: Any] = ["userEmail": userEmail, "ifTargetUpdate": ifTargetUpdate,"targetName":targetName,"targetDescribe":targetDescribe,"targetPoint":targetPoint,"deadlineString":deadlineString]
        // 将请求参数转换为 JSON 数据
        let jsonData = try? JSONSerialization.data(withJSONObject: parameters)
        // 创建一个 URL 请求
            
        var request = URLRequest(url: url)
            
        request.httpMethod = "POST" // 设置请求方法为 POST
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData // 设置请求体为 JSON 数据
        
        // 创建 URLSession 数据任务
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                do {
                    // 解码服务器响应的数据
                    let decodedResponse = try JSONDecoder().decode(TargetResponseData2.self, from: data)
                        completion(decodedResponse.data, error)
                } catch {
                    print("JSON decoding error: \(error)")
                    completion(nil, error)
                }
            } else if let error = error {
                completion(nil, error)
            }
        }.resume() // 启动数据任务
    }

}

