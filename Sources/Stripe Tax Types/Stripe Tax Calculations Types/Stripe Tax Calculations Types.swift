//
//  Stripe Tax Calculations Types.swift
//  swift-stripe-types
//
//  Created on 2025-01-14.
//

import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared
import Tagged_Primitives

// Calculations namespace is already defined in Stripe Namespaces.swift

extension Stripe.Tax.Calculations {
    // https://docs.stripe.com/api/tax/calculations/create.md
    public enum Create {}
    public enum List {}
}

extension Stripe.Tax.Calculations.Create {
    public struct Request: Codable, Equatable, Sendable {
        /// Three-letter ISO currency code, in lowercase. Must be a supported currency.
        public var currency: Stripe.Currency
        /// The customer to tax.
        public var customer: Stripe.Customers.Customer.ID?
        /// The customer's details. Only required if customer is not provided.
        public var customerDetails: CustomerDetails?
        /// A list of items the customer is purchasing.
        public var lineItems: [LineItem]
        /// Shipping cost details for the calculation.
        public var shippingCost: ShippingCost?
        /// The shipping address to use for the calculation.
        public var shipFromDetails: ShipFromDetails?
        /// Timestamp of the date to use for the calculation. Measured in seconds since the Unix epoch.
        public var taxDate: Date?
        /// Set of key-value pairs that you can attach to an object.
        public var expand: [String]?

        private enum CodingKeys: String, CodingKey {
            case currency
            case customer
            case customerDetails = "customer_details"
            case lineItems = "line_items"
            case shippingCost = "shipping_cost"
            case shipFromDetails = "ship_from_details"
            case taxDate = "tax_date"
            case expand
        }

        public init(
            currency: Stripe.Currency,
            customer: Stripe.Customers.Customer.ID? = nil,
            customerDetails: CustomerDetails? = nil,
            lineItems: [LineItem] = [],
            shippingCost: ShippingCost? = nil,
            shipFromDetails: ShipFromDetails? = nil,
            taxDate: Date? = nil,
            expand: [String]? = nil
        ) {
            self.currency = currency
            self.customer = customer
            self.customerDetails = customerDetails
            self.lineItems = lineItems
            self.shippingCost = shippingCost
            self.shipFromDetails = shipFromDetails
            self.taxDate = taxDate
            self.expand = expand
        }
    }

    public struct CustomerDetails: Codable, Equatable, Sendable {
        /// The customer's postal address (for example, home or business location).
        public var address: Address?
        /// The type of customer address provided.
        public var addressSource: AddressSource?
        /// The customer's IP address (IPv4 or IPv6).
        public var ipAddress: String?
        /// The customer's tax exemption. One of none, exempt, or reverse.
        public var taxability: Taxability?
        /// A list of tax IDs for the customer.
        public var taxIds: [TaxID]?

        private enum CodingKeys: String, CodingKey {
            case address
            case addressSource = "address_source"
            case ipAddress = "ip_address"
            case taxability
            case taxIds = "tax_ids"
        }

        public init(
            address: Address? = nil,
            addressSource: AddressSource? = nil,
            ipAddress: String? = nil,
            taxability: Taxability? = nil,
            taxIds: [TaxID]? = nil
        ) {
            self.address = address
            self.addressSource = addressSource
            self.ipAddress = ipAddress
            self.taxability = taxability
            self.taxIds = taxIds
        }

        public enum AddressSource: String, Codable, Sendable {
            case billing
            case shipping
        }

        public enum Taxability: String, Codable, Sendable {
            case exempt
            case none
            case reverse
        }
    }

    public struct LineItem: Codable, Equatable, Sendable {
        /// A positive integer in the smallest currency unit representing the line item's total price.
        public var amount: Int
        /// If provided, the product's tax code will be used for the calculation. If omitted, Stripe will use the default tax code.
        public var product: Stripe.Products.Product.ID?
        /// The number of units of the item being purchased. Must be a positive integer.
        public var quantity: Int?
        /// A custom identifier for this line item, which will be included in the calculation's line_items.
        public var reference: String?
        /// Specifies whether the amount includes taxes. Defaults to exclusive.
        public var taxBehavior: TaxBehavior?
        /// The tax code ID to use for this line item.
        public var taxCode: String?

        private enum CodingKeys: String, CodingKey {
            case amount
            case product
            case quantity
            case reference
            case taxBehavior = "tax_behavior"
            case taxCode = "tax_code"
        }

        public init(
            amount: Int,
            product: Stripe.Products.Product.ID? = nil,
            quantity: Int? = nil,
            reference: String? = nil,
            taxBehavior: TaxBehavior? = nil,
            taxCode: String? = nil
        ) {
            self.amount = amount
            self.product = product
            self.quantity = quantity
            self.reference = reference
            self.taxBehavior = taxBehavior
            self.taxCode = taxCode
        }

        public enum TaxBehavior: String, Codable, Sendable {
            case exclusive
            case inclusive
        }
    }

