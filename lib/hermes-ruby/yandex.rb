# frozen_string_literal: true

require 'rest-client'
require 'querystring'
require 'json'

module HermesRuby
  # HermesRuby::Yandex class needs to be used
  # for making calls to the Yandex Translator API.
  class Yandex
    # @param api_key - can be obtained at https://translate.yandex.com/developers/keys.
    def initialize(api_key)
      @base_url = 'https://translate.yandex.net/api/v1.5/tr.json'
      @api_key = api_key
    end

    # Gets a list of translation directions supported by the service.
    # @param ui_lang - the language code that specifies a response language.
    def get_langs(ui_lang = 'en')
      call_api({ ui: ui_lang }, 'getLangs')
    end

    # Detects the language of the specified text.
    # @param text - the text to detect the language for.
    # @param hint - array of symbols containing language codes.
    # of the most likely languages, for example [:en, :de].
    def detect(text, hint = nil)
      query_obj = { text: text }
      query_obj[:hint] = hint if hint
      result = call_api(query_obj, 'detect')

      result['lang']
    end

    # Translates text to the specified language.
    # @param text - the text to translate.
    # @param lang - the translation direction.
    # You can set it in either of the following ways:
    #   - As a pair of language codes separated by a hyphen ("from"-"to").
    #     For example, en-ru indicates translating from English to Russian.
    #   - As the target language code (for example, ru).
    #     In this case, the service tries to detect the source language automatically.
    # Default value: 'en'.
    # @param format - text format.
    # Possible values:
    #   - plain - Text without markup (default value).
    #   - html - Text in HTML format.
    def translate(text, lang = 'en', format = 'plain')
      query_obj = { text: text, lang: lang, format: format }
      result = call_api(query_obj, 'translate')['text']

      result.first
    end

    # Makes calls to Yandex Translator API.
    # @param query_obj - a set of key value pairs containing params passing to the API.
    # @param method_name - an API method name that should be called,
    # for example, 'detect', 'translate'.
    def call_api(query_obj, method_name)
      query_obj[:key] = @api_key
      query_string = QueryString.stringify(query_obj)
      headers = { 'Content-Type': 'application/x-www-form-urlencoded' }

      begin
        result = RestClient.post("#{@base_url}/#{method_name}", query_string, headers: headers)
        return JSON.parse(result.body)
      rescue RestClient::RequestFailed => e
        raise e.response.body
      end
    end
  end
end
