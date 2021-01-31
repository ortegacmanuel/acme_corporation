module LeadGeneration
  class OnLeadQualified
    include CommandHandler

    def initialize()
    end

    def call(command)
      with_aggregate(Lead, command.aggregate_id) do |lead|
        lead.qualify( 
          command.type_of_job, 
          command.number_of_rooms, 
          command.timeframe,
          command.appointment_date_Time
        )
      end
    end
  end
end
