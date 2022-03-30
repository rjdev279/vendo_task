# frozen_string_literal: true

require 'api/spree_commerce/client'
require 'spec_helper'
require 'vcr'

VCR.configure do |config|
  config.cassette_library_dir = 'spec/vcr_cassettes'
  config.hook_into :webmock
  config.configure_rspec_metadata!
end

describe Api::SpreeCommerce::Client do
  let(:client) { described_class.new }

  describe '.create_cart' do
    context 'when right request' do
      it 'creates cart and return item' do
        response = VCR.use_cassette('create_cart') do
          client.create_cart
        end

        expect(response['data']['id']).to eq '13442'
        expect(response['data']['type']).to eq 'cart'
        expect(response['data']['attributes']['item_count']).to eq 0
        expect(response['data']['attributes'].key?('token')).to be true
      end
    end
  end

  describe '.add_items' do
    let(:params) do
      {
        variant_id: '1',
        quantity: 5,
        public_metadata: {
          first_item_order: true
        },
        private_metadata: {
          recommended_by_us: false
        }
      }
    end

    context 'when right request' do
      it 'items add in cart and returns cart item' do
        create_cart = VCR.use_cassette('create_cart') do
          client.create_cart
        end
        response = VCR.use_cassette('add_items') do
          client.add_items(create_cart['data']['attributes']['token'], params)
        end
        expect(create_cart['data']['attributes']['item_count']).to eq 0
        expect(response['data']['attributes']['item_count']).to eq params[:quantity]
      end
    end

    context 'when item_data missing' do
      it 'returns 404 not found' do
        create_cart = VCR.use_cassette('create_cart') do
          client.create_cart
        end
        response = VCR.use_cassette('add_items_without_data') do
          client.add_items(create_cart['data']['attributes']['token'], {})
        end

        expect(response['error']).to eq 'Net::HTTPServerException: 404 "Not Found"'
      end
    end

    context 'when token missing' do
      it 'returns 404 not found' do
        response = VCR.use_cassette('add_items_without_token') do
          client.add_items('123', params)
        end
        expect(response['error']).to eq 'Net::HTTPServerException: 404 "Not Found"'
      end
    end
  end
end
