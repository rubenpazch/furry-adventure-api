# frozen_string_literal: true

class PersonSerializer
  include JSONAPI::Serializer
  attributes :first_name, :last_name, :doc_id, :address, :cell_phone, :contact_phone
end
