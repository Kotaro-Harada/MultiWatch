require 'rails_helper'

RSpec.describe "Whispers", type: :request do
  describe "GET /new" do
    it "returns http success" do
      get "/whispers/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/whispers/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /destroy" do
    it "returns http success" do
      get "/whispers/destroy"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/whispers/show"
      expect(response).to have_http_status(:success)
    end
  end

end
