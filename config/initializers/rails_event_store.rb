require 'rails_event_store'
require 'aggregate_root'
require 'arkency/command_bus'

Rails.configuration.to_prepare do
  Rails.configuration.event_store = RailsEventStore::Client.new
  Rails.configuration.command_bus = Arkency::CommandBus.new

  AggregateRoot.configure do |config|
    config.default_event_store = Rails.configuration.event_store
  end

  # Subscribe event handlers below
  Rails.configuration.event_store.tap do |store|
    # store.subscribe(InvoiceReadModel.new, to: [InvoicePrinted])
    # store.subscribe(lambda { |event| SendOrderConfirmation.new.call(event) }, to: [OrderSubmitted])
    # store.subscribe_to_all_events(lambda { |event| Rails.logger.info(event.event_type) })

    store.subscribe_to_all_events(RailsEventStore::LinkByEventType.new)
    store.subscribe_to_all_events(RailsEventStore::LinkByCorrelationId.new)
    store.subscribe_to_all_events(RailsEventStore::LinkByCausationId.new)

    # Leads Read Models
    store.subscribe(Leads::OnLeadIngested, to: [LeadGeneration::LeadIngested])
    store.subscribe(Leads::OnLeadQualified, to: [LeadGeneration::LeadQualified])
  end

  # Register command handlers below
  Rails.configuration.command_bus.tap do |bus|
    bus.register(LeadGeneration::IngestLead, LeadGeneration::OnLeadIngested.new)
    bus.register(LeadGeneration::QualifyLead, LeadGeneration::OnLeadQualified.new)
  end
end
