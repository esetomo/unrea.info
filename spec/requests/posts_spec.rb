require 'spec_helper'

describe "Posts" do
  describe "GET /posts" do
    it "works! (now write some real specs)" do
      visit posts_path
      response.status.should be(200)
    end
  end
end