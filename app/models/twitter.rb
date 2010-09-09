require 'oauth_active_resource'

module Twitter
  def self.table_name_prefix
    'twitter_'
  end

  def self.consumer
    @@consumer ||= OAuth::Consumer.new('VW0bNP19ZFhA5k1tW3RhA',
                                       'HSrt4RcTESzW0Z2XPVS2N7tWoznmB9aT96jBTjCrsI', 
                                       { :site => self.site })
  end

  def self.site
    'http://api.twitter.com'
  end

  def self.prefix
    '/1/'
  end
end
