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
  end
  describe "process" do
    let(:photo) { FactoryGirl.create(:photo) }
    it "should have a string as desc" do
      photo.desc.class.should eq String
    end
    it "should have an age in seconds" do
      photo.age.class.should eq Float
    end
    it "should have an Integer score" do
      photo.score.class.should eq Fixnum
    end
  end
end