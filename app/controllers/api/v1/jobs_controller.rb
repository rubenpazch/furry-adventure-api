# frozen_string_literal: true

module Api
  module V1
    class JobsController < ApplicationController
      def index
        render json: Job.all, status: :ok
      end
    end
  end
end
