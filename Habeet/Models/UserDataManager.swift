//
//  UserDataManager.swift
//  Habeet
//
//  Created by TEC on 2023/8/15.
//

import Foundation

struct UserResponseData: Decodable {
    let code: String?
    let data: UserRecordData
}
struct UserResponseDataCode: Decodable {
    let data: String
}

struct PointRecordResponseData: Decodable {
    let data: PointRecordData
}

struct UserRecordData: Decodable {
    let userName:String?
    let point:String?
}


class UserData: ObservableObject {
    @Published var userEmail: String = ""
    @Published var point: Int = 0
    @Published var userName:String=""
    @Published var ifLoginUpdate:Int=0
    @Published var ifTargetUpdate:Int=0
    @Published var ifTagUpdate:Int=0
    @Published var ifStoreUpdate:Int=0
}

class PointRecordData:Decodable{
    let userTimeP, pointAll, progress: String
    let pointInsistence, pointAverage, completeTarget, completeTargetRate: String
}


class UserDataManager{
    func checkEmail(email: String, completion: @escaping (Int) -> Void) {
        guard let url = URL(string: "https://tengenchang.top/user/home")
        else {
            completion(12) // URL错误的情况下的备用值
            return
        }
        
        // 准备请求参数
        let userEmail = email
        // 将请求参数转换为 JSON 数据
        let jsonData =  userEmail.data(using: .utf8)
        // 创建一个 URL 请求
        var request = URLRequest(url: url)
            
        request.httpMethod = "POST" // 设置请求方法为 POST
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData // 设置请求体为 JSON 数据

        // 假设您使用URLSession进行API请求
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                do {
                    let decodedData = try JSONDecoder().decode(UserResponseData.self, from: data)
                    if let code = decodedData.code {
                        DispatchQueue.main.async {
                            if code == "nil" {
                                completion(12)
                            } else {
                                completion(11)
                            }
                        }
                    }
                } catch {
                    print(error)
                    completion(12) // 错误情况
                }
            }
        }.resume()
        
    }
    func checkPassword(email: String,password:String, completion: @escaping (Int) -> Void) {
        guard let url = URL(string: "https://tengenchang.top/user/login")
        else {
            completion(404) // URL错误的情况下的备用值
            return
        }
        
        // 准备请求参数
        let userEmail = email
        let userPassword = password
        //转化为JSON格式
        let parameters: [String: Any] = ["userEmail": userEmail, "userPassword": userPassword]
        // 将请求参数转换为 JSON 数据
        let jsonData = try? JSONSerialization.data(withJSONObject: parameters)
        // 创建一个 URL 请求
        var request = URLRequest(url: url)
            
        request.httpMethod = "POST" // 设置请求方法为 POST
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData // 设置请求体为 JSON 数据

        // 假设您使用URLSession进行API请求
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                do {
                    let decodedData = try JSONDecoder().decode(UserResponseData.self, from: data)
                    if let code = decodedData.code {
                        DispatchQueue.main.async {
                            if code == "nil" {
                                completion(404)
                            } else {
                                completion(0)
                            }
                        }
                    }else{
                        completion(404) // 错误情况
                    }
                } catch {
                    print(error)
                    completion(404) // 错误情况
                }
            }
        }.resume()
    }
    func getUserData(email: String,password:String, completion: @escaping (UserRecordData?,Error?) -> Void) {
        guard let url = URL(string: "https://tengenchang.top/user/login")
        else {
            completion(nil,nil) // URL错误的情况下的备用值
            return
        }
        
        // 准备请求参数
        let userEmail = email
        let userPassword = password
        //转化为JSON格式
        let parameters: [String: Any] = ["userEmail": userEmail, "userPassword": userPassword]
        // 将请求参数转换为 JSON 数据
        let jsonData = try? JSONSerialization.data(withJSONObject: parameters)
        // 创建一个 URL 请求
        var request = URLRequest(url: url)
            
        request.httpMethod = "POST" // 设置请求方法为 POST
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData // 设置请求体为 JSON 数据

        // 假设您使用URLSession进行API请求
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                do {
                    // 解码服务器响应的数据
                    let decodedResponse = try JSONDecoder().decode(UserResponseData.self, from: data)
                        completion(decodedResponse.data, nil)
                } catch {
                    print("JSON decoding error: \(error)")
                    completion(nil, error)
                }
            } else if let error = error {
                completion(nil, error)
            }
        }.resume()
    }
    func sign(email: String,userName:String,password:String,userCode:String,ifUpdate:Int, completion: @escaping (Int) -> Void) {
        guard let url = URL(string: "https://tengenchang.top/user/sign")
        else {
            completion(404) // URL错误的情况下的备用值
            return
        }
        
        // 准备请求参数
        let userEmail = email
        let userName = userName
        let userPassword = password
        let picUrl="https://mmbiz.qpic.cn/mmbiz/icTdbqWNOwNRna42FI242Lcia07jQodd2FJGIYQfG0LAJGFxM4FbnQP6yfMxBgJ0F3YRqJCJ1aPAK2dQagdusBZg/0"
        let userCode=userCode
        let ifUpdate=ifUpdate
        
        //转化为JSON格式
        let parameters: [String: Any] = ["userEmail": userEmail,"userName":userName, "userPassword": userPassword,"picUrl":picUrl,"userCode":userCode,"ifUpdate":ifUpdate]
        // 将请求参数转换为 JSON 数据
        let jsonData = try? JSONSerialization.data(withJSONObject: parameters)
        // 创建一个 URL 请求
        var request = URLRequest(url: url)
            
        request.httpMethod = "POST" // 设置请求方法为 POST
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData // 设置请求体为 JSON 数据

        // 假设您使用URLSession进行API请求
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                completion(0)
            }else{
                print("JSON decoding error: \(String(describing: error))")
                completion(404)

            }
        }.resume()
    }
    func code(userEmail: String,ifUpdate:Int, completion: @escaping (String) -> Void) {
        guard let url = URL(string: "https://tengenchang.top/user/code")
        else {
            completion("404") // URL错误的情况下的备用值
            return
        }
        
        // 准备请求参数
        let userEmail = userEmail
        let ifUpdate=ifUpdate
        
        //转化为JSON格式
        let parameters: [String: Any] = ["userEmail": userEmail,"ifUpdate":ifUpdate]
        // 将请求参数转换为 JSON 数据
        let jsonData = try? JSONSerialization.data(withJSONObject: parameters)
        // 创建一个 URL 请求
        var request = URLRequest(url: url)
            
        request.httpMethod = "POST" // 设置请求方法为 POST
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData // 设置请求体为 JSON 数据

        // 假设您使用URLSession进行API请求
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                do {
                    // 解码服务器响应的数据
                    let decodedResponse = try JSONDecoder().decode(UserResponseDataCode.self, from: data)
                    print("userEmail:",userEmail)
                    print("decodedResponse.data:",decodedResponse.data)
                    completion(decodedResponse.data)
                } catch {
                    print("JSON decoding error: \(error)")
                    completion("404")
                }
            }
        }.resume()
    }


    // 获取用户目标完成情况的方法
    func fetchPointRecordData(userEmail:String,userTimeP:String,completion: @escaping (PointRecordData?, Error?) -> Void) {
        // 定义请求的 URL
        guard let url = URL(string: "https://tengenchang.top/pointRecord/get") else {
            completion(nil, nil) // 处理错误情况
            return
        }
        
        // 准备请求参数
        let userEmail = userEmail
        let userTimeP=userTimeP
        
        //转化为JSON格式
        let parameters: [String: Any] = ["userEmail": userEmail, "userTimeP": userTimeP]
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
                    let decodedResponse = try JSONDecoder().decode(PointRecordResponseData.self, from: data)
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
