module LeadGeneration
  class Lead
    include AggregateRoot

    MissingSource = Class.new(StandardError)

    def initialize(id)
      @id = id
      @status = :draft
    end

    def ingest(full_name, email, phone_number, source_id)
      raise MissingSource unless source_id
      apply LeadIngested.new(data: {
        lead_id: @id,
        full_name: full_name,
        email: email,
        phone_number: phone_number,
        source_id: source_id}
      )
    end

    on LeadIngested do |event|
      @status = :new_lead
      @full_name = event.data[:full_name]
      @email = event.data[:email]
      @phone_number = event.data[:phone_number]
      @source_id = event.data[:source_id]
    end    

  end
end