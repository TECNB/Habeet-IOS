//
//  TagDataManager.swift
//  Habeet
//
//  Created by TEC on 2023/8/14.
//

import Foundation


struct TagResponseData: Decodable {
    let data: [TagWithTime]
}
struct TagResponseData2: Decodable {
    let data: TagWithTime
}


struct TagWithTime: Decodable, Identifiable {
    let id: String?  // 注意这里的 id 是 String 类型，因为服务器返回的数据是 String
    let tagName: String?
    let tagDescribe: String?
    let tagHour: String?
    let tagMinute: String?
    let tagPoint: String?
    let ifTagNull:String?
    let ifRepeat:String?
}

class TagDataManager {
    // 获取标签数据的方法
    func fetchTagData(userEmail:String,completion: @escaping ([TagWithTime]?, Error?) -> Void) {
        // 定义请求的 URL
        guard let url = URL(string: "https://tengenchang.top/tag/get") else {
            completion(nil, nil) // 处理错误情况
            return
        }
        
        // 准备请求参数
        let userEmail = userEmail
        // 将请求参数转换为 JSON 数据
        let jsonData =  userEmail.data(using: .utf8)
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
                    let decodedResponse = try JSONDecoder().decode(TagResponseData.self, from: data)
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
    func deleteTag(tagName: String, completion: @escaping (Error?) -> Void) {
        // 定义请求的 URL
        guard let url = URL(string: "https://tengenchang.top/tag/delete") else {
            completion(nil) // 处理错误情况
            return
        }
        
        // 准备请求参数
        let tagName = tagName
        
        // 将请求参数转换为 JSON 数据
        let jsonData = tagName.data(using: .utf8)
        
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
    // 保存标签的方法
    func saveTag(userEmail:String,tagName: String,tagDescribe:String,tagPoint:Int,tagHour:Int,tagMinute:Int,ifTagUpdate:Int, completion: @escaping (TagWithTime?,Error?) -> Void) {
        // 定义请求的 URL
        guard let url = URL(string: "https://tengenchang.top/tag/save") else {
            completion(nil,nil) // 处理错误情况
            return
        }
        
        // 准备请求参数
        let userEmail = userEmail
        
        //转化为JSON格式
        let parameters: [String: Any] = ["userEmail": userEmail, "ifTagUpdate": ifTagUpdate,"tagName":tagName,"tagDescribe":tagDescribe,"tagPoint":tagPoint,"tagHour":tagHour,"tagMinute":tagMinute]
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
                    let decodedResponse = try JSONDecoder().decode(TagResponseData2.self, from: data)
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
    // 完成标签的方法
    func finishTag(tagName: String, completion: @escaping (Error?) -> Void) {
        // 定义请求的 URL
        guard let url = URL(string: "https://tengenchang.top/tag/finish") else {
            completion(nil) // 处理错误情况
            return
        }
        
        // 准备请求参数
        let tagName = tagName
        
        //转化为JSON格式
        let parameters: [String: Any] = ["tagName": tagName]
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
}
