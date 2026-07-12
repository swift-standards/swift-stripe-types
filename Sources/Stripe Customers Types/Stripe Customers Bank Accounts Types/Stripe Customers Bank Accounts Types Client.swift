import Dependencies
import Foundation
import Stripe_Types_Models
import Stripe_Types_Shared
import Tagged_Primitives

extension Stripe.Customers.BankAccounts {
    @Witness
    public struct Client: Sendable {
        // https://docs.stripe.com/api/customer_bank_accounts/create.md
        public var create:
            @Sendable (_ customerId: Stripe.Customers.Customer.ID, _ request: Create.Request)
                async throws(any Swift.Error)
                -> BankAccount

        // https://docs.stripe.com/api/customer_bank_accounts/retrieve.md
        public var retrieve:
            @Sendable (_ customerId: Stripe.Customers.Customer.ID, _ bankAccountId: BankAccount.ID)
                async throws(any Swift.Error) -> BankAccount

        // https://docs.stripe.com/api/customer_bank_accounts/update.md
        public var update:
            @Sendable (
                _ customerId: Stripe.Customers.Customer.ID, _ bankAccountId: BankAccount.ID,
                _ request: Update.Request
            ) async throws(any Swift.Error) -> BankAccount

        // https://docs.stripe.com/api/customer_bank_accounts/list.md
        public var list:
            @Sendable (_ customerId: Stripe.Customers.Customer.ID, _ request: List.Request)
                async throws(any Swift.Error)
                -> List.Response

        // https://docs.stripe.com/api/customer_bank_accounts/delete.md
        public var delete:
            @Sendable (_ customerId: Stripe.Customers.Customer.ID, _ bankAccountId: BankAccount.ID)
                async throws(any Swift.Error) -> DeletedObject<BankAccount>

        // https://docs.stripe.com/api/customer_bank_accounts/verify.md
        public var verify:
            @Sendable (
                _ customerId: Stripe.Customers.Customer.ID, _ bankAccountId: BankAccount.ID,
                _ request: Verify.Request
            ) async throws(any Swift.Error) -> BankAccount
    }
}
