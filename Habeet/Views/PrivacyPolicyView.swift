//
//  PrivacyPolicyView.swift
//  Habeet
//
//  Created by TEC on 2023/8/16.
//

import SwiftUI

struct PrivacyPolicyView: View {
    var body: some View {
        ScrollView {
                    VStack(spacing: 40) {
                        VStack(alignment:.leading,spacing: 20) {
                            Text("隐私政策")
                                .font(.system(size: 30, weight: .bold))
                            Text("感谢您选择使用 Habeet 小程序（以下简称\"本小程序\"）。为了向您提供更好的服务，我们将依据本隐私政策为您提供详细说明，包括我们如何收集、使用、储存和保护您的个人信息。请您在使用本小程序之前，仔细阅读并同意本隐私政策的所有内容。")
                        }
                        
                        VStack(alignment: .leading, spacing: 10) {
                            Text("1. 信息收集与使用")
                                .font(.system(size: 25, weight: .bold))
                            Text("1.1 我们仅收集您在注册和使用本小程序时主动提供的个人信息，包括但不限于您的姓名、联系方式等，以便为您提供更好的服务和支持。")
                            Text("1.2 为了改进本小程序的用户体验和服务质量，我们可能会收集您在使用本小程序过程中产生的操作信息、设备信息和日志信息，这些信息将用于统计分析和系统优化，但不会直接关联到您的个人身份。")
                        }
                        
                        VStack(alignment: .leading, spacing: 10) {
                            Text("2. 信息存储与保护")
                                .font(.system(size: 25, weight: .bold))
                            Text("2.1 我们采取严格的安全措施来保护您的个人信息，防止未经授权的访问、使用、修改或泄露。")
                            Text("2.2 您的个人信息将存储在我们的安全服务器上，并仅在实现本隐私政策所述目的的范围内使用。")
                        }
                        
                        VStack(alignment: .leading, spacing: 10) {
                            Text("3. 信息共享与披露")
                                .font(.system(size: 25, weight: .bold))
                            Text("3.1 我们承诺不会将您的个人信息出售、出租或交易给任何第三方。")
                            Text("3.2 在法律法规允许的范围内，我们可能会与合作伙伴共享必要的个人信息，以提供更好的服务和支持，但我们将与其签订保密协议并要求其按照我们的指示、本隐私政策以及其他任何相关的保密和安全措施来处理这些信息。")
                        }
                        
                        VStack(alignment: .leading, spacing: 10) {
                            Text("4. 隐私政策的变更")
                                .font(.system(size: 25, weight: .bold))
                            Text("我们可能会不时地修改本隐私政策的内容。对于重大变更，我们将提供显著的通知或在本小程序上发布告示。您继续使用本小程序将被视为您接受修订后的隐私政策。")
                        }
                        
                        VStack(alignment: .leading, spacing: 10) {
                            Text("如您对本协议或隐私政策有任何疑问、意见或投诉，请联系我们。感谢您的支持和信任！")
                        }
                        
                        Spacer()
                    }
                    .padding(20)
                }    }
}

struct PrivacyPolicyView_Previews: PreviewProvider {
    static var previews: some View {
        PrivacyPolicyView()
    }
}
