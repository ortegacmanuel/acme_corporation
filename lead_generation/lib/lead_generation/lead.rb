module LeadGeneration
  class Lead
    include AggregateRoot

    MissingSource = Class.new(StandardError)
    NotIngested = Class.new(StandardError)
    AlreadyQualified = Class.new(StandardError)

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

    def qualify(type_of_job, number_of_rooms, timeframe, appointment_date_Time)
      raise NotIngested if @status.equal?(:draft)
      raise AlreadyQualified if @status.equal?(:qualified)
      apply LeadQualified.new(data: {
        lead_id: @id,
        number_of_rooms: number_of_rooms,
        type_of_job: type_of_job,
        timeframe: timeframe,
        appointment_date_Time: appointment_date_Time}
      )
    end

    on LeadIngested do |event|
      @status = :new_lead
      @full_name = event.data[:full_name]
      @email = event.data[:email]
      @phone_number = event.data[:phone_number]
      @source_id = event.data[:source_id]
    end
    
    on LeadQualified do |event|
      @status = :qualified
      @number_of_rooms = event.data[:number_of_rooms]
      @type_of_job = event.data[:type_of_job]
      @timeframe = event.data[:timeframe]
      @appointment_date_Time = event.data[:appointment_date_Time]
    end

  end
end