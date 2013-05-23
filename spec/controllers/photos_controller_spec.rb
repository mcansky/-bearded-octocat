require 'spec_helper'

describe PhotosController do
  describe "index" do
    it "should give a 200" do
      get :index
      response.status.should eq 200
    end
  end
end