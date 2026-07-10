import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared
import Tagged_Primitives

extension Stripe.Billing.TaxIDs {
    public struct TaxID: Codable, Equatable, Sendable, Identifiable {
        public typealias ID = Tagged<Self, String>

        public let id: ID
        public let object: String
        public let country: String?
        public let created: Int
        public let customer: Stripe.Customers.Customer.ID?
        public let livemode: Bool
        public let type: TaxIDType
        public let value: String
        public let verification: Verification?

        public enum TaxIDType: String, Codable, Equatable, Sendable {
            case adNrt = "ad_nrt"
            case aetrn
            case arCuit = "ar_cuit"
            case auAbn = "au_abn"
            case auArn = "au_arn"
            case bgUic = "bg_uic"
            case boTin = "bo_tin"
            case brCnpj = "br_cnpj"
            case brCpf = "br_cpf"
            case cabn
            case caGstHst = "ca_gst_hst"
            case caPstBc = "ca_pst_bc"
            case caPstMb = "ca_pst_mb"
            case caPstSk = "ca_pst_sk"
            case caQst = "ca_qst"
            case chVat = "ch_vat"
            case clTin = "cl_tin"
            case cnTin = "cn_tin"
            case coNit = "co_nit"
            case crTin = "cr_tin"
            case doRcn = "do_rcn"
            case ecRuc = "ec_ruc"
            case egTin = "eg_tin"
            case esVat = "es_vat"
            case euOssVat = "eu_oss_vat"
            case euVat = "eu_vat"
            case gbVat = "gb_vat"
            case geVat = "ge_vat"
            case hkBr = "hk_br"
            case huTin = "hu_tin"
            case idNpwp = "id_npwp"
            case ilVat = "il_vat"
            case inGst = "in_gst"
            case isVat = "is_vat"
            case jpCn = "jp_cn"
            case jpRn = "jp_rn"
            case jpTrn = "jp_trn"
            case kePin = "ke_pin"
            case krBrn = "kr_brn"
            case liUid = "li_uid"
            case mxRfc = "mx_rfc"
            case myFrp = "my_frp"
            case myItn = "my_itn"
            case mySst = "my_sst"
            case noVat = "no_vat"
            case nzGst = "nz_gst"
            case peTin = "pe_tin"
            case phTin = "ph_tin"
            case roTin = "ro_tin"
            case rsPib = "rs_pib"
            case ruInn = "ru_inn"
            case ruKpp = "ru_kpp"
            case saVat = "sa_vat"
            case sgGst = "sg_gst"
            case sgUen = "sg_uen"
            case siTin = "si_tin"
            case svNit = "sv_nit"
            case thVat = "th_vat"
            case trTin = "tr_tin"
            case twVat = "tw_vat"
            case uaVat = "ua_vat"
            case usEin = "us_ein"
            case uyRuc = "uy_ruc"
            case veRif = "ve_rif"
            case vnTin = "vn_tin"
            case zaTin = "za_tin"
        }

        public struct Verification: Codable, Equatable, Sendable {
            public let status: Status
            public let verifiedAddress: String?
            public let verifiedName: String?

            public enum Status: String, Codable, Equatable, Sendable {
                case pending
                case unavailable
                case unverified
                case verified
            }

            private enum CodingKeys: String, CodingKey {
                case status
                case verifiedAddress = "verified_address"
                case verifiedName = "verified_name"
            }
        }
    }
}

// MARK: - Create
extension Stripe.Billing.TaxIDs {
    public enum Create {}
}

extension Stripe.Billing.TaxIDs.Create {
    public struct Request: Codable, Equatable, Sendable {
        /// Type of the tax ID
        public let type: Stripe.Billing.TaxIDs.TaxID.TaxIDType

        /// Value of the tax ID
        public let value: String

        public init(
            type: Stripe.Billing.TaxIDs.TaxID.TaxIDType,
            value: String
        ) {
            self.type = type
            self.value = value
        }
    }
}

// MARK: - List
extension Stripe.Billing.TaxIDs {
    public enum List {}
}

extension Stripe.Billing.TaxIDs.List {
    public struct Request: Codable, Equatable, Sendable {
        /// A cursor for use in pagination. ending_before is an object ID that defines your place in the list.
        public let endingBefore: String?

        /// A limit on the number of objects to be returned. Limit can range between 1 and 100, and the default is 10.
        public let limit: Int?

        /// A cursor for use in pagination. starting_after is an object ID that defines your place in the list.
        public let startingAfter: String?

        public init(
            endingBefore: String? = nil,
            limit: Int? = nil,
            startingAfter: String? = nil
        ) {
            self.endingBefore = endingBefore
            self.limit = limit
            self.startingAfter = startingAfter
        }

        private enum CodingKeys: String, CodingKey {
            case endingBefore = "ending_before"
            case limit
            case startingAfter = "starting_after"
        }
    }

    public struct Response: Codable, Sendable {
        public let object: String
        public let url: String
        public let hasMore: Bool
        public let data: [Stripe.Billing.TaxIDs.TaxID]

        private enum CodingKeys: String, CodingKey {
            case object
            case url
            case hasMore = "has_more"
            case data
        }
    }
}
