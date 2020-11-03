//
//  JsonParser.swift
//  JPHacksSample
//
//  Created by Gyuho on 2020/10/31.
//

import UIKit
import SwiftyJSON

class JsonParser: NSObject {
    class var sharedInstance: JsonParser {
        struct Static {
            static let instance: JsonParser = JsonParser()
        }
        return Static.instance
    }

    // 叩くAPIによってparseするタイプを出しわけ
    func parseJson(_ api: API, json: JSON) -> Any? {
        switch api {
        case .profile:
            return self.parseProfileApiJson(json)
        }
    }

    // プロフィール画面ユーザー情報取得
    private func parseProfileApiJson(_ json: JSON) -> UserModel {
        let userModel = UserModel()
        userModel.id = json["id"].int
        userModel.name = json["name"].string
        userModel.email = json["email"].string
        userModel.user_plants = json["user_plants"].string

        return userModel
    }
    
    // 植物情報取得
    private func parsePlantApiJson(_ json: JSON) -> PlantsModel {
        let plantModel = PlantsModel()
        plantModel.id = json["id"].int
        plantModel.name = json["name"].string
        plantModel.kit_name = json["name"].string
        plantModel.plant_description = json["name"].string
        plantModel.price = json["price"].int
        plantModel.period = json["period"].int
        plantModel.difficurty = json["difficurty"].int
        plantModel.season_from = json["season_from"].int
        plantModel.season_to = json["season_to"].int
        if let tmpArr = json["temperatures"].array{
            for obj in tmpArr {
                let temperature = Temperature()
                temperature.id = obj["id"].int
                temperature.name = obj["name"].string
                temperature.value = obj["value"].int
                plantModel.temperatures?.append(temperature)
            }
        }
        if let tmpArr = json["waters"].array{
            for obj in tmpArr {
                let water = Water()
                water.id = obj["id"].int
                water.name = obj["name"].string
                water.value = obj["value"].int
                plantModel.waters?.append(water)
            }
        }

        return plantModel
    }
    
    // ユーザー所持植物情報取得
    private func parseUserPlantApiJson(_ json: JSON) -> UserPlantModel {
        let userPlantModel = UserPlantModel()
        userPlantModel.id = json["id"].int
        userPlantModel.name = json["name"].string
        userPlantModel.kit_name = json["name"].string
        userPlantModel.plant_description = json["name"].string
        userPlantModel.price = json["price"].int
        userPlantModel.period = json["period"].int
        userPlantModel.difficurty = json["difficurty"].int
        userPlantModel.season_from = json["season_from"].int
        userPlantModel.season_to = json["season_to"].int

        return userPlantModel
    }
}
