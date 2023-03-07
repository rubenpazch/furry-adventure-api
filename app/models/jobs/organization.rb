# frozen_string_literal: true

module Jobs
  class Organization < ActiveRecord::Base
    self.table_name = 'job_organizations'
  end
end
