require 'spec_helper'

describe PhotosController do
  after :each do
    Photo.destroy_all
  end
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
  describe "content sorting" do
    let!(:young_photo) { FactoryGirl.create(:photo) }
    let!(:old_photo) { FactoryGirl.create(:old_photo) }
    before :each do
      get :index
    end
    it "should only list 1 photo" do
      assigns(:photos).count.should eq 1
    end
    it "should only display the young photos" do
      assigns(:photos).first.id.should eq young.id
    end
  end
end