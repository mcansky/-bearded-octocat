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
end