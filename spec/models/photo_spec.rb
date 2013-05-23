require 'spec_helper'

describe Photo do
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
      let(:image_path) { "#{Rails.root}/tmp/photo.jpg" }
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
end