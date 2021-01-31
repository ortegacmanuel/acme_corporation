module LeadGeneration
  class LeadQualified < Event
    attribute :lead_id, Types::UUID
    attribute :type_of_job, Types::String
    attribute :number_of_rooms, Types::Strict::Integer
    attribute :timeframe, Types::String
    attribute :appointment_date_Time, Types::String
  end
end