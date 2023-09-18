require_relative '../../../app/services/events/creator'
describe Events::Creator do 
  let(:event_repository) { double(:event_repository, new: event) }
  let(:service) { Events::Creator.new(event_repository) }
  let(:callback) do
    { on_success: ->(event) { 'success' },
      on_failure: ->(event) { 'failure' } }
  end

  context 'on success creates an event' do
    let(:event) { double(:event, save: true) }
    it 'should display a success message' do
      service.perform({ name: 'event' }, callback).should == 'success'
    end
  end

  context 'on failure display error message' do
    let(:event) { double(:event, save: false) }
    it 'should display a failure message' do
      service.perform({ name: 'event' }, callback).should == 'failure'
    end
  end

end
