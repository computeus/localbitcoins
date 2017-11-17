module LocalBitcoins
  module Ads
    # Get a list of the token owner's ads
    def ads
      request(:get, '/api/ads/').data
    end

    # Update one of the token owner's ads
    #
    # id             - id of the ad you want to update
    # visibility     - the ad's visibility [boolean]
    # min_amount     - minimum selling price [string]
    # max_amount     - maximum buying price [string]
    # price_equation - equation to calculate price [string]
    #
    # NOTE 1: Setting min_amount or max_amount to nil will unset them.
    # NOTE 2: "Floating price" must be false in you ad's edit form for price_equation to go through
    #
    def update_ad(id, params={})
      old_ad = ad(id).data
      updated_params = {
          :countrycode => old_ad.countrycode,
          :lat         => old_ad.lat,
          :lon         => old_ad.lon,
          :max_amount  => old_ad.max_amount,
          :min_amount  => old_ad.min_amount,
          :visible     => old_ad.visible
      }.merge(params)
      request(:post, "/api/ad/#{id}/", updated_params).data
    end
    
    # Update one of the token owner's ads price equation
    #
    # id             - id of the ad you want to update
    # price_equation - equation to calculate price [string]
    #
    def update_ad_equation(id, params={})
      old_ad = ad(id).data
      request(:post, "/api/ad-equation/#{id}/", params).data
    end

    # Create a new ad for the token owner
    #
    # - Required fields -
    # min_amount                - minimum amount for sale in fiat [string]
    # max_amount                - maximum amount for sale in fiat [string]
    # price_equation            - price using price equation operators [string]
    # lat                       - latitude of location [float]
    # lon                       - longitude of location [float]
    # city                      - city of listing [string]
    # location_string           - text representation of location [string]
    # countrycode               - two letter countrycode [string]
    # account_info              - [string]
    # bank_name                 - [string]
    # sms_verification_required - only receive contacts with verified phone numbers [boolean]
    # track_max_amount          - decrease max sell amount in relation to liquidity [boolean]
    # trusted_required          - only allow trusted contacts [boolean]
    # currency                  - three letter fiat representation [string]
    #
    def create_ad(params={})
      request(:post, '/api/ad-create/', params).data
    end

    # ads - comma separated list of ad ids [string]
    def ad_list(ads)
      request(:get, "/api/ad-get/", {:ads=>ads}).data
    end

    def ad(ad_id)
      request(:get, "/api/ad-get/#{ad_id}/").data.ad_list[0]
    end

    def delete_ad(ad_id)
      request(:post, "/api/ad-delete/#{ad_id}/").data
    end
  end
end
