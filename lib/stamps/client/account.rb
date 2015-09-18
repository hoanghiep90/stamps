module Stamps
  class Client
    module Account

      # Returns information about the stamps account
      #
      # @param params [Hash] authenticator, address, rates.
      # @return [Hash]
      #
      def account(params = {})
        params[:authenticator] = authenticator_token
        response = request('GetAccountInfo', Stamps::Mapping::Account.new(params) )
        response.errors.empty? ? response.hash[:get_account_info_response][:account_info] : response
      end

      # Add funds to postage account
      #
      def purchase_postage(params = {})
        params[:credentials] =
          {
            username: self.username,
            password: self.password,
            :integration_id => '1e6c1e3a-dd09-4c28-b1ce-240e222a75da'
          }
        response = request('PurchasePostage', Stamps::Mapping::PurchasePostage.new(params))
        response.errors.empty? ? response.hash[:purchase_postage_response] : response
      end

      # Check the payment of purchase_postage
      #
      def get_purchase_status(params = {})
        params[:authenticator] = authenticator_token
        response = request('GetPurchaseStatus', Stamps::Mapping::GetPurchaseStatus.new(params))
        response.errors.empty? ? response.hash[:get_purchase_status_response] : response
      end

      # Request carrier pickup
      # TODO: Should this go somewhere else?
      #
      def carrier_pickup(params = {})
        params[:authenticator] = authenticator_token
        response = request('CarrierPickup', Stamps::Mapping::CarrierPickup.new(params))
        response.errors.empty? ?  response.hash[:carrier_pickup_response] : response
      end

    end
  end
end