//
//  Tax.ID.swift
//  Stripe
//
//  Created by Andrew Edwards on 5/11/19.
//

import Foundation
import Stripe_Types_Shared
import Tagged_Primitives

// https://docs.stripe.com/api/tax_ids/object.md

extension Stripe.Tax {
    /// The [Stripe.Tax ID Object](https://stripe.com/docs/api/customer_tax_ids/object) .
    public struct ID: Codable, Hashable, Sendable {
        /// Unique identifier for the object.
        public var id: Tagged<Stripe.Tax.ID, String>
        /// Two-letter ISO code representing the country of the tax ID.
        public var country: String?
        /// ID of the customer.
        @ExpandableOf<Stripe.Customers.Customer> public var customer: Stripe.Customers.Customer.ID?
        /// Type of the tax ID.
        public var type: Stripe.Tax.ID.`Type`?
        /// Value of the tax ID.
        public var value: String?
        /// String representing the object’s type. Objects of the same type share the same value.
        public var object: String
        /// Time at which the object was created. Measured in seconds since the Unix epoch.
        public var created: Date
        /// Has the value true if the object exists in live mode or the value false if the object exists in test mode.
        public var livemode: Bool?
        /// Tax ID verification information.
        public var verification: Stripe.Tax.ID.Verification?

        public init(
            id: Tagged<Stripe.Tax.ID, String>,
            country: String? = nil,
            customer: Stripe.Customers.Customer.ID? = nil,
            type: Stripe.Tax.ID.`Type`? = nil,
            value: String? = nil,
            object: String,
            created: Date,
            livemode: Bool? = nil,
            verification: Stripe.Tax.ID.Verification? = nil
        ) {
            self.id = id
            self.country = country
            self._customer = Expandable(id: customer)
            self.type = type
            self.value = value
            self.object = object
            self.created = created
            self.livemode = livemode
            self.verification = verification
        }
    }
}

// Tax namespace is already defined in Stripe Namespaces.swift

extension Stripe.Tax.ID {
    public enum `Type`: String, Codable, Sendable {
        case aeTrn = "ae_trn"
        case auAbn = "au_abn"
        case auArn = "au_arn"
        case bgUic = "bg_uic"
        case brCnpj = "br_cnpj"
        case brCpf = "br_cpf"
        case caBn = "ca_bn"
        case caGstHst = "ca_gst_hst"
        case caPstBc = "ca_pst_bc"
        case caPstMb = "ca_pst_mb"
        case caPstSk = "ca_pst_sk"
        case caQst = "ca_qst"
        case chVat = "ch_vat"
        case clTin = "cl_tin"
        case egTin = "eg_tin"
        case esCif = "es_cif"
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
        case phTin = "ph_tin"
        case ruInn = "ru_inn"
        case ruKpp = "ru_kpp"
        case saVat = "sa_vat"
        case sgGst = "sg_gst"
        case sgUen = "sg_uen"
        case siTin = "si_tin"
        case thVat = "th_vat"
        case trTin = "tr_tin"
        case twVat = "tw_vat"
        case uaVat = "ua_vat"
        case usEin = "us_ein"
        case zaVat = "za_vat"
        case unknown
    }
}

extension Stripe.Tax.ID {
    public struct Verification: Codable, Hashable, Sendable {
        /// Verification status, one of `pending`, `unavailable`, `unverified`, or `verified`.
        public var status: Stripe.Tax.ID.Verification.Status?
        /// Verified address.
        public var verifiedAddress: String?
        /// Verified name.
        public var verifiedName: String?

        public init(
            status: Stripe.Tax.ID.Verification.Status? = nil,
            verifiedAddress: String? = nil,
            verifiedName: String? = nil
        ) {
            self.status = status
            self.verifiedAddress = verifiedAddress
            self.verifiedName = verifiedName
        }
    }
}

extension Stripe.Tax.ID.Verification {
    public enum Status: String, Codable, Sendable {
        case pending
        case unavailable
        case unverified
        case verified
    }
}

extension Stripe.Tax.ID {
    public struct List: Codable, Hashable, Sendable {
        public var object: String
        public var url: String?
        public var hasMore: Bool?
        public var data: [Stripe.Tax.ID]?

        public init(
            object: String,
            url: String? = nil,
            hasMore: Bool? = nil,
            data: [Stripe.Tax.ID]? = nil
        ) {
            self.object = object
            self.url = url
            self.hasMore = hasMore
            self.data = data
        }
    }
}
