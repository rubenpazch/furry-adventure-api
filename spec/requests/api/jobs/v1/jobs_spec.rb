require "rails_helper"

RSpec.describe "should validate jobs actions", type: :request do
  before(:all) do 
    @new_organization = create(:organization)
    @new_job = build(:job)
    @new_job.job_organization_id = @new_organization.id
    @new_job.save
  end 
  
  describe "index" do
    it "should return list of jobs" do
      headers = { "ACCEPT" => "application/json" }
      get "/api/jobs/v1/jobs"
      expect(response).to have_http_status(:ok)
      json_response = JSON.parse(response.body)
      expect(json_response.length.to_i).to equal(1)
    end
  end
end
