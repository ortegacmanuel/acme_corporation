module Leads
  class OnLeadIngested
    def call(event)
      source = "Fake Source" # Source.find(event.data[:source_id])
      Lead.create!(
        uid: event.data[:lead_id],
        status: "New Lead",
        full_name: event.data[:full_name],
        email: event.data[:email],
        phone_number: event.data[:phone_number],
        source: source
      )
    end
  end
end