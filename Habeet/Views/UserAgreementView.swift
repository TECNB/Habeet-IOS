//
//  UserAgreementView.swift
//  Habeet
//
//  Created by TEC on 2023/8/16.
//

import SwiftUI

struct UserAgreementView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                VStack(alignment:.leading,spacing: 20) {
                    Text("用户协议")
                        .font(.system(size: 30, weight: .bold))
                    Text("欢迎使用 Habeet 小程序（以下简称\"本小程序\"）。在使用本小程序之前，请您仔细阅读以下条款并同意遵守本协议。若您不同意本协议的任何内容，请您立即停止使用本小程序。")
                }
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("1. 用户行为规范")
                        .font(.system(size: 25, weight: .bold))
                    Text("1.1 您在使用本小程序时应遵守相关法律法规，不得利用本小程序从事任何违法违规活动。")
                    Text("1.2 您应对自己在本小程序中的行为负责，包括但不限于自主设定标签、设定个人目标、参与积分奖励、兑换放松项目等。对于您通过本小程序进行的一切行为，您应承担相应的法律责任。")
                }
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("2. 权利声明")
                        .font(.system(size: 25, weight: .bold))
                    Text("2.1 本小程序及其相关内容（包括但不限于文字、图片、图形、音频、视频等）的知识产权归本小程序所有，受到相关法律法规和国际条约的保护。")
                    Text("2.2 未经本小程序书面许可，您不得擅自复制、传播、展示、修改、创作衍生作品或以其他方式使用本小程序的内容。")
                    Text("2.3 您通过本小程序上传的个人信息和数据，您同意授予本小程序合理的使用权，用于提供服务、改进产品和开展市场活动，但不会公开或向第三方提供，除非经过您的明确授权或法律法规要求。")
                }
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("3. 免责声明")
                        .font(.system(size: 25, weight: .bold))
                    Text("3.1 本小程序力求提供准确、完整、及时的信息，但不对信息的准确性、完整性、及时性作任何承诺或保证。")
                    Text("3.2 本小程序不对因您使用本小程序而产生的任何直接或间接损失承担责任，包括但不限于因使用本小程序导致的任何个人隐私泄露、信息丢失、商业损失等。")
                    Text("3.3 本小程序对于第三方提供的链接或资源不进行控制，您应自行承担风险并审慎使用。")
                }
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("4. 协议变更与终止")
                        .font(.system(size: 25, weight: .bold))
                    Text("4.1 本小程序有权随时修改本协议，并在本小程序内公示。如您继续使用本小程序，视为您同意遵守修改后的协议。")
                    Text("4.2 若您违反本协议的任何规定，本小程序有权立即终止向您提供服务，且有权追究您的法律责任。")
                }
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("5. 法律适用与争议解决")
                        .font(.system(size: 25, weight: .bold))
                    Text("5.1 本协议的签订、效力、解释、履行和争议解决均适用中华人民共和国法律。")
                    Text("5.2 若因本协议引起任何争议或纠纷，双方应友好协商解决；协商不成的，任何一方均有权将争议或纠纷提交本小程序所在地的人民法院诉讼解决。")
                }
                Spacer()
            }
            .padding(20)
        }
    }
}

struct UserAgreementView_Previews: PreviewProvider {
    static var previews: some View {
        UserAgreementView()
    }
}
