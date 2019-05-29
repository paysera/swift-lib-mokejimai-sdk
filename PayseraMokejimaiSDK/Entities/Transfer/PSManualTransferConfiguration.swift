import ObjectMapper

public class PSManualTransferConfiguration: Mappable {
    public let fromBankKey: String
    public let toBankKey: String
    public let currency: String
    public let toCountryCode: String
    public let toBeneficiaryName: String
    public let commission: PSMoney
    public let transferExecutionTime: String
    
    public var fromCountryCode: String?
    public var toIban: String?
    public var toAccountNumber: String?
    public var toBankCode: String?
    public var toBic: String?
    public var sortOrder: String?
    public var correspondentBankName: String?
    public var correspondentBankSwift: String?
    public var correspondentBankAddress: String?
    public var bankAddress: String?
    public var commissionPercent: String?
    public var commissionMinAmount: String?
    public var commissionMaxAmount: String?
    public var accountNumber: String?
    public var name: String?
    
    required public init?(map: Map) {
        do {
            fromBankKey = try map.value("from_bank_key")
            toBankKey = try map.value("to_bank_key")
            currency = try map.value("currency")
            toCountryCode = try map.value("to_country_code")
            toBeneficiaryName = try map.value("to_beneficiary_name")
            commission = try map.value("commission")
            transferExecutionTime = try map.value("transfer_execution_time")
        } catch {
            return nil
        }
    }
    
    public func mapping(map: Map) {
        fromCountryCode             <- map["from_country_code"]
        toIban                      <- map["to_iban"]
        toAccountNumber             <- map["to_account_number"]
        toBankCode                  <- map["to_bank_code"]
        toBic                       <- map["to_bic"]
        sortOrder                   <- map["sort_order"]
        correspondentBankName       <- map["correspondent_bank_name"]
        correspondentBankSwift      <- map["correspondent_bank_swift"]
        correspondentBankAddress    <- map["correspondent_bank_address"]
        bankAddress                 <- map["bank_address"]
        commissionPercent           <- map["commission_percent"]
        commissionMinAmount         <- map["commission_min_amount"]
        commissionMaxAmount         <- map["commission_max_amount"]
        accountNumber               <- map["account_number"]
        name                        <- map["name"]
    }
}
