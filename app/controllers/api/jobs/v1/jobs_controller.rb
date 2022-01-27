class Api::Jobs::V1::JobsController < ApplicationController
  def index
    byebug
    render json: Jobs.all, status: :ok
  end
end