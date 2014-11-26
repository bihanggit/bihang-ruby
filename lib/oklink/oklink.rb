require 'httparty'
require 'multi_json'
require 'hashie'
require 'time'
require 'securerandom'

module Oklink 
  class Client
    include HTTParty
    
    
    require 'openssl'
    OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE
    
    BASE_URI = '/api/v1/'
    WEB_URI =  'https://www.oklink.com/'

    def initialize(api_key='', api_secret='', options={})
      @api_key = api_key
      @api_secret = api_secret

      # defaults
      options[:base_uri] ||= BASE_URI
      @base_uri = options[:base_uri]
      options[:format]   ||= :json
      options.each do |k,v|
        self.class.send k, v
      end
    end


    # Wrappers for the main HTTP verbs

    def get(path, options={})
      http_verb :get, path, options
    end

    def post(path, options={})
      http_verb :post, path, options
    end

    def put(path, options={})
      http_verb :put, path, options
    end

    def delete(path, options={})
      http_verb :delete, path, options
    end

    def self.whitelisted_cert_store
      @@cert_store ||= build_whitelisted_cert_store
    end

    def self.build_whitelisted_cert_store
      path = File.expand_path(File.join(File.dirname(__FILE__), 'ca-oklink.cer'))

      certs = [ [] ]
      File.readlines(path).each{|line|
        next if ["\n","#"].include?(line[0])
        certs.last << line
        certs << [] if line == "-----END CERTIFICATE-----\n"
      }

      result = OpenSSL::X509::Store.new

      certs.each{|lines|
        next if lines.empty?
        cert = OpenSSL::X509::Certificate.new(lines.join)
        result.add_cert(cert)
      }

      result
    end

    def ssl_options
      { verify: true, cert_store: self.class.whitelisted_cert_store }
    end

    def http_verb(verb, path, options={})

      nonce = options[:nonce] || (Time.now.to_f * 1e6).to_i
      url = WEB_URI[0..-2] + @base_uri + path 
      request_options = {}
      hmac_message = nonce.to_s + @base_uri + path
      if [:get, :delete, :put].include? verb
        url = "#{url}?#{URI.encode_www_form(options)}" if !options.empty?
      else
        if !options.empty?
            request_options = {body: options.to_json} 
            hmac_message = hmac_message + options.to_json
        end
      end

      signature = OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new('sha256'), @api_secret, hmac_message)

      headers = {
        'KEY' => @api_key,
        'SIGNATURE' => signature,
        'NONCE' => nonce.to_s,
        "Content-Type" => "application/json",
      }

      request_options[:headers] = headers
      
      r = self.class.send(verb, url, request_options)
      hash = Hashie::Mash.new(JSON.parse(r.body))
      raise Error.new(hash.error) if hash.error
      raise Error.new(hash.errors.join(", ")) if hash.errors
      hash
    end

    class Error < StandardError; end

    include APIOklink
  end
end