require 'rails_helper'

RSpec.describe "Friendships", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/friendship/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/friendship/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "returns http success" do
      get "/friendship/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /destroy" do
    it "returns http success" do
      get "/friendship/destroy"
      expect(response).to have_http_status(:success)
    end
  end

end
