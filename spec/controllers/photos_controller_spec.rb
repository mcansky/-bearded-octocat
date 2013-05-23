require 'spec_helper'

describe PhotosController do
  describe "index" do
    it "should exist as action" do
      expect { get :index }.to_not raise_error AbstractController::ActionNotFound
    end
    it "should have its template" do
      expect { get :index }.to_not raise_error ActionView::MissingTemplate
    end
    it "should return a 200" do
      get :index
      response.status.should eq 200
    end
    it "should have @photos object" do
      get :index
      assigns(:photos).should_not eq nil
    end
    it "should have @photos array" do
      get :index
      assigns(:photos).class.should eq Array
    end
  end
end