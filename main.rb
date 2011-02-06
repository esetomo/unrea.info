require 'bundler'
Bundler.require

yaml = YAML.load_file(::File.expand_path('../config/app.yml', __FILE__))

Twitter.configure do |config|
  yaml['twitter'].each do |key, val|
    config.send("#{key}=", val)
  end

  if ENV['APIGEE_TWITTER_API_ENDPOINT']
    config.endpoint = 'http://' + ENV['APIGEE_TWITTER_API_ENDPOINT'] + "/1"
    config.search_endpoint = 'http://' + ENV['APIGEE_TWITTER_SEARCH_API_ENDPOINT']
  end
end

class SimpleOAuth::Header
  def initialize_with_signature_url(method, url, params, oauth = {})
    url = url.dup
    url.host = 'api.twitter.com'
    initialize_without_signature_url(method, url, params, oauth)
  end

  alias_method_chain :initialize, :signature_url
end

enable :sessions

before do
  if session[:access_token]
    @twitter = Twitter::Client.new(:oauth_token => session[:access_token],
                                   :oauth_token_secret => session[:access_token_secret])
  else
    @twitter = nil
  end
end

helpers do
  def base_url
    @base_url ||= "#{request.env['rack.url_scheme']}://#{request.env['HTTP_HOST']}"
  end
end

get '/' do
  erb :index
end

def signing_consumer
  @signing_consumer ||= OAuth::Consumer.new(Twitter.options[:consumer_key],
                                            Twitter.options[:consumer_secret],
                                            :site => 'https://api.twitter.com',
                                            :authorize_url => 'https://api.twitter.com/oauth/authorize')
end

get '/login' do
  request_token = signing_consumer.get_request_token(:oauth_callback => "#{base_url}/callback")
  session[:request_token] = request_token.token
  session[:request_token_secret] = request_token.secret
  redirect request_token.authorize_url      
end

get '/callback' do
  request_token = OAuth::RequestToken.new(signing_consumer,
                                          session[:request_token],
                                          session[:request_token_secret])
  @access_token = request_token.get_access_token({},
                                                 :oauth_token => params[:oauth_token],
                                                 :oauth_verifier => params[:oauth_verifier])
  session[:access_token] = @access_token.token
  session[:access_token_secret] = @access_token.secret
  redirect '/'
end

get '/logout' do
  session[:access_token] = nil
  session[:access_token_secret] = nil
  redirect '/'
end
