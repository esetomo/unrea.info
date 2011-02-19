require 'spec_helper'

describe AppearancesController do
  describe "GET image" do
    get :image
    response.should be_success
  end
end
