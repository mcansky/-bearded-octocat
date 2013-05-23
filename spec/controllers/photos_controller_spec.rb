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
    let!(:photo) { FactoryGirl.create(:photo) }
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
      assigns(:photos).first.id.should eq young_photo.id
    end
  end
  describe "content sorting with score" do
    let!(:low_photo1) { FactoryGirl.create(:photo) }
    let!(:top_photo) { FactoryGirl.create(:photo) }
    let!(:low_photo2) { FactoryGirl.create(:photo) }
    let!(:old_photo) { FactoryGirl.create(:old_photo) }
    before :each do
      5.times { top_photo.score_up }
      2.times { low_photo1.score_up }
      get :index
    end
    subject { assigns(:photos) }
    its(:count) { should eq 3 }
    its(:first) { should eq top_photo }
    its(:last) { should eq low_photo2 }
  end
  describe "score up" do
    let!(:low_photo1) { FactoryGirl.create(:photo) }
    let!(:top_photo) { FactoryGirl.create(:photo) }
    let!(:low_photo2) { FactoryGirl.create(:photo) }
    let!(:old_photo) { FactoryGirl.create(:old_photo) }
    before :each do
      2.times { top_photo.score_up }
      1.times { low_photo1.score_up }
      get :index
    end
    subject { assigns(:photos) }
    its(:first) { should eq top_photo }
    it "should change order after a put" do
      2.times { put :update, :id => low_photo1.id }
      get :index
      assigns(:photos).first.should eq low_photo1
    end
  end
end