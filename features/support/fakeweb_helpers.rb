module FakewebHelpers
  # Make sure nothing gets out (IMPORTANT)
  FakeWeb.allow_net_connect = false

  Net::HTTP.http_logger_options = {:verbose => true}
  Net::HTTP.http_logger = Logger.new(Rails.root.to_s + '/log/http.log')

  # Turns a fixture file name into a full path
  def fixture_file(filename)
    return '' if filename == ''
    File.expand_path(Rails.root.to_s + '/features/fixtures/' + filename)
  end

  # Convenience methods for stubbing URLs to fixtures
  def stub_get(url, filename)
    FakeWeb.register_uri(:get, url, :response => fixture_file(filename))
  end

  def stub_post(url, filename)
    FakeWeb.register_uri(:post, url, :response => fixture_file(filename))
  end

=begin
  def stub_any(url, filename)
    FakeWeb.register_uri(:any, url, :response => fixture_file(filename))
  end
=end
end

World(FakewebHelpers)
