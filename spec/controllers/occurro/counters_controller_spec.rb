require 'spec_helper'

module Occurro
  describe CountersController do
    let(:dummy) { FactoryGirl.create(:dummy_item) }

    context "Unique visitor" do
      it "should add the visitor to CachedSession and increment the counter" do
        session["occurro"] = nil
        DummyItem.any_instance.should_receive(:increment_counter)
        Occurro::CachedSession.should_receive(:add_cache).with(dummy, session)
        get :increment, countable_type: dummy.class.name, countable_id: dummy.id, format: 'js'
      end
    end

    context "Returning visitor" do
      it "should not add the visitor to the CachedSession nor increment the counter" do
        session["occurro"] = { "#{dummy.class.name}" => { "#{dummy.id}" => true } }
        DummyItem.any_instance.should_receive(:increment_counter).never
        Occurro::CachedSession.should_receive(:add_cache).with(dummy, session).never
        get :increment, countable_type: dummy.class.name, countable_id: dummy.id, format: 'js'
      end
    end

  end
end
