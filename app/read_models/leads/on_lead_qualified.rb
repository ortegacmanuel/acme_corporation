module Leads
  class OnLeadQualified
    def call(event)
      lead = Lead.find_by(uid: event.data[:lead_id])
      lead.update(status: "Qualified")
    end
  end
end