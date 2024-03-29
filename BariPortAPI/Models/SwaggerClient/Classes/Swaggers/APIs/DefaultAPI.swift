//
// DefaultAPI.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation
import Alamofire


open class DefaultAPI {
    /**
     プロジェクト一覧取得

     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func getProjects(completion: @escaping ((_ data: [Projects]?,_ error: Error?) -> Void)) {
        getProjectsWithRequestBuilder().execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     プロジェクト一覧取得
     - GET /projects/list

     - examples: [{contentType=application/json, example=[ {
  "name" : "name",
  "description" : "description",
  "company" : {
    "name" : "name",
    "id" : "id"
  },
  "id" : "id"
}, {
  "name" : "name",
  "description" : "description",
  "company" : {
    "name" : "name",
    "id" : "id"
  },
  "id" : "id"
} ]}]

     - returns: RequestBuilder<[Projects]> 
     */
    open class func getProjectsWithRequestBuilder() -> RequestBuilder<[Projects]> {
        let path = "/projects/list"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil
        let url = URLComponents(string: URLString)


        let requestBuilder: RequestBuilder<[Projects]>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }
    /**
     レビュー一覧取得

     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func getReviews(completion: @escaping ((_ data: [Reviews]?,_ error: Error?) -> Void)) {
        getReviewsWithRequestBuilder().execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     レビュー一覧取得
     - GET /reviews/list

     - examples: [{contentType=application/json, example=[ {
  "evaluationScore" : 0,
  "description" : "description",
  "company" : {
    "name" : "name"
  },
  "id" : "id",
  "sendAt" : "sendAt",
  "userId" : "userId"
}, {
  "evaluationScore" : 0,
  "description" : "description",
  "company" : {
    "name" : "name"
  },
  "id" : "id",
  "sendAt" : "sendAt",
  "userId" : "userId"
} ]}]

     - returns: RequestBuilder<[Reviews]> 
     */
    open class func getReviewsWithRequestBuilder() -> RequestBuilder<[Reviews]> {
        let path = "/reviews/list"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil
        let url = URLComponents(string: URLString)


        let requestBuilder: RequestBuilder<[Reviews]>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }
    /**
     テストAPI

     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func hello(completion: @escaping ((_ data: Hello?,_ error: Error?) -> Void)) {
        helloWithRequestBuilder().execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     テストAPI
     - GET /hello

     - examples: [{contentType=application/json, example={
  "message" : "message"
}}]

     - returns: RequestBuilder<Hello> 
     */
    open class func helloWithRequestBuilder() -> RequestBuilder<Hello> {
        let path = "/hello"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil
        let url = URLComponents(string: URLString)


        let requestBuilder: RequestBuilder<Hello>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }
    /**
     チャットルーム参加登録

     - parameter body: (body)  
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func postChatRoomParticipants(body: ChatRoomParticipantsBody, completion: @escaping ((_ data: Void?,_ error: Error?) -> Void)) {
        postChatRoomParticipantsWithRequestBuilder(body: body).execute { (response, error) -> Void in
            if error == nil {
                completion((), error)
            } else {
                completion(nil, error)
            }
        }
    }


    /**
     チャットルーム参加登録
     - POST /chat_room_participants

     - parameter body: (body)  

     - returns: RequestBuilder<Void> 
     */
    open class func postChatRoomParticipantsWithRequestBuilder(body: ChatRoomParticipantsBody) -> RequestBuilder<Void> {
        let path = "/chat_room_participants"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters = JSONEncodingHelper.encodingParameters(forEncodableObject: body)
        let url = URLComponents(string: URLString)


        let requestBuilder: RequestBuilder<Void>.Type = SwaggerClientAPI.requestBuilderFactory.getNonDecodableBuilder()

        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true)
    }
    /**
     メッセージ投稿

     - parameter body: (body)  
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func postMessage(body: MessagesPost, completion: @escaping ((_ data: Void?,_ error: Error?) -> Void)) {
        postMessageWithRequestBuilder(body: body).execute { (response, error) -> Void in
            if error == nil {
                completion((), error)
            } else {
                completion(nil, error)
            }
        }
    }


    /**
     メッセージ投稿
     - POST /message

     - parameter body: (body)  

     - returns: RequestBuilder<Void> 
     */
    open class func postMessageWithRequestBuilder(body: MessagesPost) -> RequestBuilder<Void> {
        let path = "/message"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters = JSONEncodingHelper.encodingParameters(forEncodableObject: body)
        let url = URLComponents(string: URLString)


        let requestBuilder: RequestBuilder<Void>.Type = SwaggerClientAPI.requestBuilderFactory.getNonDecodableBuilder()

        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true)
    }
}
