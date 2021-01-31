module LeadGeneration
  class LeadIngested < Event
    attribute :lead_id, Types::UUID
    attribute :full_name, Types::String
    attribute :email, Types::String
    attribute :phone_number, Types::String
    attribute :source_id, Types::ID
  end
end