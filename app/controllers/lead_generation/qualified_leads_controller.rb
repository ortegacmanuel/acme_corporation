class LeadGeneration::QualifiedLeadsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @leads = Leads::Lead.all
  end
  
  def create
    cmd = LeadGeneration::QualifyLead.new(
      lead_id: params[:id],
      type_of_job: params[:type_of_job],
      number_of_rooms: params[:number_of_rooms],
      timeframe: params[:timeframe], 
      appointment_date_Time: params[:appointment_date_Time]
    )
    Rails.configuration.command_bus.call(cmd)
    head :ok
  end
  
end