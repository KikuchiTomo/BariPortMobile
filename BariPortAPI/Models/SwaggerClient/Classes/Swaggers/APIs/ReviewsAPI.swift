//
// ReviewsAPI.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation
import Alamofire


open class ReviewsAPI {
    /**
     レビュー一覧取得

     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func getReviews(completion: @escaping ((_ data: [InlineResponse2001]?,_ error: Error?) -> Void)) {
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

     - returns: RequestBuilder<[InlineResponse2001]> 
     */
    open class func getReviewsWithRequestBuilder() -> RequestBuilder<[InlineResponse2001]> {
        let path = "/reviews/list"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil
        let url = URLComponents(string: URLString)


        let requestBuilder: RequestBuilder<[InlineResponse2001]>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }
}
