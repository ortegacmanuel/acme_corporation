module LeadGeneration
  class QualifyLead < Command
    attribute :lead_id, Types::UUID
    attribute :type_of_job, Types::String
    attribute :number_of_rooms, Types::Strict::Integer
    attribute :timeframe, Types::String
    attribute :appointment_date_Time, Types::String

    alias :aggregate_id :lead_id
  end
end