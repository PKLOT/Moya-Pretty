//
//  TargetType+ObjectMapper.swift
//  Moya-Pretty
//
//  Created by Kao Ming-Hsiu on 2018/7/8.
//

import Foundation
import Moya
import ObjectMapper

public protocol MappableBodyType {
  associatedtype MappableBodyModel: BaseMappable
  var body: MappableBodyModel {get}
}

public protocol MappableResponseType {
  associatedtype MappableResponseModel: BaseMappable
}

open class MappableBodyTarget<InputModel: Mappable>: MappableBodyType {
  public var body: InputModel
  public typealias MappableBodyModel = InputModel
  public init(body: InputModel) {
    self.body = body
  }
}

open class MappableResponseTarget<OutputModel: BaseMappable>: MappableResponseType {
  public typealias MappableResponseModel = OutputModel
  public init() {}
}

open class MappableTarget<InputModel: BaseMappable, OutputModel: BaseMappable>: MappableBodyType, MappableResponseType {
  public var body: InputModel
  public typealias MappableBodyModel = InputModel
  public typealias MappableResponseModel = OutputModel
  public init(body: InputModel) {
    self.body = body
  }
}

extension TargetType where Self: MappableBodyType {
  public var task: Task {
    return .requestParameters(parameters: body.toJSON(), encoding: JSONEncoding.default)
  }
}
