require 'rails_helper'

RSpec.describe "Rooms", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/rooms/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/rooms/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get "/rooms/edit"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /destroy" do
    it "returns http success" do
      get "/rooms/destroy"
      expect(response).to have_http_status(:success)
    end
  end

end
