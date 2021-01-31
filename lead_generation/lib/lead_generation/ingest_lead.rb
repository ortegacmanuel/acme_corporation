module LeadGeneration
  class IngestLead < Command
    attribute :lead_id, Types::UUID
    attribute :full_name, Types::String
    attribute :email, Types::String
    attribute :phone_number, Types::String
    attribute :source_id, Types::Coercible::Integer

    alias :aggregate_id :lead_id
  end
end