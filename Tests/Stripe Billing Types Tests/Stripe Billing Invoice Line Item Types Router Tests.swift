//
//  Stripe Billing Invoice Line Item Types Router Tests.swift
//  swift-stripe-types
//
//  Created by Coen ten Thije Boonkkamp on 13/01/2025.
//

import Foundation
import Stripe_Types_Shared
import Testing
import URLRouting
import URL_Routing_Foundation_Integration

@testable import Stripe_Billing_Types
@testable import Stripe_Types_Models

@Suite("Billing Invoice Line Item Router Tests")
struct BillingInvoiceLineItemRouterTests {

    @Test("List invoice line items URL generation")
    func testListInvoiceLineItems() throws {
        let router = Stripe.Billing.Invoice.LineItems.API.Router()
        let request = Stripe.Billing.Invoice.LineItems.List.Request(limit: 10)
        let api = Stripe.Billing.Invoice.LineItems.API.list(invoiceId: "in_123", request: request)

        let url = router.url(for: api)
        #expect(url.path == "/v1/invoices/in_123/lines")
        #expect(url.query?.contains("limit=10") == true)

        // Round-trip test
        let httpRequest = try router.request(for: api)
        #expect(httpRequest.httpMethod == "GET")
        let matched = try router.match(request: httpRequest)
        #expect(matched == api)
    }

    @Test("List invoice line items without query parameters")
    func testListInvoiceLineItemsNoParams() throws {
        let router = Stripe.Billing.Invoice.LineItems.API.Router()
        let request = Stripe.Billing.Invoice.LineItems.List.Request()
        let api = Stripe.Billing.Invoice.LineItems.API.list(invoiceId: "in_123", request: request)

        let url = router.url(for: api)
        #expect(url.path == "/v1/invoices/in_123/lines")

        // Round-trip test
        let httpRequest = try router.request(for: api)
        #expect(httpRequest.httpMethod == "GET")
        let matched = try router.match(request: httpRequest)
        #expect(matched == api)
    }

    @Test("Update invoice line item URL generation")
    func testUpdateInvoiceLineItem() throws {
        let router = Stripe.Billing.Invoice.LineItems.API.Router()
        let request = Stripe.Billing.Invoice.LineItems.Update.Request(
            amount: 1000,
            description: "Updated line item"
        )
        let api = Stripe.Billing.Invoice.LineItems.API.update(
            invoiceId: "in_123",
            lineItemId: "li_456",
            request: request
        )

        let url = router.url(for: api)
        #expect(url.path == "/v1/invoices/in_123/lines/li_456")

        // Round-trip test
        let httpRequest = try router.request(for: api)
        #expect(httpRequest.httpMethod == "POST")
        let matched = try router.match(request: httpRequest)
        #expect(matched == api)
    }

    @Test("Add lines to invoice URL generation")
    func testAddLinesToInvoice() throws {
        let router = Stripe.Billing.Invoice.LineItems.API.Router()
        let lineItem = Stripe.Billing.Invoice.LineItems.AddLines.LineItem(
            amount: 2000,
            currency: .usd,
            description: "New line item"
        )
        let request = Stripe.Billing.Invoice.LineItems.AddLines.Request(lines: [lineItem])
        let api = Stripe.Billing.Invoice.LineItems.API.addLines(
            invoiceId: "in_123",
            request: request
        )

        let url = router.url(for: api)
        #expect(url.path == "/v1/invoices/in_123/add_lines")

        // Round-trip test
        let httpRequest = try router.request(for: api)
        #expect(httpRequest.httpMethod == "POST")
        let matched = try router.match(request: httpRequest)
        #expect(matched == api)
    }

    @Test("Update lines on invoice URL generation")
    func testUpdateLinesOnInvoice() throws {
        let router = Stripe.Billing.Invoice.LineItems.API.Router()
        let lineItem = Stripe.Billing.Invoice.LineItems.UpdateLines.LineItem(
            id: "li_456",
            amount: 2500,
            description: "Updated via bulk"
        )
        let request = Stripe.Billing.Invoice.LineItems.UpdateLines.Request(lines: [lineItem])
        let api = Stripe.Billing.Invoice.LineItems.API.updateLines(
            invoiceId: "in_123",
            request: request
        )

        let url = router.url(for: api)
        #expect(url.path == "/v1/invoices/in_123/update_lines")

        // Round-trip test
        let httpRequest = try router.request(for: api)
        #expect(httpRequest.httpMethod == "POST")
        let matched = try router.match(request: httpRequest)
        #expect(matched == api)
    }

    @Test("Remove lines from invoice URL generation")
    func testRemoveLinesFromInvoice() throws {
        let router = Stripe.Billing.Invoice.LineItems.API.Router()
        let lineItem = Stripe.Billing.Invoice.LineItems.RemoveLines.LineItem(id: "li_456")
        let request = Stripe.Billing.Invoice.LineItems.RemoveLines.Request(lines: [lineItem])
        let api = Stripe.Billing.Invoice.LineItems.API.removeLines(
            invoiceId: "in_123",
            request: request
        )

        let url = router.url(for: api)
        #expect(url.path == "/v1/invoices/in_123/remove_lines")

        // Round-trip test
        let httpRequest = try router.request(for: api)
        #expect(httpRequest.httpMethod == "POST")
        let matched = try router.match(request: httpRequest)
        #expect(matched == api)
    }

    @Test("List with pagination parameters")
    func testListWithPagination() throws {
        let router = Stripe.Billing.Invoice.LineItems.API.Router()
        let request = Stripe.Billing.Invoice.LineItems.List.Request(
            endingBefore: "li_end",
            limit: 5,
            startingAfter: "li_start"
        )
        let api = Stripe.Billing.Invoice.LineItems.API.list(invoiceId: "in_123", request: request)

        let url = router.url(for: api)
        #expect(url.path == "/v1/invoices/in_123/lines")
        #expect(url.query?.contains("ending_before=li_end") == true)
        #expect(url.query?.contains("limit=5") == true)
        #expect(url.query?.contains("starting_after=li_start") == true)

        // Round-trip test
        let httpRequest = try router.request(for: api)
        #expect(httpRequest.httpMethod == "GET")
        let matched = try router.match(request: httpRequest)
        #expect(matched == api)
    }
}
