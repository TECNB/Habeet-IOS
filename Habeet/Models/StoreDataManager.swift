//
//  StoreDataManager.swift
//  Habeet
//
//  Created by TEC on 2023/8/15.
//

import Foundation

struct StoreResponseData: Decodable {
    let data: [StoreWithTime]
}
struct StoreResponseDataD: Decodable {
    let data: StoreWithTime
}


struct StoreWithTime: Decodable,Identifiable {
    let id: String? // Change the type to String
    
    let storeId: String?
    let storeName: String?
    let storeDescribe: String?
    let storePoint: String?
    let storeHour: String?
    let storeMinute: String?
    let ifStoreNull:String?
    let ifEnough:String?
    let ifRepeat:String?
    // 其他字段省略，需要的话可以添加
        
    var identifiableID: String? { // Add a computed property for Identifiable's id
        return storeId
    }
}

class StoreDataManager{
    // 获取商店数据的方法
    func fetchStoreData(userEmail:String,completion: @escaping ([StoreWithTime]?, Error?) -> Void) {
        // 定义请求的 URL
        guard let url = URL(string: "https://tengenchang.top/store/get") else {
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
                    let decodedResponse = try JSONDecoder().decode(StoreResponseData.self, from: data)
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
    // 删除商品的方法
    func deleteStore(storeName: String, completion: @escaping (StoreWithTime?, Error?) -> Void) {
        // 定义请求的 URL
        guard let url = URL(string: "https://tengenchang.top/store/delete") else {
            completion(nil,nil) // 处理错误情况
            return
        }
        // 准备请求参数
        let storeName = storeName
        //转化为JSON格式
        let parameters: [String: Any] = ["storeName": storeName]
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
                    let decodedResponse = try JSONDecoder().decode(StoreResponseDataD.self, from: data)
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
    
    // 保存商品的方法
    func saveStore(userEmail:String,storeName: String,storeDescribe:String,storePoint:Int,storeHour:Int,storeMinute:Int,ifStoreUpdate:Int, completion: @escaping (StoreWithTime?,Error?) -> Void) {
        // 定义请求的 URL
        guard let url = URL(string: "https://tengenchang.top/store/save") else {
            completion(nil,nil) // 处理错误情况
            return
        }
        
        // 准备请求参数
        let userEmail = userEmail
        
        //转化为JSON格式
        let parameters: [String: Any] = ["userEmail": userEmail, "ifStoreUpdate": ifStoreUpdate,"storeName":storeName,"storeDescribe":storeDescribe,"storePoint":storePoint,"storeHour":storeHour,"storeMinute":storeMinute]
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
                    let decodedResponse = try JSONDecoder().decode(StoreResponseDataD.self, from: data)
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

}

