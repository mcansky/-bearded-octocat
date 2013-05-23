require 'spec_helper'

describe PhotosController do
  describe "index" do
    it "should exist as action" do
      expect { get :index }.to_not raise_error AbstractController::ActionNotFound
    end
    it "should have its template" do
      expect { get :index }.to_not raise_error ActionView::MissingTemplate
    end
  end
  describe "content check" do
    before :each do
      get :index
    end
    it "should return a 200" do
      response.status.should eq 200
    end
    it "should have @photos object" do
      assigns(:photos).should_not eq nil
    end
    it "should have @photos array" do
      assigns(:photos).class.should eq Array
    end
    it "should have Photo elements in @photos" do
      assigns(:photos).first.class.should eq Photo
    end
  end
end