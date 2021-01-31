class LeadGeneration::LeadsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @leads = Leads::Lead.all
  end
  
  def create
    cmd = LeadGeneration::IngestLead.new(
      lead_id: SecureRandom.uuid,
      full_name: params[:full_name],
      email: params[:email],
      phone_number: params[:phone_number], 
      source_id: params[:source_id]
    )
    Rails.configuration.command_bus.call(cmd)
    head :ok
  end
  
end