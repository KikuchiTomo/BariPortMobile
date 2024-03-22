import Foundation
import Alamofire

public class BariPortAPIClient{
    public static let shared: BariPortAPIClient = BariPortAPIClient()
    
    init(){
        
    }
    
    public func getHello() async throws -> Hello{
        // async/await と throwsできるようにする
        return try await withCheckedThrowingContinuation{ config in
            BariPortAPI.HelloAPI.hello(completion: { data, error in
                if let error = error{
                    config.resume(throwing: error)
                }else if let data = data{
                    // dataの方がInlineResponse200になってしまっているのはSweggerの定義ファイルが間違っているからなので，直してもらう
                    config.resume(returning: .init(message: data.message))
                }
            })
        }
    }
    
    // 上記を参考にAPIごとに記述していく
}
