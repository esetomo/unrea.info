require 'bundler'
Bundler.require

Twitter.configure do |config|
  config.consumer_key = 'tYGPFKb527dlTha1YXzw'
  config.consumer_secret = 'MoLVVdeVvBFPyNexl3DRo2p9SxA3O2gf2YGw4vdoeM'
  config.endpoint = 'http://APIGEE_TWITTER_API_ENDPOINT'
  config.search_endpoint = 'http://APIGEE_TWITTER_SEARCH_API_ENDPOINT'
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