    public struct ShippingCost: Codable, Equatable, Sendable {
        /// A positive integer in the smallest currency unit representing the shipping charge.
        public var amount: Int
        /// If provided, the shipping tax code will be used for the calculation.
        public var shippingRate: Stripe.Products.Shipping.Rate.ID?
        /// Specifies whether the amount includes taxes. Defaults to exclusive.
        public var taxBehavior: TaxBehavior?
        /// The tax code to use for shipping.
        public var taxCode: String?

        private enum CodingKeys: String, CodingKey {
            case amount
            case shippingRate = "shipping_rate"
            case taxBehavior = "tax_behavior"
            case taxCode = "tax_code"
        }

        public init(
            amount: Int,
            shippingRate: Stripe.Products.Shipping.Rate.ID? = nil,
            taxBehavior: TaxBehavior? = nil,
            taxCode: String? = nil
        ) {
            self.amount = amount
            self.shippingRate = shippingRate
            self.taxBehavior = taxBehavior
            self.taxCode = taxCode
        }

        public enum TaxBehavior: String, Codable, Sendable {
            case exclusive
            case inclusive
        }
    }

    public struct ShipFromDetails: Codable, Equatable, Sendable {
        /// The address from which the goods are being shipped from.
        public var address: Address

        public init(address: Address) {
            self.address = address
        }
    }

    public struct TaxID: Codable, Equatable, Sendable {
        /// The type of the tax ID.
        public var type: TaxIDType
        /// The value of the tax ID.
        public var value: String

        public init(type: TaxIDType, value: String) {
            self.type = type
            self.value = value
        }

        public enum TaxIDType: String, Codable, Sendable {
            case adNrt = "ad_nrt"
            case aetrn = "ae_trn"
            case arCuit = "ar_cuit"
            case auAbn = "au_abn"
            case auArn = "au_arn"
            case bgUic = "bg_uic"
            case bhVat = "bh_vat"
            case boTin = "bo_tin"
            case brCnpj = "br_cnpj"
            case brCpf = "br_cpf"
            case caAgencyCode = "ca_agency_code"
            case caBn = "ca_bn"
            case caGstHst = "ca_gst_hst"
            case caPstBc = "ca_pst_bc"
            case caPstMb = "ca_pst_mb"
            case caPstSk = "ca_pst_sk"
            case caQst = "ca_qst"
            case chUid = "ch_uid"
            case chVat = "ch_vat"
            case clTin = "cl_tin"
            case cnTin = "cn_tin"
            case coNit = "co_nit"
            case crTin = "cr_tin"
            case deStn = "de_stn"
            case doRcn = "do_rcn"
            case ecRuc = "ec_ruc"
            case egTin = "eg_tin"
            case esCif = "es_cif"
            case euOssVat = "eu_oss_vat"
            case euVat = "eu_vat"
            case gbVat = "gb_vat"
            case geVat = "ge_vat"
            case hkBr = "hk_br"
            case hrOib = "hr_oib"
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
            case kzBin = "kz_bin"
            case liUid = "li_uid"
            case mxRfc = "mx_rfc"
            case myFrp = "my_frp"
            case myItn = "my_itn"
            case mySst = "my_sst"
            case ngTin = "ng_tin"
            case noVat = "no_vat"
            case noVoec = "no_voec"
            case nzGst = "nz_gst"
            case omVat = "om_vat"
            case peRuc = "pe_ruc"
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
            case zaVat = "za_vat"
        }
    }
}

extension Stripe.Tax.Calculations.List {
    // https://docs.stripe.com/api/tax/calculations/line_items.md
    public enum LineItems {}
}

extension Stripe.Tax.Calculations.List.LineItems {
    public struct Request: Codable, Equatable, Sendable {
        /// A cursor for use in pagination. ending_before is an object ID that defines your place in the list.
        public var endingBefore: String?
        /// A limit on the number of objects to be returned. Limit can range between 1 and 100, and the default is 10.
        public var limit: Int?
        /// A cursor for use in pagination. starting_after is an object ID that defines your place in the list.
        public var startingAfter: String?

        private enum CodingKeys: String, CodingKey {
            case endingBefore = "ending_before"
            case limit
            case startingAfter = "starting_after"
        }

        public init(
            endingBefore: String? = nil,
            limit: Int? = nil,
            startingAfter: String? = nil
        ) {
            self.endingBefore = endingBefore
            self.limit = limit
            self.startingAfter = startingAfter
        }
    }

    public struct Response: Codable, Sendable {
        /// String describing the object type returned.
        public var object: String
        /// Details about each object.
        public var data: [Stripe.Tax.Calculation.LineItem]
        /// True if this list has another page of items after this one that can be fetched.
        public var hasMore: Bool
        /// The URL where this list can be accessed.
        public var url: String

        private enum CodingKeys: String, CodingKey {
            case object
            case data
            case hasMore = "has_more"
            case url
        }

        public init(
            object: String,
            data: [Stripe.Tax.Calculation.LineItem],
            hasMore: Bool,
            url: String
        ) {
            self.object = object
            self.data = data
            self.hasMore = hasMore
            self.url = url
        }
    }
}
