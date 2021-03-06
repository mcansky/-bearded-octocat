require 'spec_helper'

describe Photo do
  after :each do
    Photo.destroy_all
  end
  describe "basics" do
    # attributes
    it { should respond_to(:desc) }
    it { should respond_to(:image) }
    it { should respond_to(:score) }
    # methods
    it { should respond_to(:url) }
    it { should respond_to(:score_up) }
    it { should respond_to(:age) }
    it { should respond_to(:young?) }
    it { should respond_to(:old?) }
  end
  context "blank photo" do
    let(:photo) { FactoryGirl.create(:photo) }
    describe "init" do
      it "should have a string as desc" do
        photo.desc.class.should eq String
      end
      it "should have an age in seconds" do
        photo.age.class.should eq Float
      end
      it "should have an Integer score" do
        photo.score.class.should eq Fixnum
      end
      it "should not have an image yet" do
        photo.image.blank?.should be_true
      end
      it "should return empty string on url method" do
        photo.url.should eq nil
      end
    end
    describe "upload" do
      let(:image_path) { "#{Rails.root}/app/assets/images/photo.jpg" }
      before :each do
        photo.image = File.open(image_path)
      end
      it "should have a photo when one is save" do
        photo.image.blank?.should be_false
      end
      it "should return image url when url method is called" do
        photo.url.should eq photo.image.url
      end
    end
    describe "score" do
      it "should have its score changed" do
        photo.score_up
        photo.reload
        photo.score.should eq 1
      end
    end
    describe "age, initially" do
      it "should be young initially" do
        photo.young?.should be_true
      end
      it "should not be old initially" do
        photo.old?.should be_false
      end
    end
  end
  context "old photo" do
    let(:photo) { FactoryGirl.create(:photo) }
    before :each do
      photo.created_at = Time.now
      Timecop.freeze(Time.now + 7.days + 10)
    end
    it "should not be young after 7 days and 10 sec" do
      photo.young?.should be_false
    end
    it "should be old after 7 days and 10 sec" do
      photo.old?.should be_true
    end
  end
  context "old and new together, scopes" do
    let!(:young_photo) { FactoryGirl.create(:photo) }
    let!(:old_photo) { FactoryGirl.create(:old_photo) }
    it "should not return old ones" do
      Photo.young.include?(old_photo).should be_false
    end
    it "should return only young ones" do
      Photo.young.include?(young_photo).should be_true
    end
  end
  context "sorted photos" do
    let!(:low_photo1) { FactoryGirl.create(:photo) }
    let!(:top_photo) { FactoryGirl.create(:photo) }
    let!(:low_photo2) { FactoryGirl.create(:photo) }
    let!(:old_photo) { FactoryGirl.create(:old_photo) }
    before :each do
      5.times { top_photo.score_up }
      2.times { low_photo1.score_up }
    end
    it "should return only young ones" do
      Photo.sorted_young.count.should eq 3
    end
    it "should have top photo as first" do
      Photo.sorted_young.first.should eq top_photo
    end
    it "should have low_photo2 as last" do
      Photo.sorted_young.last.should eq low_photo2
    end
  end
end