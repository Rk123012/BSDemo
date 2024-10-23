
import UIKit

public typealias BSResponseInformation = (Any?, Error?) -> Void

class BSRequest: NSObject {
    
    static let shared : BSRequest = BSRequest()
    
    private override init() {
        
    }
    
    var endPoint : String = ""
    var httpMethod : String = ""
    var headers = [String:String]()
    var information : Any?
    var parameters = [String : Any]()
    var timeoutInterval : TimeInterval = 30
    
    private var completion : BSResponseInformation?
    private var isShowActivityIndicator : Bool = false
    
    func callAPI(urlExtension : String, method: String, parametersDict : Dictionary<String,Any>?, completion: @escaping(Dictionary<String,Any>?, Error?, Bool)->Void){
    
        if let url = URL(string: BSConstants.baseUrl + urlExtension ){
            var request = URLRequest(url: url)
            request.httpMethod = method
            request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
            request.setValue("text/plain; charset=utf-8", forHTTPHeaderField: "Accept")
            if let params = parametersDict{
                let jsonData =  try! JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
                request.httpBody = jsonData
                let parameters: [String : Any] = params
                print(parameters)

            }
            print(method)
        
            
            
            URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
                
                if let checkResponse = response as? HTTPURLResponse{
                    if checkResponse.statusCode == 200{
                        guard let data = data, let json = try? JSONSerialization.jsonObject(with: data, options: [JSONSerialization.ReadingOptions.allowFragments]) else {
                            completion(nil, error, false)
                            return
                        }
                        let jsonString = String(data: data, encoding: .utf8)!
                        if BSConstants.isDebugEnabled == true  {
                            print("\n\n---------------------------\n\n"+jsonString+"\n\n---------------------------\n\n")
                            print(json)
                        }
                        let dt = ((json as! NSDictionary) as! Dictionary<String, Any>)
                        //                        completion(((json as! NSDictionary) as! Dictionary<String, Any>), nil, true)
                        completion(self.nullToNil(dict : dt), nil, true)
                        //                        completion(nil, nil, true)
                    }else{
                        if BSConstants.isDebugEnabled == true  {
                            print("\n\n---------------------------\n\n"+String(checkResponse.statusCode)+"\n\n---------------------------\n\n")
                        }
                        
                        guard let data = data, let json = try? JSONSerialization.jsonObject(with: data, options: []) else {
                            completion(nil, error, false)
                            return
                        }
                        let jsonString = String(data: data, encoding: .utf8)!
                        if BSConstants.isDebugEnabled == true  {
                            print("\n\n---------------------------\n\n"+jsonString+"\n\n---------------------------\n\n")
                            print(json)
                        }
                        let dt = ((json as! NSDictionary) as! Dictionary<String, Any>)
                        
                        //                        completion(((json as! NSDictionary) as! Dictionary<String, Any>), nil, false)
                        completion(self.nullToNil(dict: dt), nil, false)
                    }
                }else{
                    guard let data = data, let json = try? JSONSerialization.jsonObject(with: data, options: []) else {
                        completion(nil, error, false)
                        return
                    }
                    let dt = ((json as! NSDictionary) as! Dictionary<String, Any>)
                    //                    completion((json as! NSDictionary) as? Dictionary<String, Any>, nil, false)
                    completion(self.nullToNil(dict: dt), nil, false)
                }
                
            }).resume()
        }
    }
    
    private func nullToNil(dict : Dictionary<String,Any>) -> Dictionary<String,Any>? {
        print(dict)
        var dict2 = dict
        for (key, value) in dict2 {
            
            let val : NSObject = value as! NSObject;
            if(val is NSNull)
            {
                dict2[key] = nil
            }
            else
            {
                dict2[key] = value
            }
            
        }
        return dict2
    }
}
