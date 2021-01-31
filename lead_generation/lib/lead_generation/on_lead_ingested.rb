module LeadGeneration
  class OnLeadIngested
    include CommandHandler

    def initialize()
    end

    def call(command)
      with_aggregate(Lead, command.aggregate_id) do |lead|
        lead.ingest(command.full_name, command.email, command.phone_number, command.source_id)
      end
    end
  end
end
