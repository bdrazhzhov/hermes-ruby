# frozen_string_literal: true

require 'spec_helper'

RSpec.describe HermesRuby::Yandex do
  let(:api_client) { HermesRuby::Yandex.new('') }

  context 'checks #call_api method' do
    let(:base_url) { 'http://example.com' }
    let(:required_headers) { { 'Content-Type': 'application/x-www-form-urlencoded' } }

    before do
      api_client.instance_variable_set(:@base_url, base_url)
    end

    it 'making API call' do
      query_obj = { some: 'data' }
      method_name = 'method_name'
      response = double('Response')
      response_body = { 'code' => 200, 'data' => 'data' }

      allow(response).to receive(:body).and_return(response_body.to_json)
      expect(RestClient).to receive(:post)
        .with("#{base_url}/#{method_name}", 'some=data&key=', headers: required_headers)
        .and_return(response)

      result = api_client.call_api(query_obj, method_name)
      expect(result).to eq(response_body)
    end
  end

  context 'checks API methods' do
    it 'should call getLangs' do
      ui_lang = :ru
      returned_result = 'Some result'
      expect(api_client).to receive(:call_api)
        .with({ ui: ui_lang }, 'getLangs')
        .and_return(returned_result)

      result = api_client.get_langs(ui_lang)
      expect(result).to eq(returned_result)
    end

    it 'should call detect' do
      text = 'Some text'
      hint = %i[en de]
      returned_result = { 'lang' => 'Some result' }

      expect(api_client).to receive(:call_api)
        .with({ text: text, hint: hint }, 'detect')
        .and_return(returned_result)

      result = api_client.detect(text, hint)
      expect(result).to eq(returned_result['lang'])
    end

    it 'should call translate' do
      input_text = 'Input text'
      result_text = 'Result text'
      lang = 'en-ru'
      format = 'html'
      returned_result = { 'text' => [result_text] }

      expect(api_client).to receive(:call_api)
        .with({ text: input_text, lang: lang, format: format }, 'translate')
        .and_return(returned_result)

      result = api_client.translate(input_text, lang, format)
      expect(result).to eq(result_text)
    end
  end
end
